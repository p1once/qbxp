if not lib then return end

local Items = require 'modules.items.shared' --[[@as table<string, OxClientItem>]]

local maleModel <const> = `mp_m_freemode_01`
local femaleModel <const> = `mp_f_freemode_01`

local defaultComponents <const> = {
    [maleModel] = {
        [1] = { drawable = 0, texture = 0 },
        [3] = { drawable = 15, texture = 0 },
        [4] = { drawable = 61, texture = 2 },
        [5] = { drawable = 0, texture = 0 },
        [6] = { drawable = 34, texture = 0 },
        [7] = { drawable = 0, texture = 0 },
        [8] = { drawable = 15, texture = 0 },
        [9] = { drawable = 0, texture = 0 },
        [10] = { drawable = 0, texture = 0 },
        [11] = { drawable = 15, texture = 0 },
    },
    [femaleModel] = {
        [1] = { drawable = 0, texture = 0 },
        [3] = { drawable = 15, texture = 0 },
        [4] = { drawable = 17, texture = 0 },
        [5] = { drawable = 0, texture = 0 },
        [6] = { drawable = 35, texture = 0 },
        [7] = { drawable = 0, texture = 0 },
        [8] = { drawable = 15, texture = 0 },
        [9] = { drawable = 0, texture = 0 },
        [10] = { drawable = 0, texture = 0 },
        [11] = { drawable = 15, texture = 0 },
    }
}

local function getDefaultComponent(pedModel, component)
    local defaults = defaultComponents[pedModel]

    if defaults then
        return defaults[component]
    end

    return nil
end

local function setComponentVariation(ped, component, drawable, texture)
    SetPedComponentVariation(ped, component, drawable, texture or 0, 0)
end

local function setComponentToDefault(ped, component)
    local pedModel = GetEntityModel(ped)
    local default = getDefaultComponent(pedModel, component) or { drawable = 0, texture = 0 }

    setComponentVariation(ped, component, default.drawable, default.texture)
end

local function setArmsToDefault(ped)
    setComponentToDefault(ped, 3)
end

local function isComponentDefault(ped, component, drawable, texture)
    local pedModel = GetEntityModel(ped)
    local default = getDefaultComponent(pedModel, component)

    if default then
        return drawable == default.drawable and texture == default.texture
    end

    return drawable == 0 and texture == 0
end

local function parseArms(metadata)
    local arms = metadata.arms

    if arms == nil then return end

    if type(arms) == 'table' then
        local drawable = arms.drawable or arms.item or arms[1]
        local texture = arms.texture or arms[2] or 0

        if drawable then
            return drawable, texture
        end
    elseif type(arms) == 'number' then
        return arms, 0
    elseif type(arms) == 'string' then
        local drawable = tonumber(arms)

        if drawable then
            return drawable, 0
        end
    end
end

local function validateClothingMetadata(metadata)
    if metadata.drawable == nil then
        return false
    end

    if metadata.prop ~= nil then
        if not SetPedPreloadPropData(cache.ped, metadata.prop, metadata.drawable, metadata.texture or 0) then
            return false
        end
    elseif metadata.component ~= nil then
        if not IsPedComponentVariationValid(cache.ped, metadata.component, metadata.drawable, metadata.texture or 0) then
            return false
        end
    else
        return false
    end

    return true
end

local function applyClothing(metadata, skipValidation)
    if type(metadata) ~= 'table' then return false end

    if not skipValidation and not validateClothingMetadata(metadata) then
        return false
    end

    if metadata.prop ~= nil then
        local prop = metadata.prop
        local drawable = metadata.drawable or -1
        local texture = metadata.texture or 0

        if drawable < 0 then
            ClearPedProp(cache.ped, prop)
        else
            SetPedPropIndex(cache.ped, prop, drawable, texture, false)
        end

        return true
    end

    local component = metadata.component

    if component == nil then return false end

    setComponentVariation(cache.ped, component, metadata.drawable or 0, metadata.texture or 0)

    if component == 11 or component == 8 then
        local armsDrawable, armsTexture = parseArms(metadata)

        if armsDrawable then
            setComponentVariation(cache.ped, 3, armsDrawable, armsTexture)
        end
    end

    return true
end

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

Item('phone', function(_, _)
        ExecuteCommand('phone')
end)

Item('clothing', function(data, slot)
        local metadata = slot.metadata

        if type(metadata) ~= 'table' then return print('Clothing metadata is invalid') end

        if not validateClothingMetadata(metadata) then
                return print('Clothing has invalid configuration for this ped')
        end

        ox_inventory:useItem(data, function(data)
                if not data then return end

                metadata = data.metadata

                if type(metadata) ~= 'table' then return end

                if metadata.prop ~= nil then
                        local prop = GetPedPropIndex(cache.ped, metadata.prop)
                        local texture = GetPedPropTextureIndex(cache.ped, metadata.prop)

                        if metadata.drawable == prop and (metadata.texture or 0) == texture then
                                ClearPedProp(cache.ped, metadata.prop)
                                return
                        end

                        applyClothing(metadata, true)
                        return
                end

                if metadata.component == nil then return end

                local drawable = GetPedDrawableVariation(cache.ped, metadata.component)
                local texture = GetPedTextureVariation(cache.ped, metadata.component)

                if metadata.drawable == drawable and (metadata.texture or 0) == texture then
                        setComponentToDefault(cache.ped, metadata.component)

                        if metadata.component == 11 or metadata.component == 8 then
                                setArmsToDefault(cache.ped)
                        end

                        return
                end

                applyClothing(metadata, true)
        end)
end)

AddEventHandler('ox_inventory:clothingUnequipped', function(metadata)
        if type(metadata) ~= 'table' then return end

        local ped = cache.ped

        if not DoesEntityExist(ped) then return end

        if metadata.prop ~= nil then
                ClearPedProp(ped, metadata.prop)
                return
        end

        local component = metadata.component

        if component == nil then return end

        setComponentToDefault(ped, component)

        if component == 11 then
                setArmsToDefault(ped)
        elseif component == 8 then
                setArmsToDefault(ped)
        elseif component == 3 then
                setArmsToDefault(ped)
        end
end)

AddEventHandler('ox_inventory:clothingEquipped', function(metadata)
        if type(metadata) ~= 'table' then return end

        local ped = cache.ped

        if not DoesEntityExist(ped) then return end

        if metadata.prop ~= nil then
                if GetPedPropIndex(ped, metadata.prop) == -1 then
                        applyClothing(metadata)
                end

                return
        end

        local component = metadata.component

        if component == nil then return end

        local drawable = GetPedDrawableVariation(ped, component)
        local texture = GetPedTextureVariation(ped, component)

        if isComponentDefault(ped, component, drawable, texture) then
                applyClothing(metadata)
        end
end)

-----------------------------------------------------------------------------------------------

exports('Items', function(item) return getItem(nil, item) end)
exports('ItemList', function(item) return getItem(nil, item) end)

return Items
