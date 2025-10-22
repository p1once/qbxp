if not lib then return end

local Items = require 'modules.items.shared' --[[@as table<string, OxClientItem>]]

local function sendDisplayMetadata(data)
    SendNUIMessage({
		action = 'displayMetadata',
		data = data
	})
end

--- use array of single key value pairs to dictate order
---@param metadata string | table<string, string> | table<string, string>[]
---@param value? string
local function displayMetadata(metadata, value)
	local data = {}

	if type(metadata) == 'string' then
        if not value then return end

        data = { { metadata = metadata, value = value } }
	elseif table.type(metadata) == 'array' then
		for i = 1, #metadata do
			for k, v in pairs(metadata[i]) do
				data[i] = {
					metadata = k,
					value = v,
				}
			end
		end
	else
		for k, v in pairs(metadata) do
			data[#data + 1] = {
				metadata = k,
				value = v,
			}
		end
	end

    if client.uiLoaded then
        return sendDisplayMetadata(data)
    end

    CreateThread(function()
        repeat Wait(100) until client.uiLoaded

        sendDisplayMetadata(data)
    end)
end

exports('displayMetadata', displayMetadata)

---@param _ table?
---@param name string?
---@return table?
local function getItem(_, name)
    if not name then return Items end

	if type(name) ~= 'string' then return end

    name = name:lower()

    if name:sub(0, 7) == 'weapon_' then
        name = name:upper()
    end

    return Items[name]
end

setmetatable(Items --[[@as table]], {
	__call = getItem
})

---@cast Items +fun(itemName: string): OxClientItem
---@cast Items +fun(): table<string, OxClientItem>

local function Item(name, cb)
	local item = Items[name]
	if item then
		if not item.client?.export and not item.client?.event then
			item.effect = cb
		end
	end
end

local ox_inventory = exports[shared.resource]
-----------------------------------------------------------------------------------------------
-- Clientside item use functions
-----------------------------------------------------------------------------------------------

Item('bandage', function(data, slot)
	local maxHealth = GetEntityMaxHealth(cache.ped)
	local health = GetEntityHealth(cache.ped)
	ox_inventory:useItem(data, function(data)
		if data then
			SetEntityHealth(cache.ped, math.min(maxHealth, math.floor(health + maxHealth / 16)))
			lib.notify({ description = 'You feel better already' })
		end
	end)
end)

Item('armour', function(data, slot)
	if GetPedArmour(cache.ped) < 100 then
		ox_inventory:useItem(data, function(data)
			if data then
				SetPlayerMaxArmour(PlayerData.id, 100)
				SetPedArmour(cache.ped, 100)
			end
		end)
	end
end)

client.parachute = false
Item('parachute', function(data, slot)
	if not client.parachute then
		ox_inventory:useItem(data, function(data)
			if data then
				local chute = `GADGET_PARACHUTE`
				SetPlayerParachuteTintIndex(PlayerData.id, -1)
				GiveWeaponToPed(cache.ped, chute, 0, true, false)
				SetPedGadget(cache.ped, chute, true)
				lib.requestModel(1269906701)
				client.parachute = {CreateParachuteBagObject(cache.ped, true, true), slot?.metadata?.type or -1}
				if slot.metadata.type then
					SetPlayerParachuteTintIndex(PlayerData.id, slot.metadata.type)
				end
			end
		end)
	end
end)

Item('phone', function(data, slot)
	local success, result = pcall(function()
		return exports.npwd:isPhoneVisible()
	end)

	if success then
		exports.npwd:setPhoneVisible(not result)
	end
end)

Item('clothing', function(data, slot)
<<<<<<< ours
<<<<<<< ours
<<<<<<< ours
=======
>>>>>>> theirs
=======
>>>>>>> theirs
	local metadata = slot.metadata

	if not metadata.drawable then return print('Clothing is missing drawable in metadata') end
	if not metadata.texture then return print('Clothing is missing texture in metadata') end

	if metadata.prop then
		if not SetPedPreloadPropData(cache.ped, metadata.prop, metadata.drawable, metadata.texture) then
			return print('Clothing has invalid prop for this ped')
		end
	elseif metadata.component then
		if not IsPedComponentVariationValid(cache.ped, metadata.component, metadata.drawable, metadata.texture) then
			return print('Clothing has invalid component for this ped')
		end
	else
		return print('Clothing is missing prop/component id in metadata')
	end

	ox_inventory:useItem(data, function(data)
		if data then
			metadata = data.metadata

			if metadata.prop then
				local prop = GetPedPropIndex(cache.ped, metadata.prop)
				local texture = GetPedPropTextureIndex(cache.ped, metadata.prop)

				if metadata.drawable == prop and metadata.texture == texture then
					return ClearPedProp(cache.ped, metadata.prop)
				end

				-- { prop = 0, drawable = 2, texture = 1 } = grey beanie
				SetPedPropIndex(cache.ped, metadata.prop, metadata.drawable, metadata.texture, false);
			elseif metadata.component then
				local drawable = GetPedDrawableVariation(cache.ped, metadata.component)
				local texture = GetPedTextureVariation(cache.ped, metadata.component)

				if metadata.drawable == drawable and metadata.texture == texture then
					return -- item matches (setup defaults so we can strip?)
				end

				-- { component = 4, drawable = 4, texture = 1 } = jeans w/ belt
<<<<<<< ours
<<<<<<< ours
                                SetPedComponentVariation(cache.ped, metadata.component, metadata.drawable, metadata.texture, 0);
                        end
                end
        end)
end)

RegisterNetEvent('ox_inventory:clothingUnequipped', function(metadata)
        if type(metadata) ~= 'table' then return end

        if metadata.prop then
                local currentDrawable = GetPedPropIndex(cache.ped, metadata.prop)
                local currentTexture = GetPedPropTextureIndex(cache.ped, metadata.prop)

                if metadata.drawable == currentDrawable and metadata.texture == currentTexture then
                        ClearPedProp(cache.ped, metadata.prop)
                end
        elseif metadata.component then
                local currentDrawable = GetPedDrawableVariation(cache.ped, metadata.component)
                local currentTexture = GetPedTextureVariation(cache.ped, metadata.component)

                if metadata.drawable == currentDrawable and metadata.texture == currentTexture then
                        local defaultDrawable = metadata.defaultDrawable
                        local defaultTexture = metadata.defaultTexture

                        if type(metadata.default) == 'table' then
                                defaultDrawable = defaultDrawable or metadata.default.drawable
                                defaultTexture = defaultTexture or metadata.default.texture
                        end

                        SetPedComponentVariation(cache.ped, metadata.component, defaultDrawable or 0, defaultTexture or 0, 0)
                end
        end
=======
        local metadata = slot.metadata

        if type(metadata) ~= 'table' then return print('Clothing metadata is missing') end

        metadata.drawable = tonumber(metadata.drawable)
        metadata.texture = tonumber(metadata.texture)
        metadata.prop = metadata.prop and tonumber(metadata.prop) or nil
        metadata.component = metadata.component and tonumber(metadata.component) or nil

        if not metadata.drawable then return print('Clothing is missing drawable in metadata') end
        if not metadata.texture then return print('Clothing is missing texture in metadata') end

        if metadata.prop then
                if not SetPedPreloadPropData(cache.ped, metadata.prop, metadata.drawable, metadata.texture) then
                        return print('Clothing has invalid prop for this ped')
                end
        elseif metadata.component then
                if not IsPedComponentVariationValid(cache.ped, metadata.component, metadata.drawable, metadata.texture) then
                        return print('Clothing has invalid component for this ped')
                end
        else
                return print('Clothing is missing prop/component id in metadata')
        end

        ox_inventory:useItem(data, function(response)
                if not response then return end

                local slotData = response
                local slotMetadata = slotData.metadata or metadata

                if type(slotMetadata) ~= 'table' then return end

                slotMetadata.drawable = tonumber(slotMetadata.drawable)
                slotMetadata.texture = tonumber(slotMetadata.texture)
                slotMetadata.prop = slotMetadata.prop and tonumber(slotMetadata.prop) or nil
                slotMetadata.component = slotMetadata.component and tonumber(slotMetadata.component) or nil

                if slotMetadata.prop then
                        local currentProp = GetPedPropIndex(cache.ped, slotMetadata.prop)
                        local currentTexture = GetPedPropTextureIndex(cache.ped, slotMetadata.prop)

                        if slotMetadata.drawable == currentProp and slotMetadata.texture == currentTexture then
                                return ClearPedProp(cache.ped, slotMetadata.prop)
                        end

                        -- { prop = 0, drawable = 2, texture = 1 } = grey beanie
                        SetPedPropIndex(cache.ped, slotMetadata.prop, slotMetadata.drawable, slotMetadata.texture, false)
                elseif slotMetadata.component then
                        local currentDrawable = GetPedDrawableVariation(cache.ped, slotMetadata.component)
                        local currentTexture = GetPedTextureVariation(cache.ped, slotMetadata.component)

                        if slotMetadata.drawable == currentDrawable and slotMetadata.texture == currentTexture then
                                return -- item matches (setup defaults so we can strip?)
                        end

                        -- { component = 4, drawable = 4, texture = 1 } = jeans w/ belt
                        SetPedComponentVariation(cache.ped, slotMetadata.component, slotMetadata.drawable, slotMetadata.texture, 0)
                end
        end)
>>>>>>> theirs
=======
=======
>>>>>>> theirs
				SetPedComponentVariation(cache.ped, metadata.component, metadata.drawable, metadata.texture, 0);
			end
		end
	end)
<<<<<<< ours
>>>>>>> theirs
=======
>>>>>>> theirs
end)

-----------------------------------------------------------------------------------------------

exports('Items', function(item) return getItem(nil, item) end)
exports('ItemList', function(item) return getItem(nil, item) end)

return Items
