lib.versionCheck('Qbox-project/npwd_qbx_garages')
assert(GetResourceState('qbx_garages') == 'started', 'qbx_garages is not started')

local garageConfig

local function fetchGarageConfig()
	local ok, garages = pcall(function()
		return exports.qbx_garages:GetGarages()
	end)

	if ok and type(garages) == 'table' then
		return garages
	end

	-- If qbx_garages is still booting, retry a few times asynchronously
	CreateThread(function()
		for _ = 1, 5 do
			Wait(1000)
			ok, garages = pcall(function()
				return exports.qbx_garages:GetGarages()
			end)
			if ok and type(garages) == 'table' then
				garageConfig = garages
				return
			end
		end

		lib.print.warn('[npwd_qbx_garages] Unable to fetch garages from qbx_garages after multiple attempts.')
	end)

	return garageConfig or {}
end

garageConfig = fetchGarageConfig()
local VEHICLES = exports.qbx_core:GetVehiclesByName()

lib.callback.register('npwd_qbx_garages:server:getPlayerVehicles', function(source)
	local player = exports.qbx_core:GetPlayer(source)
	if not player then return {} end

	local result = MySQL.query.await('SELECT * FROM player_vehicles WHERE citizenid = ?', { player.PlayerData.citizenid })
	for i = 1, #result do
		local vehicleData = result[i]
		local model = vehicleData.vehicle

		vehicleData.model = model
		vehicleData.vehicle = 'Unknown'
		vehicleData.brand = 'Vehicle'

		local garageName = vehicleData.garage
		local garageInfo = garageConfig[garageName]

		if vehicleData.state == 0 then
			vehicleData.state = 'out'
		elseif vehicleData.state == 1 then
			vehicleData.state = 'garaged'
		elseif vehicleData.state == 2 then
			vehicleData.state = 'impounded'
		else
			vehicleData.state = 'unknown'
		end

		if VEHICLES[model] then
			vehicleData.vehicle = VEHICLES[model].name
			vehicleData.brand = VEHICLES[model].brand
		end

		if garageInfo then
			vehicleData.garageName = garageName
			local accessPoint = garageInfo.accessPoints and garageInfo.accessPoints[1]
			if accessPoint and accessPoint.coords then
				vehicleData.garageCoords = {
					x = accessPoint.coords.x + 0.0,
					y = accessPoint.coords.y + 0.0,
					z = accessPoint.coords.z + 0.0
				}
			end
			vehicleData.garage = garageInfo.label
			vehicleData.garageLabel = garageInfo.label
		else
			vehicleData.garage = locale('states.garage_unknown')
			vehicleData.garageLabel = vehicleData.garage
		end
	end

	return result
end)

lib.callback.register('npwd_qbx_garages:server:deleteVehicle', function(source, plate)
	if type(plate) ~= 'string' or plate == '' then return false end

	local player = exports.qbx_core:GetPlayer(source)
	if not player then return false end

	local vehicle = MySQL.single.await('SELECT id FROM player_vehicles WHERE plate = ? AND citizenid = ?', {
		plate,
		player.PlayerData.citizenid
	})
	if not vehicle then return false end

	exports.qbx_vehicles:DeletePlayerVehicles('vehicleId', vehicle.id)
	return true
end)

AddEventHandler('onResourceStart', function(resourceName)
	if resourceName == 'qbx_garages' then
		garageConfig = fetchGarageConfig()
	end
end)

AddEventHandler('qbx_garages:server:garageRegistered', function(garageName, newGarageConfig)
	garageConfig[garageName] = newGarageConfig
end)
