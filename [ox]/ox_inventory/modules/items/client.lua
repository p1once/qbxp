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
                                if slot.metadata?.type then
                                        SetPlayerParachuteTintIndex(PlayerData.id, slot.metadata?.type)
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

local clothingState = {
        components = {},
        props = {}
}

---@param container table<number, table[]>
---@param id number
---@return table | nil
local function popClothingState(container, id)
        local stack = container[id]

        if not stack then return end

        local state = stack[#stack]
        stack[#stack] = nil

        if #stack == 0 then
                container[id] = nil
        end

        return state
end

---@param container table<number, table[]>
---@param id number
---@param state table
local function pushClothingState(container, id, state)
        local stack = container[id]

        if stack then
                stack[#stack + 1] = state
        else
                container[id] = { state }
        end
end

---@param metadata table
---@param skipValidation? boolean
---@return boolean?
local function tryEquipClothing(metadata, skipValidation)
        if type(metadata) ~= 'table' then return end

        local drawable = metadata.drawable
        local texture = metadata.texture

        if type(drawable) ~= 'number' or type(texture) ~= 'number' then return end

        if metadata.prop ~= nil then
                local propId = metadata.prop

                if type(propId) ~= 'number' then return end

                if not skipValidation and not SetPedPreloadPropData(cache.ped, propId, drawable, texture) then
                        print('Clothing has invalid prop for this ped')
                        return
                end

                local currentDrawable = GetPedPropIndex(cache.ped, propId)
                local currentTexture = GetPedPropTextureIndex(cache.ped, propId)

                if currentDrawable == drawable and currentTexture == texture then
                        return false
                end

                pushClothingState(clothingState.props, propId, {
                        drawable = currentDrawable,
                        texture = currentTexture
                })

                if drawable == -1 then
                        ClearPedProp(cache.ped, propId)
                else
                        SetPedPropIndex(cache.ped, propId, drawable, texture, false)
                end

                return true
        elseif metadata.component ~= nil then
                local componentId = metadata.component

                if type(componentId) ~= 'number' then return end

                if not skipValidation and not IsPedComponentVariationValid(cache.ped, componentId, drawable, texture) then
                        print('Clothing has invalid component for this ped')
                        return
                end

                local currentDrawable = GetPedDrawableVariation(cache.ped, componentId)
                local currentTexture = GetPedTextureVariation(cache.ped, componentId)

                if currentDrawable == drawable and currentTexture == texture then
                        return false
                end

                pushClothingState(clothingState.components, componentId, {
                        drawable = currentDrawable,
                        texture = currentTexture,
                        palette = GetPedPaletteVariation(cache.ped, componentId)
                })

                SetPedComponentVariation(cache.ped, componentId, drawable, texture, metadata.palette or 0)

                return true
        else
                print('Clothing is missing prop/component id in metadata')
        end
end

---@param metadata table
local function removeClothing(metadata)
        if type(metadata) ~= 'table' then return end

        local drawable = metadata.drawable
        local texture = metadata.texture

        if type(drawable) ~= 'number' or type(texture) ~= 'number' then return end

        if metadata.prop ~= nil then
                local propId = metadata.prop

                if type(propId) ~= 'number' then return end

                local currentDrawable = GetPedPropIndex(cache.ped, propId)
                local currentTexture = GetPedPropTextureIndex(cache.ped, propId)

                if currentDrawable ~= drawable or currentTexture ~= texture then
                        return false
                end

                local previous = popClothingState(clothingState.props, propId)
                local stack = clothingState.props[propId]

                if metadata.forceClear then
                        local fallback = stack and stack[#stack]

                        if not fallback then
                                fallback = getPropFallback(metadata, propId)
                        end

                        if fallback then
                                applyPropState(propId, fallback)
                        else
                                ClearPedProp(cache.ped, propId)
                        else
                                SetPedPropIndex(cache.ped, propId, previous.drawable, previous.texture or 0, false)
                        end
                else
                        ClearPedProp(cache.ped, propId)
                end

                return true
        elseif metadata.component ~= nil then
                local componentId = metadata.component

                if type(componentId) ~= 'number' then return end

                local currentDrawable = GetPedDrawableVariation(cache.ped, componentId)
                local currentTexture = GetPedTextureVariation(cache.ped, componentId)

                if currentDrawable ~= drawable or currentTexture ~= texture then
                        return false
                end

                local previous = popClothingState(clothingState.components, componentId)
                local stack = clothingState.components[componentId]

                if metadata.forceClear then
                        local fallback = stack and stack[#stack]

                        if not fallback then
                                fallback = getComponentFallback(metadata, componentId)
                        end

<<<<<<< ours
                if previous and not metadata.forceClear then
                        SetPedComponentVariation(cache.ped, componentId, previous.drawable or 0, previous.texture or 0, previous.palette or 0)
                else
                        SetPedComponentVariation(cache.ped, componentId, metadata.defaultDrawable or 0, metadata.defaultTexture or 0, metadata.defaultPalette or 0)
=======
                        if fallback then
                                applyComponentState(componentId, fallback)
                        else
                                SetPedComponentVariation(cache.ped, componentId, 0, 0, 0)
                        end
                else
                        if previous then
                                applyComponentState(componentId, previous)
                        else
                                local fallback = getComponentFallback(metadata, componentId)

                                if fallback then
                                        applyComponentState(componentId, fallback)
                                else
                                        SetPedComponentVariation(cache.ped, componentId, 0, 0, 0)
                                end
                        end
>>>>>>> theirs
                end

                return true
        end
end

Item('clothing', function(data, slot)
        local metadata = slot.metadata

        if not metadata or not metadata.drawable then return print('Clothing is missing drawable in metadata') end
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

                        local result = tryEquipClothing(metadata, true)

                        if result == false then
                                removeClothing(metadata)
                        end
                end
        end)
end)

RegisterNetEvent('ox_inventory:clothingUnequipped', function(metadata)
        removeClothing(metadata)
end)

RegisterNetEvent('ox_inventory:updateInventory', function(changes)
        if type(changes) ~= 'table' then return end

        for _, item in pairs(changes) do
                if type(item) == 'table' and item.name == 'clothing' and item.count and type(item.metadata) == 'table' then
                        tryEquipClothing(item.metadata)
                end
        end
end)

-----------------------------------------------------------------------------------------------

exports('Items', function(item) return getItem(nil, item) end)
exports('ItemList', function(item) return getItem(nil, item) end)

return Items
