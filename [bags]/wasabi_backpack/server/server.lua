-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
local registeredStashes = {}
local ox_inventory = exports.ox_inventory
local bagItemFilter = {}
local inventoryModule
local attachOverrides = {}

local resourceName = GetCurrentResourceName()

local function shallowCount(t)
    local c=0; for _ in pairs(t) do c=c+1 end; return c
end

local function loadOverrides()
    local raw = LoadResourceFile(resourceName, 'attach_overrides.json')
    if raw and #raw > 0 then
        local ok, data = pcall(function() return json.decode(raw) end)
        if ok and type(data) == 'table' then
            attachOverrides = data
            if lib and lib.print then lib.print.info(('wasabi_backpack: loaded %d variant override(s)'):format(shallowCount(attachOverrides))) end
        else
            if lib and lib.print then lib.print.warn('wasabi_backpack: failed to parse attach_overrides.json') end
        end
    end
end

local function saveOverrides()
    local ok, raw = pcall(function() return json.encode(attachOverrides) end)
    if not ok then
        if lib and lib.print then lib.print.error('wasabi_backpack: failed to encode overrides') end
        return false
    end
    SaveResourceFile(resourceName, 'attach_overrides.json', raw, -1)
    if lib and lib.print then lib.print.info(('wasabi_backpack: saved overrides (%d variants)'):format(shallowCount(attachOverrides))) end
    return true
end

for name, _ in pairs(Config.BagVariants or {}) do
    bagItemFilter[name] = true
end

local function getInventoryModule()
    if inventoryModule then return inventoryModule end

    local success, result = pcall(function()
        return ox_inventory:Inventory()
    end)

    if success and result then
        inventoryModule = result
    end

    return inventoryModule
end

local function resolveBagModel(slot)
    if not slot or not Config.BagVariants then return nil end

    local metadata = slot.metadata
    local bagType = metadata and metadata.bagType or slot.name
    local variant = (bagType and Config.BagVariants[bagType]) or Config.BagVariants[slot.name]
    local defaultVariant = Config.BagVariants.backpack

    local selectedVariant = variant or defaultVariant
    if not selectedVariant then
        return `p_michael_backpack_s`
    end

    return selectedVariant.dropModel or selectedVariant.model or `p_michael_backpack_s`
end

local function refreshDropModel(dropId, model)
    if not dropId or not model then return end

    CreateThread(function()
        local inventoryLib = getInventoryModule()
        if not inventoryLib or not inventoryLib.Drops then return end

        local attempts = 0
        while attempts < 20 do
            local drop = inventoryLib.Drops[dropId]

            if drop then
                if drop.model ~= model then
                    drop.model = model
                    TriggerClientEvent('ox_inventory:removeDrop', -1, dropId)
                    TriggerClientEvent('ox_inventory:createDrop', -1, dropId, drop)
                    if lib and lib.print then
                        lib.print.debug(('wasabi_backpack: applied drop model %s for %s'):format(model, dropId))
                    end
                end
                return
            end

            attempts += 1
            Wait(50)
        end

        if lib and lib.print then
            lib.print.warn(('wasabi_backpack: failed to locate drop %s to apply model %s'):format(dropId, model))
        end
    end)
end


local function GenerateText(num) -- Thnx Linden
	local str
	repeat str = {}
		for i = 1, num do str[i] = string.char(math.random(65, 90)) end
		str = table.concat(str)
	until str ~= 'POL' and str ~= 'EMS'
	return str
end

local function GenerateSerial(text) -- Thnx Again
	if text and text:len() > 3 then
		return text
	end
	return ('%s%s%s'):format(math.random(100000,999999), text == nil and GenerateText(3) or text, math.random(100000,999999))
end

RegisterServerEvent('wasabi_backpack:openBackpack')
AddEventHandler('wasabi_backpack:openBackpack', function(identifier, bagType)
	if not registeredStashes[identifier] then
        local cfg = (bagType and Config.BagVariants and Config.BagVariants[bagType]) or nil
        local slots = cfg and cfg.slots or Config.BackpackStorage.slots
        local weight = cfg and cfg.weight or Config.BackpackStorage.weight
        local label = cfg and (cfg.label or 'Backpack') or 'Backpack'
        ox_inventory:RegisterStash('bag_'..identifier, label, slots, weight, false)
        registeredStashes[identifier] = true
    end
end)

-- Load overrides on resource start
CreateThread(function()
    loadOverrides()
end)

-- Provide overrides to clients for a given variant
lib.callback.register('wasabi_backpack:getAttachOverride', function(source, variant)
    if not variant then return nil end
    local ov = attachOverrides[variant]
    return ov or nil
end)

local function canEditAttach(src)
    if not src then return false end
    -- Accept any of these: custom ACE, standard admin/god ACE, or qbx permission helper
    if IsPlayerAceAllowed and (
        IsPlayerAceAllowed(src, 'wasabi_backpack.edit') or
        IsPlayerAceAllowed(src, 'admin') or
        IsPlayerAceAllowed(src, 'god')
    ) then
        return true
    end
    if exports and exports.qbx_core and exports.qbx_core.HasPermission then
        local ok, res = pcall(function()
            return exports.qbx_core:HasPermission(src, { 'admin', 'god' })
        end)
        if ok and res then return true end
    end
    return false
end

lib.callback.register('wasabi_backpack:canEditAttach', function(source)
    return canEditAttach(source)
end)

-- Save override from client editing
RegisterNetEvent('wasabi_backpack:saveAttach', function(variant, gender, data)
    local src = source
    if not canEditAttach(src) then
        if lib and lib.print then lib.print.warn(('wasabi_backpack: unauthorized saveAttach by %s'):format(src)) end
        if lib and lib.notify then TriggerClientEvent('ox_lib:notify', src, { type = 'error', title = 'Backpack Edit', description = 'Permission refusée.' }) end
        return
    end
    if type(variant) ~= 'string' or (gender ~= 'male' and gender ~= 'female') then return end
    if type(data) ~= 'table' then return end
    if not Config.BagVariants or not Config.BagVariants[variant] then return end

    attachOverrides[variant] = attachOverrides[variant] or {}
    attachOverrides[variant][gender] = {
        bone = tonumber(data.bone) or 24818,
        offset = { x = tonumber(data.offX) or 0.0, y = tonumber(data.offY) or 0.0, z = tonumber(data.offZ) or 0.0 },
        rotation = { x = tonumber(data.rotX) or 0.0, y = tonumber(data.rotY) or 0.0, z = tonumber(data.rotZ) or 0.0 },
    }

    saveOverrides()

    if lib and lib.notify then
        TriggerClientEvent('ox_lib:notify', src, { type = 'success', title = 'Backpack Edit', description = ('Saved %s/%s attach override'):format(variant, gender) })
    end
end)

RegisterNetEvent('wasabi_backpack:clearAttach', function(variant, gender)
    local src = source
    if not canEditAttach(src) then
        if lib and lib.print then lib.print.warn(('wasabi_backpack: unauthorized clearAttach by %s'):format(src)) end
        if lib and lib.notify then TriggerClientEvent('ox_lib:notify', src, { type = 'error', title = 'Backpack Edit', description = 'Permission refusée.' }) end
        return
    end
    if type(variant) ~= 'string' or (gender ~= nil and gender ~= 'male' and gender ~= 'female') then return end
    if not attachOverrides[variant] then return end
    if gender then
        attachOverrides[variant][gender] = nil
        if not next(attachOverrides[variant]) then
            attachOverrides[variant] = nil
        end
    else
        attachOverrides[variant] = nil
    end
    saveOverrides()
    if lib and lib.notify then
        TriggerClientEvent('ox_lib:notify', src, { type = 'inform', title = 'Backpack Edit', description = ('Cleared override for %s%s'):format(variant, gender and ('/'..gender) or '') })
    end
end)

lib.callback.register('wasabi_backpack:getNewIdentifier', function(source, slot, bagType)
	local newId = GenerateSerial()
    local cfg = (bagType and Config.BagVariants and Config.BagVariants[bagType]) or nil
    local slots = cfg and cfg.slots or Config.BackpackStorage.slots
    local weight = cfg and cfg.weight or Config.BackpackStorage.weight
    local label = cfg and (cfg.label or 'Backpack') or 'Backpack'

	ox_inventory:SetMetadata(source, slot, {identifier = newId, bagType = bagType})
	ox_inventory:RegisterStash('bag_'..newId, label, slots, weight, false)
	registeredStashes[newId] = true
	return newId
end)

CreateThread(function()
	while GetResourceState('ox_inventory') ~= 'started' do Wait(500) end
    local swapHook = ox_inventory:registerHook('swapItems', function(payload)
        local start, destination, move_type = payload.fromInventory, payload.toInventory, payload.toType
        local total_bags = 0
        for name, _ in pairs(bagItemFilter) do
            total_bags = total_bags + (ox_inventory:GetItem(payload.source, name, nil, true) or 0)
        end

        if destination == 'newdrop' and move_type == 'drop' and payload.dropId and payload.fromSlot then
            local slot = payload.fromSlot

            if bagItemFilter[slot.name] then
                local model = resolveBagModel(slot)
                if model and lib and lib.print then
                    local bagType = slot.metadata and slot.metadata.bagType or 'nil'
                    lib.print.debug(('wasabi_backpack: dropId %s slot %s bagType %s model %s'):format(payload.dropId, slot.name or 'unknown', bagType, model))
                end
                if model then
                    refreshDropModel(payload.dropId, model)
                end
            end
        end
	
        if string.find(destination, 'bag_') then
            TriggerClientEvent('ox_lib:notify', payload.source, {type = 'error', title = Strings.action_incomplete, description = Strings.backpack_in_backpack}) 
            return false
        end
        if Config.OneBagInInventory then
            if (total_bags > 0 and move_type == 'player' and destination ~= start) then
                TriggerClientEvent('ox_lib:notify', payload.source, {type = 'error', title = Strings.action_incomplete, description = Strings.one_backpack_only}) 
                return false
            end
        end
        
        return true
    end, {
        print = false,
        itemFilter = bagItemFilter,
    })
	
    local createHook
    if Config.OneBagInInventory then
        createHook = exports.ox_inventory:registerHook('createItem', function(payload)
            local total_bags = 0
            for name, _ in pairs(bagItemFilter) do
                total_bags = total_bags + (ox_inventory:GetItem(payload.inventoryId, name, nil, true) or 0)
            end
            local playerItems = ox_inventory:GetInventoryItems(payload.inventoryId)
	
	
            if total_bags > 0 then
                local slot = nil

                for i,k in pairs(playerItems) do
                    if bagItemFilter[k.name] then
                        slot = k.slot
                        break
                    end
                end
	
				Citizen.CreateThread(function()
					local inventoryId = payload.inventoryId
					local dontRemove = slot
					Citizen.Wait(1000)
	
                    for i,k in pairs(ox_inventory:GetInventoryItems(inventoryId)) do
                        if bagItemFilter[k.name] and dontRemove ~= nil and k.slot ~= dontRemove then
                            local success = ox_inventory:RemoveItem(inventoryId, k.name, 1, nil, k.slot)
                            if success then
                                TriggerClientEvent('ox_lib:notify', inventoryId, {type = 'error', title = Strings.action_incomplete, description = Strings.one_backpack_only}) 
                            end
                            break
                        end
                    end
                end)
            end
        end, {
            print = false,
            itemFilter = bagItemFilter
        })
    end
	
	AddEventHandler('onResourceStop', function()
		ox_inventory:removeHooks(swapHook)
		if Config.OneBagInInventory then
			ox_inventory:removeHooks(createHook)
		end
	end)
end)
