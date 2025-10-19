local alcoholCount = 0
local healing = false
local smokingWeed = false
local weedEffectTick = 0
local weedFadeActive = false
local weedStressLoopCount = 0
local weedVisualActive = false
local weedEmoteCancelled = false

local weedFadeOutDuration = 45000
local weedFadeOutStep = 250
local weedFadeOutBlendDuration = 2000
local weedFadeInDuration = 20000
local weedFadeInStep = 1000

local function isScreenEffectActive(effectName)
    local checker = IsScreenEffectActive or GetScreenEffectIsActive

    if not checker then return false end

    return checker(effectName)
end

local function clearWeedVisualEffect(effectName, fadeOutEffect)
    if isScreenEffectActive(effectName) then
        StopScreenEffect(effectName)
    end

    if fadeOutEffect and isScreenEffectActive(fadeOutEffect) then
        StopScreenEffect(fadeOutEffect)
    end

    ClearTimecycleModifier()
    weedVisualActive = false
end

local function healOxy()
    if not healing then
        healing = true
    else
        return
    end

    local count = 9
    while count > 0 do
        Wait(1000)
        count -= 1
        SetEntityHealth(cache.ped, GetEntityHealth(cache.ped) + 6)
    end
    healing = false
end

local function trevorEffect()
    AnimpostfxPlay('DrugsTrevorClownsFightIn', 3.0, false)
    Wait(3000)
    AnimpostfxPlay('DrugsTrevorClownsFight', 3.0, false)
    Wait(3000)
    AnimpostfxPlay('DrugsTrevorClownsFightOut', 3.0, false)
    AnimpostfxStop('DrugsTrevorClownsFight')
    AnimpostfxStop('DrugsTrevorClownsFightIn')
    AnimpostfxStop('DrugsTrevorClownsFightOut')
end
exports('TrevorEffect', trevorEffect)

local function methBagEffect()
    local startStamina = 8
    trevorEffect()
    SetRunSprintMultiplierForPlayer(cache.playerId, 1.49)
    while startStamina > 0 do
        Wait(1000)
        if math.random(5, 100) < 10 then
            RestorePlayerStamina(cache.playerId, 1.0)
        end
        startStamina -= 1
        if math.random(5, 100) < 51 then
            trevorEffect()
        end
    end
    SetRunSprintMultiplierForPlayer(cache.playerId, 1.0)
end
exports('MethBagEffect', methBagEffect)

local function ecstasyEffect()
    local startStamina = 30
    SetFlash(0, 0, 500, 7000, 500)
    while startStamina > 0 do
        Wait(1000)
        startStamina -= 1
        RestorePlayerStamina(cache.playerId, 1.0)
        if math.random(1, 100) < 51 then
            SetFlash(0, 0, 500, 7000, 500)
            ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08)
        end
    end
    if IsPedRunning(cache.ped) then
        SetPedToRagdoll(cache.ped, math.random(1000, 3000), math.random(1000, 3000), 3, false, false, false)
    end
end
exports('EcstasyEffect', ecstasyEffect)

local function alienEffect()
    AnimpostfxPlay('DrugsMichaelAliensFightIn', 3.0, false)
    Wait(math.random(5000, 8000))
    AnimpostfxPlay('DrugsMichaelAliensFight', 3.0, false)
    Wait(math.random(5000, 8000))
    AnimpostfxPlay('DrugsMichaelAliensFightOut', 3.0, false)
    AnimpostfxStop('DrugsMichaelAliensFightIn')
    AnimpostfxStop('DrugsMichaelAliensFight')
    AnimpostfxStop('DrugsMichaelAliensFightOut')
end
exports('AlienEffect', alienEffect)

local function crackBaggyEffect()
    local startStamina = 8
    alienEffect()
    SetRunSprintMultiplierForPlayer(cache.playerId, 1.3)
    while startStamina > 0 do
        Wait(1000)
        if math.random(1, 100) < 10 then
            RestorePlayerStamina(cache.playerId, 1.0)
        end
        startStamina -= 1
        if math.random(1, 100) < 60 and IsPedRunning(cache.ped) then
            SetPedToRagdoll(cache.ped, math.random(1000, 2000), math.random(1000, 2000), 3, false, false, false)
        end
        if math.random(1, 100) < 51 then
            alienEffect()
        end
    end
    if IsPedRunning(cache.ped) then
        SetPedToRagdoll(cache.ped, math.random(1000, 3000), math.random(1000, 3000), 3, false, false, false)
    end
    SetRunSprintMultiplierForPlayer(cache.playerId, 1.0)
end
exports('CrackBaggyEffect', crackBaggyEffect)

local function cokeBaggyEffect()
    local startStamina = 20
    alienEffect()
    SetRunSprintMultiplierForPlayer(cache.playerId, 1.1)
    while startStamina > 0 do
        Wait(1000)
        if math.random(1, 100) < 20 then
            RestorePlayerStamina(cache.playerId, 1.0)
        end
        startStamina -= 1
        if math.random(1, 100) < 10 and IsPedRunning(cache.ped) then
            SetPedToRagdoll(cache.ped, math.random(1000, 3000), math.random(1000, 3000), 3, false, false, false)
        end
        if math.random(1, 300) < 10 then
            alienEffect()
            Wait(math.random(3000, 6000))
        end
    end
    if IsPedRunning(cache.ped) then
        SetPedToRagdoll(cache.ped, math.random(1000, 3000), math.random(1000, 3000), 3, false, false, false)
    end
    SetRunSprintMultiplierForPlayer(cache.playerId, 1.0)
end
exports('CokeBaggyEffect', cokeBaggyEffect)

local function startWeedHighEffect()
    weedEffectTick += 1
    local currentTick = weedEffectTick

    CreateThread(function()
        local effectName = 'DrugsDrivingIn'
        local fadeOutEffect = 'DrugsDrivingOut'
        local timecycle = 'spectator5'
        local fadeInDuration = weedFadeInDuration
        local fadeInStep = weedFadeInStep

        Wait(10000)

        if currentTick ~= weedEffectTick or not smokingWeed then
            if not weedFadeActive then
                clearWeedVisualEffect(effectName, fadeOutEffect)
            end
            return
        end

        StartScreenEffect(effectName, 0, false)
        weedVisualActive = true

        local elapsed = 0
        while elapsed < fadeInDuration do
            if currentTick ~= weedEffectTick or not smokingWeed then
                break
            end

            local strength = (elapsed + fadeInStep) / fadeInDuration
            if strength > 1.0 then strength = 1.0 end

            SetTimecycleModifier(timecycle)
            SetTimecycleModifierStrength(strength)

            Wait(fadeInStep)
            elapsed += fadeInStep
        end

        if currentTick ~= weedEffectTick or not smokingWeed then
            if not weedFadeActive then
                clearWeedVisualEffect(effectName, fadeOutEffect)
            end
            return
        end

        SetTimecycleModifier(timecycle)
        SetTimecycleModifierStrength(1.0)

        while true do
            Wait(1000)

            if currentTick ~= weedEffectTick or not smokingWeed then
                break
            end

            if not weedFadeActive and not isScreenEffectActive(effectName) then
                StartScreenEffect(effectName, 0, false)
            end
        end

        if weedFadeActive then
            return
        end

        if currentTick ~= weedEffectTick then
            clearWeedVisualEffect(effectName, fadeOutEffect)
            return
        end

        StopScreenEffect(effectName)
        StartScreenEffect(fadeOutEffect, 0, false)
        Wait(2000)
        clearWeedVisualEffect(effectName, fadeOutEffect)
    end)
end

local function stopSmokingWeed(cancelEffects)
    if not smokingWeed and not weedFadeActive then return end

    smokingWeed = false
    weedFadeActive = false
    weedStressLoopCount = 0
    weedEffectTick += 1
    weedEmoteCancelled = false

    if cancelEffects then
        clearWeedVisualEffect('DrugsDrivingIn', 'DrugsDrivingOut')
    end

    exports.scully_emotemenu:cancelEmote()
end

local function smokeWeed()
    if smokingWeed then
        weedStressLoopCount = 0
        if weedFadeActive then
            weedEffectTick += 1
            weedFadeActive = false
        end
        return
    end

    smokingWeed = true
    weedFadeActive = false
    weedStressLoopCount = 0
    weedEmoteCancelled = false

    CreateThread(function()
        local emoteCancelled = false

        while smokingWeed do
            if weedFadeActive then break end
            Wait(10000)
            if weedFadeActive or not smokingWeed then break end
            TriggerServerEvent('hud:server:RelieveStress', math.random(15, 18))
            if not emoteCancelled then
                if weedEmoteCancelled then
                    emoteCancelled = true
                else
                    weedStressLoopCount += 1
                    if weedStressLoopCount >= 6 then
                        exports.scully_emotemenu:cancelEmote()
                        emoteCancelled = true
                    end
                end
            end
        end
    end)
end

local function startWeedEffectFade()
    if weedFadeActive or (not smokingWeed and not weedVisualActive) then return end

    weedFadeActive = true
    weedEffectTick += 1
    local fadeTick = weedEffectTick

    CreateThread(function()
        local effectName = 'DrugsDrivingIn'
        local fadeOutEffect = 'DrugsDrivingOut'
        local timecycle = 'spectator5'
        local fadeDuration = weedFadeOutDuration
        local stepTime = weedFadeOutStep
        local elapsed = 0

        exports.scully_emotemenu:cancelEmote()

        if not weedVisualActive then
            Wait(math.min(5000, fadeDuration))

            if fadeTick ~= weedEffectTick or not weedFadeActive then
                weedFadeActive = false
                return
            end

            weedFadeActive = false
            stopSmokingWeed(false)
            return
        end

        local fadeOutStarted = false

        while elapsed < fadeDuration do
            if fadeTick ~= weedEffectTick or not weedFadeActive then
                weedFadeActive = false
                return
            end

            local progress = math.min((elapsed + stepTime) / fadeDuration, 1.0)
            local strength = 1.0 - progress
            if strength < 0.0 then strength = 0.0 end

            if strength > 0 then
                SetTimecycleModifier(timecycle)
                SetTimecycleModifierStrength(strength)
            end

            if not fadeOutStarted and progress >= 0.6 then
                StartScreenEffect(fadeOutEffect, weedFadeOutBlendDuration, false)
                fadeOutStarted = true
            end

            Wait(stepTime)
            elapsed += stepTime
        end

        if fadeTick ~= weedEffectTick or not weedFadeActive then
            weedFadeActive = false
            return
        end

        if not fadeOutStarted then
            StartScreenEffect(fadeOutEffect, weedFadeOutBlendDuration, false)
            Wait(weedFadeOutBlendDuration)
        else
            Wait(weedFadeOutBlendDuration)
        end

        clearWeedVisualEffect(effectName, fadeOutEffect)

        weedFadeActive = false
        stopSmokingWeed(false)
    end)
end

local function onEmoteCancelled()
    if smokingWeed then
        weedEmoteCancelled = true
        startWeedEffectFade()
    else
        stopSmokingWeed(true)
    end
end

AddEventHandler('scully_emotemenu:cancelEmote', onEmoteCancelled)

CreateThread(function()
    while not cache.serverId do
        Wait(0)
    end

    local bagName = ('player:%s'):format(cache.serverId)

    AddStateBagChangeHandler('isInEmote', bagName, function(_, _, value)
        if value == false then
            onEmoteCancelled()
        end
    end)
end)

lib.callback.register('consumables:client:Eat', function(anim, prop)
    if lib.progressBar({
        duration = 5000,
        label = locale('progress.eating'),
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = false,
            car = false,
            mouse = false,
            combat = true
        },
        anim = anim or {
            clip = 'mp_player_int_eat_burger',
            dict = 'mp_player_inteat@burger',
            flag = 49
        },
        prop = prop or {
            {
                model = 'prop_cs_burger_01',
                bone = 18905,
                pos = {x = 0.13, y = 0.05, z = 0.02},
                rot = {x = -50.0, y = 16.0, z = 60.0}
            }
        }
    }) then -- if completed
        startWeedEffectFade()
        return true
    else -- if canceled
        exports.qbx_core:Notify(locale('error.canceled'), 'error')
        return false
    end
end)

lib.callback.register('consumables:client:Drink', function(anim, prop)
    if lib.progressBar({
        duration = 5000,
        label = locale('progress.drinking'),
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = false,
            car = false,
            mouse = false,
            combat = true
        },
        anim = anim or {
            clip = 'loop_bottle',
            dict = 'mp_player_intdrink',
            flag = 49
        },
        prop = prop or {
            {
                model = 'prop_ld_flow_bottle',
                bone = 18905,
                pos = {x = 0.12, y = 0.008, z = 0.03},
                rot = {x = 240.0, y = -60.0, z = 0.0}
            }
        }
    }) then -- if completed
        return true
    else -- if canceled
        exports.qbx_core:Notify(locale('error.canceled'), 'error')
        return false
    end
end)

lib.callback.register('consumables:client:DrinkAlcohol', function(alcoholLevel, anim, prop)
    if lib.progressBar({
        duration = math.random(3000, 6000),
        label = locale('progress.drinking_liquor'),
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = false,
            car = false,
            mouse = false,
            combat = true
        },
        anim = anim or {
            clip = 'loop_bottle',
            dict = 'mp_player_intdrink',
            flag = 49
        },
        prop = prop or {
            {
                model = 'prop_amb_beer_bottle',
                bone = 18905,
                pos = {x = 0.12, y = 0.008, z = 0.03},
                rot = {x = 240.0, y = -60.0, z = 0.0}
            }
        }
    }) then -- if completed
        alcoholCount += alcoholLevel or 1
        if alcoholCount > 1 and alcoholCount < 4 then
            TriggerEvent('evidence:client:SetStatus', 'alcohol', 200)
        elseif alcoholCount >= 4 then
            TriggerEvent('evidence:client:SetStatus', 'heavyalcohol', 200)
        end
        return true
    else -- if canceled
        exports.qbx_core:Notify(locale('error.canceled'), 'error')
        return false
    end
end)

RegisterNetEvent('consumables:client:Cokebaggy', function()
    if lib.progressBar({
        duration = math.random(5000, 8000),
        label = locale('progress.popping_pills'),
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = false,
            car = false,
            mouse = false,
            combat = true
        },
        anim = {
            dict = 'switch@trevor@trev_smoking_meth',
            clip = 'trev_smoking_meth_loop',
            flag = 49
        }
    }) then -- if completed
        local used = lib.callback.await('consumables:server:usedItem', false, 'cokebaggy')
        if not used then return end

        TriggerEvent('evidence:client:SetStatus', 'widepupils', 200)
        cokeBaggyEffect()
    else -- if canceled
        exports.qbx_core:Notify(locale('error.canceled'), 'error')
    end
end)

RegisterNetEvent('consumables:client:Crackbaggy', function()
    if lib.progressBar({
        duration = math.random(7000, 10000),
        label = locale('progress.smoking_crack'),
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = false,
            car = false,
            mouse = false,
            combat = true
        },
        anim = {
            dict = 'switch@trevor@trev_smoking_meth',
            clip = 'trev_smoking_meth_loop',
            flag = 49
        }
    }) then -- if completed
        local used = lib.callback.await('consumables:server:usedItem', false, 'crack_baggy')
        if not used then return end

        TriggerEvent('evidence:client:SetStatus', 'widepupils', 300)
        crackBaggyEffect()
    else -- if canceled
        exports.qbx_core:Notify(locale('error.canceled'), 'error')
    end
end)

RegisterNetEvent('consumables:client:EcstasyBaggy', function()
    if lib.progressBar({
        duration = 3000,
        label = locale('progress.popping_pills'),
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = false,
            car = false,
            mouse = false,
            combat = true
        },
        anim = {
            dict = 'mp_suicide',
            clip = 'pill',
            flag = 49
        }
    }) then -- if completed
        local used = lib.callback.await('consumables:server:usedItem', false, 'xtcbaggy')
        if not used then return end

        ecstasyEffect()
    else -- if canceled
        exports.qbx_core:Notify(locale('error.canceled'), 'error')
    end
end)

RegisterNetEvent('consumables:client:oxy', function()
    if lib.progressBar({
        duration = 2000,
        label = locale('progress.healing'),
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = false,
            car = false,
            mouse = false,
            combat = true
        },
        anim = {
            dict = 'mp_suicide',
            clip = 'pill',
            flag = 49
        }
    }) then -- if completed
        local used = lib.callback.await('consumables:server:usedItem', false, 'oxy')
        if not used then return end

        ClearPedBloodDamage(cache.ped)
        healOxy()
    else -- if canceled
        exports.qbx_core:Notify(locale('error.canceled'), 'error')
    end
end)

RegisterNetEvent('consumables:client:meth', function()
    if lib.progressBar({
        duration = 1500,
        label = locale('progress.smoking_meth'),
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = false,
            car = false,
            mouse = false,
            combat = true
        },
        anim = {
            dict = 'switch@trevor@trev_smoking_meth',
            clip = 'trev_smoking_meth_loop',
            flag = 49
        }
    }) then -- if completed
        local used = lib.callback.await('consumables:server:usedItem', false, 'meth')
        if not used then return end

        TriggerEvent('evidence:client:SetStatus', 'widepupils', 300)
        TriggerEvent('evidence:client:SetStatus', 'agitated', 300)
        methBagEffect()
    else -- if canceled
        exports.qbx_core:Notify(locale('error.canceled'), 'error')
    end
end)

RegisterNetEvent('consumables:client:UseJoint', function()
    if lib.progressBar({
        duration = 1500,
        label = locale('progress.lighting_joint'),
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = false,
            car = false,
            mouse = false,
            combat = true
        }
    }) then -- if completed
        local used = lib.callback.await('consumables:server:usedItem', false, 'joint')
        if not used then return end

        exports.scully_emotemenu:playEmoteByCommand('smoke7')
        TriggerEvent('evidence:client:SetStatus', 'weedsmell', 300)
        smokeWeed()
        startWeedHighEffect()
    else -- if canceled
        exports.qbx_core:Notify(locale('error.canceled'), 'error')
    end
end)

--@TODO Rework this to only run when needed.
CreateThread(function()
    while true do
        Wait(10)
        if alcoholCount > 0 then
            Wait(1000 * 60 * 15)
            alcoholCount -= 1
        else
            Wait(2000)
        end
    end
end)