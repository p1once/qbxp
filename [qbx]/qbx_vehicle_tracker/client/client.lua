local function getClosestVehicle(coords, radius)
    local vehicles = GetGamePool('CVehicle')
    local closest, closestDist
    for i = 1, #vehicles do
        local veh = vehicles[i]
        if DoesEntityExist(veh) then
            local dist = #(GetEntityCoords(veh) - coords)
            if dist <= radius and (not closestDist or dist < closestDist) then
                closest = veh
                closestDist = dist
            end
        end
    end
    return closest, closestDist
end

local function findTargetVehicle()
    local ped = cache?.ped or PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    if veh ~= 0 then return veh end
    local coords = GetEntityCoords(ped)
    local found, dist = getClosestVehicle(coords, 4.5)
    return found
end

local function canInstallOnVehicle(vehicle)
    if not vehicle or vehicle == 0 then return false end
    if not DoesEntityExist(vehicle) then return false end
    -- ignore bicycles
    local class = GetVehicleClass(vehicle)
    return class ~= 13
end

exports('useTracker', function(item, slot)
    local vehicle = findTargetVehicle()
    if not canInstallOnVehicle(vehicle) then
        lib.notify({ type = 'error', title = 'Traqueur GPS', description = 'Aucun véhicule valide à proximité.' })
        return false
    end

    local plate = qbx and qbx.getVehiclePlate(vehicle) or GetVehicleNumberPlateText(vehicle)
    if not plate or plate == '' then
        lib.notify({ type = 'error', title = 'Traqueur GPS', description = 'Impossible de lire la plaque.' })
        return false
    end

    local ok = lib.progressBar({
        duration = 4500,
        label = 'Installation du traqueur...',
        useWhileDead = false,
        canCancel = true,
        disable = { move = true, car = true, combat = true },
        anim = { dict = 'mini@repair', clip = 'fixing_a_ped' },
    })

    if not ok then return false end

    local netId = NetworkGetNetworkIdFromEntity(vehicle)

    local installed, reason = lib.callback.await('qbx_vehicle_tracker:server:install', false, plate, netId)
    if not installed then
        lib.notify({ type = 'error', title = 'Traqueur GPS', description = reason or 'Installation impossible.' })
        return false
    end

    lib.notify({ type = 'success', title = 'Traqueur GPS', description = ('Traqueur installé sur %s'):format(plate) })
    return true -- allow ox_inventory to consume the item
end)

RegisterNetEvent('qbx_vehicle_tracker:client:markWaypoint', function(coords, plate)
    if coords then
        SetNewWaypoint(coords.x + 0.0, coords.y + 0.0)
        lib.notify({ title = 'Traqueur GPS', description = ('Position du véhicule %s marquée sur le GPS.'):format(plate), duration = 5000 })
    else
        lib.notify({ type = 'error', title = 'Traqueur GPS', description = 'Véhicule introuvable.' })
    end
end)

