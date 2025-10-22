local trackedClothingSlots = {}

local function buildMetadataKey(metadata)
    if type(metadata) ~= 'table' then
        return nil
    end

    local drawable = metadata.drawable
    local texture = metadata.texture

    if type(drawable) ~= 'number' or type(texture) ~= 'number' then
        return nil
    end

    local component = metadata.component
    local prop = metadata.prop
    local parts = {
        component and ('c:%s'):format(component) or 'c:',
        prop and ('p:%s'):format(prop) or 'p:',
        ('d:%s'):format(drawable),
        ('t:%s'):format(texture)
    }

    if metadata.arms ~= nil then
        parts[#parts + 1] = ('a:%s'):format(metadata.arms)
    end

    if metadata.name_hash ~= nil then
        parts[#parts + 1] = ('nh:%s'):format(metadata.name_hash)
    end

    if metadata.decal_collection_hash ~= nil then
        parts[#parts + 1] = ('dch:%s'):format(metadata.decal_collection_hash)
    end

    if metadata.decal_name_hash ~= nil then
        parts[#parts + 1] = ('dnh:%s'):format(metadata.decal_name_hash)
    end

    return table.concat(parts, '|')
end

local function normaliseTrackedEntry(slot)
    local entry = trackedClothingSlots[slot]

    if not entry then
        return nil
    end

    if entry.metadata then
        if entry.key == nil then
            entry.key = buildMetadataKey(entry.metadata)
        end

        return entry
    end

    if type(entry) == 'table' then
        local normalised = {
            metadata = entry,
            key = buildMetadataKey(entry)
        }

        trackedClothingSlots[slot] = normalised

        return normalised
    end

    trackedClothingSlots[slot] = nil

    return nil
end

local function setTrackedEntry(slot, metadata)
    if type(metadata) ~= 'table' then
        trackedClothingSlots[slot] = nil
        return nil
    end

    local entry = {
        metadata = metadata,
        key = buildMetadataKey(metadata)
    }

    trackedClothingSlots[slot] = entry

    return entry
end

local function consumePendingKey(pending, key)
    local count = pending[key]

    if not count then
        return false
    end

    if count <= 1 then
        pending[key] = nil
    else
        pending[key] = count - 1
    end

    return true
end

local function sanitizePurchasedItems(items)
    if type(items) ~= 'table' then
        return nil
    end

    local sanitized = {}

    for _, item in pairs(items) do
        if type(item) == 'table' then
            local componentId = item.component_id
            local drawable = item.drawable_id
            local texture = item.texture_id

            if type(componentId) == 'number' and type(drawable) == 'number' and type(texture) == 'number' then
                sanitized[#sanitized + 1] = {
                    component_id = componentId,
                    drawable_id = drawable,
                    texture_id = texture,
                    label = item.label,
                    name_hash = item.name_hash,
                    decal_collection_hash = item.decal_collection_hash,
                    decal_name_hash = item.decal_name_hash,
                    arms = item.arms
                }
            end
        end
    end

    if #sanitized == 0 then
        return nil
    end

    return sanitized
end

RegisterNetEvent('rcore_clothing:internal:itemPurchased', function(purchasedItems)
    local items = sanitizePurchasedItems(purchasedItems)

    if not items then
        return
    end

    TriggerServerEvent('rcore_clothing_inventory:addClothingItems', items)
end)

RegisterNetEvent('ox_inventory:updateInventory', function(changes)
    if type(changes) ~= 'table' then
        return
    end

    local pendingClothingKeys = {}

    for _, item in pairs(changes) do
        if type(item) == 'table' and item.name == 'clothing' and item.count and type(item.metadata) == 'table' then
            local key = buildMetadataKey(item.metadata)

            if key then
                pendingClothingKeys[key] = (pendingClothingKeys[key] or 0) + 1
            end
        end
    end

    for slot, item in pairs(changes) do
        if item == false then
            local entry = normaliseTrackedEntry(slot)

            if entry then
                trackedClothingSlots[slot] = nil

                if not (entry.key and consumePendingKey(pendingClothingKeys, entry.key)) then
                    TriggerEvent('ox_inventory:clothingUnequipped', entry.metadata, slot)
                end
            end
        elseif type(item) == 'table' then
            if item.name == 'clothing' and item.count and type(item.metadata) == 'table' then
                local previousEntry = normaliseTrackedEntry(slot)
                local previousMetadata = previousEntry and previousEntry.metadata
                local previousKey = previousEntry and previousEntry.key

                local newEntry = setTrackedEntry(slot, item.metadata)
                local newKey = newEntry and newEntry.key

                if previousMetadata and previousKey ~= newKey then
                    TriggerEvent('ox_inventory:clothingUnequipped', previousMetadata, slot)
                end

                TriggerEvent('ox_inventory:clothingEquipped', item.metadata, slot)
            else
                local entry = normaliseTrackedEntry(slot)

                if entry then
                    trackedClothingSlots[slot] = nil
                    TriggerEvent('ox_inventory:clothingUnequipped', entry.metadata, slot)
                else
                    trackedClothingSlots[slot] = nil
                end
            end
        else
            local entry = normaliseTrackedEntry(slot)

            if entry then
                trackedClothingSlots[slot] = nil
                TriggerEvent('ox_inventory:clothingUnequipped', entry.metadata, slot)
            else
                trackedClothingSlots[slot] = nil
            end
        end
    end
end)
