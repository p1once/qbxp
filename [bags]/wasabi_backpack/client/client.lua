-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------

local bagEquipped, bagObj
local equippedBagName, equippedModel, equippedAttachment
local currentAttach -- { bone, offX, offY, offZ, rotX, rotY, rotZ }

local editState = {
    enabled = false,
    stepO = 0.01,   -- meters per nudge for offset
    stepR = 1.0,    -- degrees per nudge for rotation
    coarse = false, -- toggle coarse multiplier
}

local saveState = {
    pending = false,
    lastChange = 0,
    cooldown = 750, -- ms debounce
}
local ox_inventory = exports.ox_inventory
local ped = cache.ped
local justConnect = true

local defaultAttach = {
    bone = 24818,
    offset = { x = 0.07, y = -0.11, z = -0.05 },
    rotation = { x = 0.0, y = 90.0, z = 175.0 }
}

local function asVectorComponents(value, default)
    default = default or defaultAttach.offset
    if not value then
        return default.x, default.y, default.z
    end

    local valueType = type(value)

    if valueType == 'vector3' then
        return value.x, value.y, value.z
    end

    if valueType == 'table' then
        if value.x ~= nil or value.y ~= nil or value.z ~= nil then
            return value.x or default.x, value.y or default.y, value.z or default.z
        end

        return value[1] or default.x, value[2] or default.y, value[3] or default.z
    end

    return default.x, default.y, default.z
end

-- Axis used for yaw editing via arrow keys
local YAW_AXIS = (Config and Config.EditYawAxis) or 'z'



local function selectAttachment(raw)
    if not raw then return defaultAttach end
    local isVariant = type(raw) == 'table' and (raw.male ~= nil or raw.female ~= nil)
    if isVariant then
        local model = GetEntityModel(ped)
        if model == `mp_m_freemode_01` then
            return raw.male or raw.female or defaultAttach
        elseif model == `mp_f_freemode_01` then
            return raw.female or raw.male or defaultAttach
        end
        return raw.male or raw.female or defaultAttach
    end
    return raw
end

local function PutOnBag(model)
    local useModel = model or equippedModel or ((Config.BagVariants and Config.BagVariants.backpack and Config.BagVariants.backpack.model) or `p_michael_backpack_s`)
    local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(ped, 0.0, 3.0, 0.5))

    local ok = true
    if lib and lib.requestModel then
        ok = pcall(function()
            return lib.requestModel(useModel, 5000)
        end)
    end

    if not ok or not HasModelLoaded(useModel) then
        RequestModel(useModel)
        local start = GetGameTimer()
        while not HasModelLoaded(useModel) and (GetGameTimer() - start) < 5000 do
            Wait(50)
        end
    end

    if not HasModelLoaded(useModel) then
        if lib and lib.print then lib.print.warn(('wasabi_backpack: failed to load model %s'):format(useModel)) end
        return
    end

    bagObj = CreateObjectNoOffset(useModel, x, y, z, true, false)
    if not bagObj or not DoesEntityExist(bagObj) then
        return
    end

    local attach = selectAttachment(equippedAttachment) or defaultAttach
    local bone = attach.bone or defaultAttach.bone
    local offsetX, offsetY, offsetZ = asVectorComponents(attach.offset, defaultAttach.offset)
    local rotX, rotY, rotZ = asVectorComponents(attach.rotation, defaultAttach.rotation)
    local dbg = ('wasabi_backpack attach -> bone:%s off:(%.2f, %.2f, %.2f) rot:(%.2f, %.2f, %.2f) model:%s')
        :format(tostring(bone), offsetX, offsetY, offsetZ, rotX, rotY, rotZ, tostring(useModel))
    if lib and lib.print then lib.print.info(dbg) end
    print(dbg)

    AttachEntityToEntity(bagObj, ped, GetPedBoneIndex(ped, bone), offsetX, offsetY, offsetZ, rotX, rotY, rotZ, true, true, false, true, 1, true)
    currentAttach = {
        bone = bone,
        offX = offsetX, offY = offsetY, offZ = offsetZ,
        rotX = rotX, rotY = rotY, rotZ = rotZ,
    }
    bagEquipped = true
end

local function RemoveBag()
    if DoesEntityExist(bagObj) then
        DeleteObject(bagObj)
    end
    if equippedModel then SetModelAsNoLongerNeeded(equippedModel) end
    bagObj = nil
    bagEquipped = nil
    equippedBagName = nil
    equippedModel = nil
    equippedAttachment = nil
    currentAttach = nil
end

local function cleanupExistingBagProps()
    local objects = GetGamePool and GetGamePool('CObject') or {}
    for i = 1, #objects do
        local obj = objects[i]
        if DoesEntityExist(obj) and (
            GetEntityModel(obj) == `p_ld_heist_bag_s` or
            GetEntityModel(obj) == `p_ld_heist_bag_s_pro2_s` or
            GetEntityModel(obj) == `p_michael_backpack_s`
        ) then
            if IsEntityAttachedToEntity(obj, ped) then
                DeleteObject(obj)
            end
        end
    end
end

local function findFirstOwnedBag()
    if not Config.BagVariants then return nil end
    for name, data in pairs(Config.BagVariants) do
        local count = ox_inventory:Search('count', name)
        if count and count > 0 then
            return name, data
        end
    end
    return nil
end

AddEventHandler('ox_inventory:updateInventory', function(changes)
    if justConnect then
        Wait(4500)
        justConnect = nil
    end
    for k, v in pairs(changes) do
        if type(v) == 'table' or type(v) == 'boolean' then
            local name, data = findFirstOwnedBag()
            if name and data then
                local model = data.model
                if not bagEquipped or not bagObj or equippedBagName ~= name then
                    RemoveBag()
                    equippedBagName = name
                    equippedModel = model
                    local override = lib and lib.callback and lib.callback.await and lib.callback.await('wasabi_backpack:getAttachOverride', 200, name)
                    equippedAttachment = override or data.attach
                    PutOnBag(model)
                end
            elseif bagEquipped then
                RemoveBag()
            end
        end
    end
end)

lib.onCache('ped', function(value)
    ped = value
end)

lib.onCache('vehicle', function(value)
    if GetResourceState('ox_inventory') ~= 'started' then return end
    if value then
        RemoveBag()
    else
        local name, data = findFirstOwnedBag()
        if name and data then
            equippedBagName = name
            equippedModel = data.model
            local override = lib and lib.callback and lib.callback.await and lib.callback.await('wasabi_backpack:getAttachOverride', 200, name)
            equippedAttachment = override or data.attach
            PutOnBag(equippedModel)
        end
    end
end)

local function handleOpenBackpack(data, slot)
    local itemName = (slot and slot.name) or (data and data.name)
    if not (slot and slot.metadata and slot.metadata.identifier) then
        local identifier = lib.callback and lib.callback.await and lib.callback.await('wasabi_backpack:getNewIdentifier', 100, data and data.slot, itemName)
        ox_inventory:openInventory('stash', 'bag_'..identifier)
    else
        local bagType = (slot and slot.metadata and slot.metadata.bagType) or itemName
        TriggerServerEvent('wasabi_backpack:openBackpack', slot.metadata.identifier, bagType)
        ox_inventory:openInventory('stash', 'bag_'..slot.metadata.identifier)
    end
end

-- Export for ox_inventory items using client export
exports('openBackpack', handleOpenBackpack)

-- Optional client event, for setups preferring an event over an export
RegisterNetEvent('wasabi_backpack:openBackpackUse', function(data, slot)
    handleOpenBackpack(data, slot)
end)

-- Force refresh on resource start to apply config changes without waiting for an inventory event
AddEventHandler('onClientResourceStart', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end
    Wait(500)
    if GetResourceState('ox_inventory') ~= 'started' then return end
    RemoveBag()
    cleanupExistingBagProps()
    local name, data = findFirstOwnedBag()
    if name and data then
        equippedBagName = name
        equippedModel = data.model
        local override = lib and lib.callback and lib.callback.await and lib.callback.await('wasabi_backpack:getAttachOverride', 200, name)
        equippedAttachment = override or data.attach
        PutOnBag(equippedModel)
    end
end)

-- Optional: external refresh hook if other scripts want to force re-attach
RegisterNetEvent('wasabi_backpack:refresh', function()
    RemoveBag()
    cleanupExistingBagProps()
    local name, data = findFirstOwnedBag()
    if name and data then
        equippedBagName = name
        equippedModel = data.model
        local override = lib and lib.callback and lib.callback.await and lib.callback.await('wasabi_backpack:getAttachOverride', 200, name)
        equippedAttachment = override or data.attach
        PutOnBag(equippedModel)
    end
end)

-- Simple local command for quick testing
RegisterCommand('refreshbag', function()
    TriggerEvent('wasabi_backpack:refresh')
end, false)

-- Debug: visualize bag-to-bone distance and helpful numbers
local bagDebug = false

local function drawText3D(x, y, z, text)
    SetDrawOrigin(x, y, z, 0)
    SetTextScale(0.35, 0.35)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextOutline()
    SetTextCentre(1)
    SetTextColour(255, 255, 255, 220)
    BeginTextCommandDisplayText('STRING')
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(0.0, 0.0)
    ClearDrawOrigin()
end

local function drawAxesAtEntity(entity, scale)
    if not entity or not DoesEntityExist(entity) then return end
    scale = scale or 0.15
    local ex, ey, ez = table.unpack(GetEntityCoords(entity))

    -- Support both return shapes of GetEntityMatrix (vector3s or raw numbers)
    local a, b, c = GetEntityMatrix(entity)
    local rightX, rightY, rightZ, fwdX, fwdY, fwdZ, upX, upY, upZ
    if a and type(a) == 'vector3' then
        -- a,b,c are vector3 (right, forward, up). We don't need the position here.
        rightX, rightY, rightZ = a.x, a.y, a.z
        fwdX,  fwdY,  fwdZ  = b.x, b.y, b.z
        upX,   upY,   upZ   = c.x, c.y, c.z
    else
        -- Fallback to numeric returns
        rightX, rightY, rightZ,
        fwdX,   fwdY,   fwdZ,
        upX,    upY,    upZ = GetEntityMatrix(entity)
    end

    if not (rightX and fwdX and upX) then return end

    -- X (right) - red
    DrawLine(ex, ey, ez, ex + rightX * scale, ey + rightY * scale, ez + rightZ * scale, 255, 60, 60, 255)
    -- Y (forward) - green
    DrawLine(ex, ey, ez, ex + fwdX * scale, ey + fwdY * scale, ez + fwdZ * scale, 60, 255, 60, 255)
    -- Z (up) - blue
    DrawLine(ex, ey, ez, ex + upX * scale, ey + upY * scale, ez + upZ * scale, 60, 60, 255, 255)
end

-- Toggleable command
RegisterCommand('bagdebug', function()
    bagDebug = not bagDebug
    local msg = bagDebug and 'wasabi_backpack debug ON' or 'wasabi_backpack debug OFF'
    print(msg)
    if lib and lib.notify then
        lib.notify({ title = 'Backpack Debug', description = msg, type = bagDebug and 'success' or 'inform' })
    end
end, false)

CreateThread(function()
    while true do
        if not bagDebug then
            Wait(500)
        else
            Wait(0)
            if bagEquipped and bagObj and DoesEntityExist(bagObj) and ped and DoesEntityExist(ped) then
                local attach = selectAttachment(equippedAttachment) or defaultAttach
                local bone = (currentAttach and currentAttach.bone) or attach.bone or defaultAttach.bone
                local offX, offY, offZ, rotX, rotY, rotZ
                if currentAttach then
                    offX, offY, offZ = currentAttach.offX, currentAttach.offY, currentAttach.offZ
                    rotX, rotY, rotZ = currentAttach.rotX, currentAttach.rotY, currentAttach.rotZ
                else
                    offX, offY, offZ = asVectorComponents(attach.offset, defaultAttach.offset)
                    rotX, rotY, rotZ = asVectorComponents(attach.rotation, defaultAttach.rotation)
                end
                local boneIndex = GetPedBoneIndex(ped, bone)

                local bx, by, bz = table.unpack(GetWorldPositionOfEntityBone(ped, boneIndex))
                local ox, oy, oz = table.unpack(GetEntityCoords(bagObj))

                local dx, dy, dz = (ox - bx), (oy - by), (oz - bz)
                local dist = math.sqrt(dx*dx + dy*dy + dz*dz)

                -- Approximate ped-local offset to help tune values
                local lx, ly, lz = table.unpack(GetOffsetFromEntityGivenWorldCoords(ped, ox, oy, oz))

                -- Markers: bone (green) and bag (orange)
                DrawMarker(28, bx, by, bz, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.08, 0.08, 0.08, 60, 255, 60, 180, false, true, 2, false, nil, nil, false)
                DrawMarker(28, ox, oy, oz, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.08, 0.08, 0.08, 255, 140, 0, 200, false, true, 2, false, nil, nil, false)

                -- Line from bone to bag
                DrawLine(bx, by, bz, ox, oy, oz, 0, 255, 255, 255)

                -- Draw small axes at bag to visualize rotation
                drawAxesAtEntity(bagObj, 0.2)

                -- Text readout near bag
                local info = (
                    'Bone: %s\nDist: %.3f\nDelta (world): X %.3f  Y %.3f  Z %.3f\nApprox ped offset -> X %.3f  Y %.3f  Z %.3f\nAttach off:(%.3f, %.3f, %.3f) rot:(%.1f, %.1f, %.1f)%s')
                    :format(
                        tostring(bone), dist, dx, dy, dz, lx, ly, lz,
                        offX, offY, offZ, rotX, rotY, rotZ,
                        (editState.enabled and ('\nEDIT ON  stepO:'..string.format('%.3f', editState.stepO * (editState.coarse and 10 or 1))..'  stepR:'..string.format('%.1f', editState.stepR * (editState.coarse and 10 or 1))) or '')
                    )
                drawText3D(ox, oy, oz + 0.25, info)
            end
        end
    end
end)

-- ========= Interactive editing =========
local function normalizeAngle(a)
    a = (a + 180.0) % 360.0
    if a < 0 then a = a + 360.0 end
    return a - 180.0
end

local function reattachUsingCurrent()
    if not (bagEquipped and bagObj and DoesEntityExist(bagObj) and ped and DoesEntityExist(ped) and currentAttach) then return end
    AttachEntityToEntity(
        bagObj, ped, GetPedBoneIndex(ped, currentAttach.bone),
        currentAttach.offX, currentAttach.offY, currentAttach.offZ,
        currentAttach.rotX, currentAttach.rotY, currentAttach.rotZ,
        true, true, false, true, 1, true
    )
end

local function sendSaveNow()
    if not currentAttach or not equippedBagName then return end
    local model = GetEntityModel(ped)
    local gender = (model == `mp_f_freemode_01`) and 'female' or 'male'
    TriggerServerEvent('wasabi_backpack:saveAttach', equippedBagName, gender, currentAttach)
end

RegisterCommand('bagedit', function()
    if not (lib and lib.callback and lib.callback.await and lib.callback.await('wasabi_backpack:canEditAttach', 200)) then
        if lib and lib.notify then lib.notify({ title = 'Backpack Edit', description = 'Permission refusÃ©e.', type = 'error' }) end
        print('bagedit: permission refused')
        return
    end
    if not (bagEquipped and currentAttach) then
        if lib and lib.notify then lib.notify({ title = 'Backpack Edit', description = 'Aucun sac Ã©quipÃ©.', type = 'error' }) end
        print('bagedit: no bag equipped to edit')
        return
    end
    editState.enabled = not editState.enabled
    local msg = editState.enabled and 'EDIT MODE ON' or 'EDIT MODE OFF'
    print(msg)
    if lib and lib.notify then
        lib.notify({ title = 'Backpack Edit', description = msg, type = editState.enabled and 'success' or 'inform' })
    end
    if not editState.enabled then
        sendSaveNow()
    end
end, false)

RegisterCommand('bagstep', function(_, args)
    if not (lib and lib.callback and lib.callback.await and lib.callback.await('wasabi_backpack:canEditAttach', 200)) then
        if lib and lib.notify then lib.notify({ title = 'Backpack Edit', description = 'Permission refusÃ©e.', type = 'error' }) end
        return
    end
    local o = tonumber(args and args[1])
    local r = tonumber(args and args[2])
    if o then editState.stepO = o end
    if r then editState.stepR = r end
    print(('bagstep -> offset: %.4f, rot: %.2f'):format(editState.stepO, editState.stepR))
    if lib and lib.notify then
        lib.notify({ title = 'Backpack Edit', description = ('Step O: %.4f  R: %.2f'):format(editState.stepO, editState.stepR), type = 'inform' })
    end
end, false)

RegisterCommand('bagstep_toggle', function()
    if not (lib and lib.callback and lib.callback.await and lib.callback.await('wasabi_backpack:canEditAttach', 200)) then
        if lib and lib.notify then lib.notify({ title = 'Backpack Edit', description = 'Permission refusÃ©e.', type = 'error' }) end
        return
    end
    editState.coarse = not editState.coarse
    local mult = editState.coarse and 10 or 1
    local msg = ('Step x%d (O: %.4f  R: %.2f)'):format(mult, editState.stepO * mult, editState.stepR * mult)
    print('bagstep_toggle -> '..msg)
    if lib and lib.notify then lib.notify({ title = 'Backpack Edit', description = msg, type = 'inform' }) end
end, false)

local function nudgeOffset(axis, sign)
    if not editState.enabled or not currentAttach then return end
    local mult = editState.coarse and 10 or 1
    local step = (editState.stepO or 0.01) * (sign or 1) * mult
    if axis == 'x' then currentAttach.offX = currentAttach.offX + step
    elseif axis == 'y' then currentAttach.offY = currentAttach.offY + step
    elseif axis == 'z' then currentAttach.offZ = currentAttach.offZ + step end
    reattachUsingCurrent()
    saveState.pending = true
    saveState.lastChange = GetGameTimer()
end

local function nudgeRotation(axis, sign)
    if not editState.enabled or not currentAttach then return end
    local mult = editState.coarse and 10 or 1
    local step = (editState.stepR or 1.0) * (sign or 1) * mult
    if axis == 'x' then currentAttach.rotX = normalizeAngle(currentAttach.rotX + step)
    elseif axis == 'y' then currentAttach.rotY = normalizeAngle(currentAttach.rotY + step)
    elseif axis == 'z' then currentAttach.rotZ = normalizeAngle(currentAttach.rotZ + step) end
    reattachUsingCurrent()
    saveState.pending = true
    saveState.lastChange = GetGameTimer()
end

-- Offset keybind commands
RegisterCommand('bag_offx_inc', function() nudgeOffset('x', 1) end, false)
RegisterCommand('bag_offx_dec', function() nudgeOffset('x', -1) end, false)
RegisterCommand('bag_offy_inc', function() nudgeOffset('y', 1) end, false)
RegisterCommand('bag_offy_dec', function() nudgeOffset('y', -1) end, false)
RegisterCommand('bag_offz_inc', function() nudgeOffset('z', 1) end, false)
RegisterCommand('bag_offz_dec', function() nudgeOffset('z', -1) end, false)

-- Rotation keybind commands
RegisterCommand('bag_rotx_inc', function() nudgeRotation('x', 1) end, false)
RegisterCommand('bag_rotx_dec', function() nudgeRotation('x', -1) end, false)
RegisterCommand('bag_roty_inc', function() nudgeRotation('y', 1) end, false)
RegisterCommand('bag_roty_dec', function() nudgeRotation('y', -1) end, false)
RegisterCommand('bag_rotz_inc', function() nudgeRotation('z', 1) end, false)
RegisterCommand('bag_rotz_dec', function() nudgeRotation('z', -1) end, false)

-- Default key mappings (players can remap in GTA settings)
RegisterKeyMapping('bagedit', 'Toggle bag edit mode', 'keyboard', 'F7')
RegisterKeyMapping('bagstep_toggle', 'Toggle coarse step (x10)', 'keyboard', 'NUMPAD5')

RegisterKeyMapping('bag_offx_inc', 'Bag offset X +', 'keyboard', 'NUMPAD6')
RegisterKeyMapping('bag_offx_dec', 'Bag offset X -', 'keyboard', 'NUMPAD4')
RegisterKeyMapping('bag_offy_inc', 'Bag offset Y +', 'keyboard', 'NUMPAD8')
RegisterKeyMapping('bag_offy_dec', 'Bag offset Y -', 'keyboard', 'NUMPAD2')
RegisterKeyMapping('bag_offz_inc', 'Bag offset Z +', 'keyboard', 'NUMPAD9')
RegisterKeyMapping('bag_offz_dec', 'Bag offset Z -', 'keyboard', 'NUMPAD3')

RegisterKeyMapping('bag_rotx_inc', 'Bag rotation X +', 'keyboard', 'NUMPAD7')
RegisterKeyMapping('bag_rotx_dec', 'Bag rotation X -', 'keyboard', 'NUMPAD1')
RegisterKeyMapping('bag_roty_inc', 'Bag rotation Y +', 'keyboard', 'PAGEUP')
RegisterKeyMapping('bag_roty_dec', 'Bag rotation Y -', 'keyboard', 'PAGEDOWN')

-- Generic yaw commands bound to arrow keys by default
RegisterCommand('bag_yaw_inc', function() nudgeRotation(YAW_AXIS, 1) end, false)
RegisterCommand('bag_yaw_dec', function() nudgeRotation(YAW_AXIS, -1) end, false)
RegisterKeyMapping('bag_yaw_inc', 'Bag rotation Yaw + (arrow right)', 'keyboard', 'RIGHT')
RegisterKeyMapping('bag_yaw_dec', 'Bag rotation Yaw - (arrow left)', 'keyboard', 'LEFT')

-- Fallback: direct arrow-key handling for yaw while editing
-- Some setups won't trigger RegisterKeyMapping for arrow keys.
-- This loop captures LEFT/RIGHT and nudges rotation Z accordingly.
CreateThread(function()
    while true do
        if editState.enabled then
            -- FRONTEND_LEFT/RIGHT controls
            -- 174 = LEFT, 175 = RIGHT
            DisableControlAction(0, 174, true)
            DisableControlAction(0, 175, true)

            local used = false
            if IsDisabledControlPressed(0, 175) then -- Right Arrow
                nudgeRotation(YAW_AXIS, 1)
                used = true
            end
            if IsDisabledControlPressed(0, 174) then -- Left Arrow
                nudgeRotation(YAW_AXIS, -1)
                used = true
            end

            if used then
                -- Small repeat delay to avoid spamming too fast
                Wait(120)
            else
                Wait(0)
            end
        else
            Wait(300)
        end
    end
end)

-- Print a ready-to-paste snippet for config.lua (current variant + model sex)
RegisterCommand('bagsave', function()
    if not (lib and lib.callback and lib.callback.await and lib.callback.await('wasabi_backpack:canEditAttach', 200)) then
        if lib and lib.notify then lib.notify({ title = 'Backpack Edit', description = 'Permission refusÃ©e.', type = 'error' }) end
        return
    end
    if not currentAttach then
        print('bagsave: no current attach')
        if lib and lib.notify then lib.notify({ title = 'Backpack Edit', description = 'Aucun sac Ã  sauvegarder.', type = 'error' }) end
        return
    end
    local model = GetEntityModel(ped)
    local gender = 'male'
    if model == `mp_f_freemode_01` then gender = 'female' end
    local variant = equippedBagName or 'VARIANT_NAME_HERE'
    local t = currentAttach
    -- Persist to server as well
    TriggerServerEvent('wasabi_backpack:saveAttach', variant, gender, t)
    local snippet = ([[
Config.BagVariants.%s.attach = Config.BagVariants.%s.attach or {}
Config.BagVariants.%s.attach.%s = {
    bone = %d,
    offset = { x = %.3f, y = %.3f, z = %.3f },
    rotation = { x = %.1f, y = %.1f, z = %.1f }
}
]]):format(variant, variant, variant, gender, t.bone, t.offX, t.offY, t.offZ, t.rotX, t.rotY, t.rotZ)
    print('----- wasabi_backpack attach snippet -----')
    print(snippet)
    print('------------------------------------------')
    if lib and lib.notify then lib.notify({ title = 'Backpack Edit', description = 'Snippet imprimÃ© dans la console F8.', type = 'success' }) end
end, false)

-- Clear saved override for current variant (current gender)
RegisterCommand('bagreset', function(_, args)
    if not (lib and lib.callback and lib.callback.await and lib.callback.await('wasabi_backpack:canEditAttach', 200)) then
        if lib and lib.notify then lib.notify({ title = 'Backpack Edit', description = 'Permission refusÃ©e.', type = 'error' }) end
        return
    end
    local variant = equippedBagName
    if not variant then
        print('bagreset: aucun sac Ã©quipÃ©')
        if lib and lib.notify then lib.notify({ title = 'Backpack Edit', description = 'Aucun sac Ã©quipÃ©.', type = 'error' }) end
        return
    end
    local genderArg = args and args[1]
    local model = GetEntityModel(ped)
    local gender = (model == `mp_f_freemode_01`) and 'female' or 'male'
    if genderArg == 'male' or genderArg == 'female' then gender = genderArg end
    TriggerServerEvent('wasabi_backpack:clearAttach', variant, gender)
    -- Reattach with config defaults, removing any override
    local data = (Config.BagVariants and Config.BagVariants[variant]) or {}
    local attachDefaults = selectAttachment(data.attach)
    local bone = (attachDefaults and attachDefaults.bone) or defaultAttach.bone
    local offX, offY, offZ = asVectorComponents(attachDefaults and attachDefaults.offset, defaultAttach.offset)
    local rotX, rotY, rotZ = asVectorComponents(attachDefaults and attachDefaults.rotation, defaultAttach.rotation)

    equippedBagName = variant
    equippedModel = data.model or equippedModel
    equippedAttachment = data.attach

    if bagEquipped and bagObj and DoesEntityExist(bagObj) then
        currentAttach = {
            bone = bone,
            offX = offX, offY = offY, offZ = offZ,
            rotX = rotX, rotY = rotY, rotZ = rotZ,
        }
        reattachUsingCurrent()
    else
        local previousModel = equippedModel
        currentAttach = nil
        RemoveBag()
        equippedBagName = variant
        equippedModel = data.model or previousModel
        equippedAttachment = data.attach
        PutOnBag(equippedModel)
    end

    saveState.pending = false
    saveState.lastChange = GetGameTimer()
    if lib and lib.notify then lib.notify({ title = 'Backpack Edit', description = ('Override supprimÃ©: %s/%s'):format(variant, gender), type = 'inform' }) end
end, false)

-- Debounced auto-save loop
CreateThread(function()
    while true do
        if editState.enabled and saveState.pending then
            local now = GetGameTimer()
            if now - (saveState.lastChange or now) > saveState.cooldown then
                saveState.pending = false
                sendSaveNow()
            end
            Wait(50)
        else
            Wait(250)
        end
    end
end)

