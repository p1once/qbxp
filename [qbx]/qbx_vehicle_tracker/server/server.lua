local tracked = {}

local function normalizePlate(plate)
    if not plate then return nil end
    return string.upper((plate:gsub('%s+', '')))
end

exports('IsTrackedPlate', function(plate)
    plate = normalizePlate(plate)
    return tracked[plate] ~= nil
end)

exports('GetTrackedCoords', function(plate)
    plate = normalizePlate(plate)
    local info = tracked[plate]
    if not info then return nil end
    if info.netId then
        local ent = NetworkGetEntityFromNetworkId(info.netId)
        if ent and DoesEntityExist(ent) then
            local coords = GetEntityCoords(ent)
            info.last = coords
            info.lastTick = os.time()
            return coords
        end
    end
    return info.last
end)

lib.callback.register('qbx_vehicle_tracker:server:install', function(source, plate, netId)
    if type(plate) ~= 'string' or type(netId) ~= 'number' then return false, 'Paramètres invalides.' end
    plate = normalizePlate(plate)

    if tracked[plate] then
        return false, 'Un traqueur est déjà installé sur ce véhicule.'
    end

    local ent = NetworkGetEntityFromNetworkId(netId)
    if not ent or not DoesEntityExist(ent) then
        return false, 'Véhicule invalide.'
    end

    tracked[plate] = {
        netId = netId,
        installedBy = source,
        installedAt = os.time(),
        last = GetEntityCoords(ent),
    }

    return true
end)

lib.callback.register('qbx_vehicle_tracker:server:getTrackedVehiclePosition', function(source, plate)
    plate = normalizePlate(plate)
    if not tracked[plate] then return nil end

    local info = tracked[plate]
    if not info then return nil end
    local coords
    if info.netId then
        local ent = NetworkGetEntityFromNetworkId(info.netId)
        if ent and DoesEntityExist(ent) then
            coords = GetEntityCoords(ent)
            info.last = coords
            info.lastTick = os.time()
        end
    end
    coords = coords or info.last
    return coords and { x = coords.x, y = coords.y, z = coords.z } or nil
end)

lib.callback.register('qbx_vehicle_tracker:server:list', function(source)
    local out = {}
    for plate, info in pairs(tracked) do
        local coords
        if info.netId then
            local ent = NetworkGetEntityFromNetworkId(info.netId)
            if ent and DoesEntityExist(ent) then
                coords = GetEntityCoords(ent)
                info.last = coords
                info.lastTick = os.time()
            end
        end
        coords = coords or info.last
        out[#out+1] = {
            plate = plate,
            x = coords and coords.x or nil,
            y = coords and coords.y or nil,
            z = coords and coords.z or nil,
            installedAt = info.installedAt,
            net = info.netId and true or false,
        }
    end
    table.sort(out, function(a,b) return (a.installedAt or 0) > (b.installedAt or 0) end)
    return out
end)

AddEventHandler('entityRemoved', function(entity)
    if not DoesEntityExist(entity) then return end
    if GetEntityType(entity) ~= 2 then return end
    -- if a tracked vehicle entity is removed, keep last known position but clear netId
    for plate, info in pairs(tracked) do
        if info.netId then
            local ent = NetworkGetEntityFromNetworkId(info.netId)
            if ent == entity then
                info.netId = nil
                break
            end
        end
    end
end)
