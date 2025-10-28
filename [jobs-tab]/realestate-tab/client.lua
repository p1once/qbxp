local open = false
local object = nil

-- Job restriction
local function isRealtor()
    -- Use the same convar as the rest of the server for consistency
    local realtorJob = GetConvar('realestate_tablet:job', 'realestate')
    local data = (QBX and QBX.PlayerData) or (exports and exports.qbx_core and exports.qbx_core.GetPlayerData and exports.qbx_core:GetPlayerData()) or nil
    local job = data and data.job or nil
    return job and job.name == realtorJob
end

local anim = Config.AnimDict
local prop = Config.Prop
local bone = Config.Bone

-- Utils
local function LoadDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(100)
    end
end

local function LoadProp(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(100)
    end
end

-- Toggle tablet & animation
local function ToggleTablet(state)
    local ped = PlayerPedId()
    open = state
    
    if state then
        LoadDict(anim)

        if not object or not DoesEntityExist(object) then
            LoadProp(prop)

            local coords = GetEntityCoords(ped)
            local hand = GetPedBoneIndex(ped, bone)

            object = CreateObject(GetHashKey(prop), coords.x, coords.y, coords.z, true, false, false)
            -- Offsets/rotations adaptés pour rendre la tablette visible dans la main droite
            -- Position (x, y, z) et Rotation (pitch, roll, yaw)
            AttachEntityToEntity(object, ped, hand, 0.03, 0.02, -0.02, 10.0, 160.0, 0.0, true, true, false, true, 1, true)
        end

        if not IsEntityPlayingAnim(ped, anim, 'base', 3) then
            TaskPlayAnim(ped, anim, 'base', 8.0, 1.0, -1, 49, 1.0, false, false, false)
        end

        SetNuiFocus(state, state)
        SendNUIMessage({ 
            action = 'open' 
        })
    else
        if object and DoesEntityExist(object) then
            DetachEntity(object, true, true)
            DeleteEntity(object)
            object = nil
        end
        ClearPedTasks(ped)

        SetNuiFocus(state, state)
        SendNUIMessage({ 
            action = 'close' 
        })
    end
end

-- Event for server-side
-- Open events (keep original and add a clear alias)
RegisterNetEvent('redutzu-tablet:client:open', function()
    if isRealtor() then ToggleTablet(true) end
end)

RegisterNetEvent('realestate-tab:client:open', function()
    -- Server already validated job for item use; open unconditionally here
    ToggleTablet(true)
end)

-- Close 
RegisterNUICallback('close', function(data, cb)
    ToggleTablet(false)
    cb('ok')
end)

-- NUI bridges to qbx_properties
RegisterNUICallback('listProperties', function(data, cb)
    if not isRealtor() then cb({ items = {}, total = 0 }) return end
    local result = lib.callback.await('qbx_properties:callback:listProperties', false, data or {})
    cb(result or { items = {}, total = 0 })
end)

RegisterNUICallback('getProperty', function(data, cb)
    if not isRealtor() then cb(nil) return end
    local id = tonumber(data and data.id)
    if not id then cb(nil) return end
    local prop = lib.callback.await('qbx_properties:callback:getProperty', false, id)
    cb(prop)
end)

RegisterNUICallback('updateProperty', function(data, cb)
    if not isRealtor() then cb({ ok = false, error = 'forbidden' }) return end
    local res = lib.callback.await('qbx_properties:callback:updateProperty', false, data)
    cb(res or { ok = false })
end)

RegisterNUICallback('setGarageHere', function(data, cb)
    if not isRealtor() then cb({ ok = false, error = 'forbidden' }) return end
    local res = lib.callback.await('qbx_properties:callback:setGarageHere', false, { id = tonumber(data.id) })
    cb(res or { ok = false })
end)

RegisterNUICallback('deleteProperty', function(data, cb)
    if not isRealtor() then cb({ ok = false, error = 'forbidden' }) return end
    TriggerServerEvent('qbx_properties:server:deleteProperty', tonumber(data.id))
    cb({ ok = true })
end)

RegisterNUICallback('transferOwnership', function(data, cb)
    if not isRealtor() then cb({ ok = false, error = 'forbidden' }) return end
    local res = lib.callback.await('qbx_properties:callback:transferOwnership', false, { id = tonumber(data.id), target = tostring(data.target) })
    cb(res or { ok = false })
end)

RegisterNUICallback('rentPropertyTo', function(data, cb)
    if not isRealtor() then cb({ ok = false, error = 'forbidden' }) return end
    TriggerServerEvent('qbx_properties:server:rentPropertyTo', tonumber(data.id), tostring(data.target))
    cb({ ok = true })
end)

RegisterNUICallback('buyPropertyTo', function(data, cb)
    if not isRealtor() then cb({ ok = false, error = 'forbidden' }) return end
    TriggerServerEvent('qbx_properties:server:buyPropertyTo', tonumber(data.id), tostring(data.target))
    cb({ ok = true })
end)

RegisterNUICallback('evict', function(data, cb)
    if not isRealtor() then cb({ ok = false, error = 'forbidden' }) return end
    TriggerServerEvent('qbx_properties:server:evict', tonumber(data.id))
    cb({ ok = true })
end)

RegisterNUICallback('startVisit', function(data, cb)
    if not isRealtor() then cb({ ok = false, error = 'forbidden' }) return end
    TriggerServerEvent('qbx_properties:server:startVisit', tonumber(data.id), tostring(data.target))
    cb({ ok = true })
end)

RegisterNUICallback('createProperty', function(_, cb)
    if isRealtor() then
        TriggerEvent('qbx_properties:client:createProperty')
    end
    cb({ ok = true })
end)

-- Command / Keybind

RegisterCommand(Config.Command, function()
    if isRealtor() then
        ToggleTablet(true)
    end
end, false)

if Config.Keybind then
    RegisterKeyMapping(Config.Command, Config.CommandDescription, 'KEYBOARD', Config.OpenKey)
end
