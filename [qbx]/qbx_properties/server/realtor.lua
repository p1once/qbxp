local config = require 'config.server'
local sharedConfig = require 'config.shared'

lib.addCommand('createproperty', {
    help = 'Create a property at your current location',
}, function(source)
    local player = exports.qbx_core:GetPlayer(source)

    if player.PlayerData.job.name ~= 'realestate' then exports.qbx_core:Notify(source, 'Not a realtor', 'error') return end

    TriggerClientEvent('qbx_properties:client:createProperty', source)
end)

RegisterNetEvent('qbx_properties:server:createProperty', function(interiorIndex, data, propertyCoords, garageCoords)
    local playerSource = source --[[@as number]]
    local player = exports.qbx_core:GetPlayer(playerSource)
    local playerCoords = GetEntityCoords(GetPlayerPed(playerSource))

    if player.PlayerData.job.name ~= 'realestate' then return end
    if not garageCoords and #(playerCoords - propertyCoords) > 5.0 then return end
    if garageCoords and #(playerCoords - garageCoords.xyz) > 5.0 then return end

    local interactData = {
        {
            type = 'logout',
            coords = sharedConfig.interiors[interiorIndex].logout
        },
        {
            type = 'clothing',
            coords = sharedConfig.interiors[interiorIndex].clothing
        },
        {
            type = 'exit',
            coords = sharedConfig.interiors[interiorIndex].exit
        }
    }

    local stashData = {
        {
            coords = sharedConfig.interiors[interiorIndex].stash,
            slots = config.apartmentStash.slots,
            maxWeight = config.apartmentStash.maxWeight,
        }
    }

    local result = MySQL.single.await('SELECT id FROM properties ORDER BY id DESC', {})
    local propertyNumber = result?.id or 0
    local propertyName = string.format('%s %s', data[1], propertyNumber)

    MySQL.insert('INSERT INTO `properties` (`coords`, `property_name`, `price`, `interior`, `interact_options`, `stash_options`, `rent_interval`, `garage`) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', {
        json.encode(propertyCoords),
        propertyName,
        data[2],
        interiorIndex,
        json.encode(interactData),
        json.encode(stashData),
        data[3],
        garageCoords and json.encode(garageCoords) or nil,
    })
    TriggerClientEvent('qbx_properties:client:addProperty', -1, propertyCoords)
end)

-- Realtor management APIs used by the realestate-tablet
local function isRealtor(src)
    local player = exports.qbx_core:GetPlayer(src)
    return player and player.PlayerData and player.PlayerData.job and player.PlayerData.job.name == 'realestate'
end

lib.callback.register('qbx_properties:callback:getProperty', function(source, propertyId)
    if not isRealtor(source) then return nil end
    if type(propertyId) ~= 'number' then return nil end
    return MySQL.single.await('SELECT id, property_name, price, rent_interval, owner, landlord_cid, coords, keyholders, interior, garage FROM properties WHERE id = ?', { propertyId })
end)

-- Paged listing for tablet UI
lib.callback.register('qbx_properties:callback:listProperties', function(source, opts)
    if not isRealtor(source) then return { items = {}, total = 0 } end
    opts = opts or {}
    local query = tostring(opts.query or '')
    local status = tostring(opts.status or 'all') -- all|owned|unowned
    local minPrice = tonumber(opts.minPrice) or 0
    local maxPrice = tonumber(opts.maxPrice) or 999999999
    local sort = tostring(opts.sort or 'id')
    local order = string.upper(tostring(opts.order or 'ASC')) == 'DESC' and 'DESC' or 'ASC'
    local limit = math.max(1, math.min(tonumber(opts.limit) or 25, 100))
    local offset = math.max(0, tonumber(opts.offset) or 0)
    local rentOnly = opts.rentOnly == true or opts.rentOnly == 'true'

    local sortCol = ({ id = 'id', name = 'property_name', price = 'price', rent_interval = 'rent_interval' })[sort] or 'id'

    local where = { 'price >= ? AND price <= ?' }
    local params = { minPrice, maxPrice }
    if query ~= '' then
        where[#where+1] = 'property_name LIKE ?'
        params[#params+1] = string.format('%%%s%%', query)
    end
    if status == 'owned' then
        where[#where+1] = 'owner IS NOT NULL'
    elseif status == 'unowned' then
        where[#where+1] = 'owner IS NULL'
    end
    if rentOnly then
        where[#where+1] = 'rent_interval IS NOT NULL'
    end

    local whereSql = table.concat(where, ' AND ')
    local sqlList = ('SELECT id, property_name, price, rent_interval, owner, landlord_cid, interior, garage FROM properties WHERE %s ORDER BY %s %s LIMIT ? OFFSET ?'):format(whereSql, sortCol, order)
    local sqlCount = ('SELECT COUNT(1) as c FROM properties WHERE %s'):format(whereSql)
    local listParams = { table.unpack(params) }
    listParams[#listParams+1] = limit
    listParams[#listParams+1] = offset
    local items = MySQL.query.await(sqlList, listParams) or {}
    local tot = MySQL.single.await(sqlCount, params) or { c = 0 }
    return { items = items, total = tot.c }
end)

lib.callback.register('qbx_properties:callback:updateProperty', function(source, payload)
    if not isRealtor(source) then return { ok = false, error = 'forbidden' } end
    if type(payload) ~= 'table' then return { ok = false, error = 'bad_payload' } end
    local id = tonumber(payload.id)
    if not id then return { ok = false, error = 'bad_id' } end

    local fields, params = {}, {}
    if payload.property_name then
        local name = tostring(payload.property_name)
        if #name < 3 or #name > 64 then return { ok = false, error = 'name_length' } end
        fields[#fields+1] = 'property_name = ?'
        params[#params+1] = name
    end
    if payload.price ~= nil then
        local price = tonumber(payload.price) or 0
        if price < 0 then return { ok = false, error = 'bad_price' } end
        fields[#fields+1] = 'price = ?'
        params[#params+1] = price
    end
    if payload.rent_interval ~= nil then
        if payload.rent_interval == false or payload.rent_interval == '' then
            fields[#fields+1] = 'rent_interval = ?'
            params[#params+1] = nil
        else
            local ri = tonumber(payload.rent_interval)
            if not ri or ri < 1 or ri > 720 then return { ok = false, error = 'bad_rent_interval' } end
            fields[#fields+1] = 'rent_interval = ?'
            params[#params+1] = ri
        end
    end

    if #fields == 0 then return { ok = false, error = 'no_fields' } end
    params[#params+1] = id
    local sql = ('UPDATE properties SET %s WHERE id = ?'):format(table.concat(fields, ', '))
    MySQL.update.await(sql, params)
    return { ok = true }
end)

RegisterNetEvent('qbx_properties:server:deleteProperty', function(propertyId)
    local src = source --[[@as number]]
    if not isRealtor(src) then return end
    if type(propertyId) ~= 'number' then return end
    local row = MySQL.single.await('SELECT owner, coords FROM properties WHERE id = ?', { propertyId })
    if not row then return end
    if row.owner ~= nil then
        exports.qbx_core:Notify(src, 'Impossible de supprimer une propriété possédée.', 'error')
        return
    end
    local coords = row.coords and json.decode(row.coords) or nil
    MySQL.query.await('DELETE FROM properties_decorations WHERE property_id = ?', { propertyId })
    MySQL.query.await('DELETE FROM properties WHERE id = ?', { propertyId })
    if coords then
        TriggerClientEvent('qbx_properties:client:removeProperty', -1, vec3(coords.x, coords.y, coords.z))
    end
    exports.qbx_core:Notify(src, 'Propriété supprimée.', 'success')
end)

-- Transfer title (landlord) to target citizenid; does not evict current occupant
lib.callback.register('qbx_properties:callback:transferOwnership', function(source, payload)
    if not isRealtor(source) then return { ok = false, error = 'forbidden' } end
    if type(payload) ~= 'table' then return { ok = false, error = 'bad_payload' } end
    local id = tonumber(payload.id)
    local target = payload.target
    if not id or not target or type(target) ~= 'string' then return { ok = false, error = 'bad_args' } end

    local prop = MySQL.single.await('SELECT owner, landlord_cid FROM properties WHERE id = ?', { id })
    if not prop then return { ok = false, error = 'not_found' } end

    -- Validate target citizenid exists
    local offline = exports.qbx_core:GetOfflinePlayer(target)
    if not offline then return { ok = false, error = 'target_missing' } end

    -- Update title owner; keep current occupant unchanged
    MySQL.update.await('UPDATE properties SET landlord_cid = ?, keyholders = JSON_OBJECT() WHERE id = ?', { target, id })
    return { ok = true }
end)

lib.callback.register('qbx_properties:callback:setGarageHere', function(source, payload)
    if not isRealtor(source) then return { ok = false, error = 'forbidden' } end
    if type(payload) ~= 'table' then return { ok = false, error = 'bad_payload' } end
    local id = tonumber(payload.id)
    if not id then return { ok = false, error = 'bad_id' } end
    local prop = MySQL.single.await('SELECT owner FROM properties WHERE id = ?', { id })
    if not prop then return { ok = false, error = 'not_found' } end
    if prop.owner ~= nil then return { ok = false, error = 'has_owner' } end

    local ped = GetPlayerPed(source)
    local coords = GetEntityCoords(ped)
    local heading = GetEntityHeading(ped)
    MySQL.update.await('UPDATE properties SET garage = ? WHERE id = ?', { json.encode(vec4(coords.x, coords.y, coords.z + 1.0, heading)), id })
    return { ok = true }
end)
