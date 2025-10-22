local trackedClothingSlots = {}

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

    for slot, item in pairs(changes) do
        if item == false then
            local metadata = trackedClothingSlots[slot]

            if metadata then
                trackedClothingSlots[slot] = nil
                TriggerEvent('ox_inventory:clothingUnequipped', metadata, slot)
            end
        elseif type(item) == 'table' then
            if item.name == 'clothing' and item.count and type(item.metadata) == 'table' then
                local previousMetadata = trackedClothingSlots[slot]

                if previousMetadata and previousMetadata ~= item.metadata then
                    TriggerEvent('ox_inventory:clothingUnequipped', previousMetadata, slot)
                end

                trackedClothingSlots[slot] = item.metadata
                TriggerEvent('ox_inventory:clothingEquipped', item.metadata, slot)
            elseif trackedClothingSlots[slot] then
                local metadata = trackedClothingSlots[slot]
                trackedClothingSlots[slot] = nil
                TriggerEvent('ox_inventory:clothingUnequipped', metadata, slot)
            end
        elseif trackedClothingSlots[slot] then
            local metadata = trackedClothingSlots[slot]
            trackedClothingSlots[slot] = nil
            TriggerEvent('ox_inventory:clothingUnequipped', metadata, slot)
        end
    end
end)
