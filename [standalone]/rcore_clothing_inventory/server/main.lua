local componentImages = {
    [1] = 'mask',
    [3] = 'gloves',
    [4] = 'jeans',
    [5] = 'bag',
    [6] = 'shoes',
    [7] = 'chain',
    [8] = 'tshirt',
    [11] = 'torso',
}

local propImages = {
    [0] = 'helmet',
    [1] = 'glasses',
    [2] = 'ears',
    [7] = 'bracelet',
    [6] = 'watches',
}

local function buildMetadataFromPurchase(item)
    if type(item) ~= 'table' then
        return nil
    end

    local componentId = item.component_id
    local drawable = item.drawable_id
    local texture = item.texture_id

    componentId = type(componentId) == 'number' and math.tointeger(componentId)

    if componentId == 33 then
        componentId = 3
    end
    drawable = type(drawable) == 'number' and math.tointeger(drawable)
    texture = type(texture) == 'number' and math.tointeger(texture)

    if not componentId or not drawable or not texture then
        return nil
    end

    if componentId < 0 then
        return nil
    end

    local metadata = {
        drawable = drawable,
        texture = texture
    }

    local image

    if componentId >= 100 then
        local propId = componentId - 100
        metadata.prop = propId
        image = propImages[propId]
    else
        metadata.component = componentId
        image = componentImages[componentId]
    end

    if image then
        if not image:find('%.png$') then
            image = ('%s.png'):format(image)
        end

        metadata.image = ('outfits/%s'):format(image)
    end

    if type(item.label) == 'string' and item.label ~= '' then
        metadata.label = item.label
    end

    if item.name_hash ~= nil then
        metadata.name_hash = item.name_hash
    end

    if item.decal_collection_hash ~= nil then
        metadata.decal_collection_hash = item.decal_collection_hash
    end

    if item.decal_name_hash ~= nil then
        metadata.decal_name_hash = item.decal_name_hash
    end

    if item.arms ~= nil then
        metadata.arms = item.arms
    end

    return metadata
end

RegisterNetEvent('rcore_clothing_inventory:addClothingItems', function(items)
    local src = source

    if type(items) ~= 'table' then
        return
    end

    for _, item in ipairs(items) do
        local metadata = buildMetadataFromPurchase(item)

        if metadata then
            local added = exports.ox_inventory:AddItem(src, 'clothing', 1, metadata)

            if not added then
                print(('[rcore_clothing_inventory] Failed to add clothing item for %s'):format(src))
            end
        end
    end
end)
