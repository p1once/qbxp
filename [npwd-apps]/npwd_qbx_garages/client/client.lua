local function findVehFromPlateAndLocate(plate)
	local gameVehicles = GetGamePool('CVehicle')
	for i = 1, #gameVehicles do
		local vehicle = gameVehicles[i]
		if DoesEntityExist(vehicle) then
			if qbx.getVehiclePlate(vehicle) == plate then
				local vehCoords = GetEntityCoords(vehicle)
				SetNewWaypoint(vehCoords.x, vehCoords.y)
				return true
			end
		end
	end
end

RegisterNUICallback("npwd:qbx_garage:getVehicles", function(_, cb)
	local vehicles = lib.callback.await('npwd_qbx_garages:server:getPlayerVehicles', false)
	for _, v in pairs(vehicles) do
		v.type = "car"
		local type = GetVehicleClassFromName(v.model)
		if type == 15 or type == 16 then
			v.type = "aircraft"
		elseif type == 14 then
			v.type = "boat"
		elseif type == 13 or type == 8 then
			v.type = "bike"
		else
			v.type = "car"
		end
	end

	cb({ status = "ok", data = vehicles })
end)

RegisterNUICallback("npwd:qbx_garage:requestWaypoint", function(data, cb)
	-- 1) Try server-side tracker position (works anywhere if a tracker is installed)
	local coords = lib.callback.await('qbx_vehicle_tracker:server:getTrackedVehiclePosition', false, data.plate)
	if coords then
		SetNewWaypoint(coords.x, coords.y)
		exports.npwd:createNotification({
			notisId = 'npwd:qbx_garage:requestWaypoint',
			appId = 'npwd_qbx_garages',
			content = locale('notification.marked'),
			keepOpen = false,
			duration = 5000,
			path = '/npwd_qbx_garages',
		})
		cb({})
		return
	end

	-- 2) If the vehicle is stored inside a garage, point to the garage entrance
	if data.state == 'garaged' and type(data.garageCoords) == 'table' and data.garageCoords.x and data.garageCoords.y then
		SetNewWaypoint(data.garageCoords.x + 0.0, data.garageCoords.y + 0.0)
		exports.npwd:createNotification({
			notisId = 'npwd:qbx_garage:requestWaypoint',
			appId = 'npwd_qbx_garages',
			content = locale('notification.marked'),
			keepOpen = false,
			duration = 5000,
			path = '/npwd_qbx_garages',
		})
		cb({})
		return
	end

	-- 3) Fallback to local search if vehicle is streamed-in (no tracker and not stored)
	local ok = findVehFromPlateAndLocate(data.plate)
	exports.npwd:createNotification({
		notisId = 'npwd:qbx_garage:requestWaypoint',
		appId = 'npwd_qbx_garages',
		content = ok and locale('notification.marked') or locale('notification.cannot_locate'),
		keepOpen = false,
		duration = 5000,
		path = '/npwd_qbx_garages',
	})
	cb({})
end)

RegisterNUICallback("npwd:qbx_garage:deleteVehicle", function(data, cb)
	if type(data.plate) ~= 'string' or data.plate == '' then
		cb({ status = "error" })
		return
	end

	local success = lib.callback.await('npwd_qbx_garages:server:deleteVehicle', false, data.plate)

	exports.npwd:createNotification({
		notisId = 'npwd:qbx_garage:deleteVehicle',
		appId = 'npwd_qbx_garages',
		content = success and locale('notification.deleted') or locale('notification.delete_failed'),
		keepOpen = false,
		duration = 5000,
		path = '/npwd_qbx_garages',
	})

	cb({
		status = success and "ok" or "error"
	})
end)
