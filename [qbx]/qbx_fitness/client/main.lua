local config = require 'config.client'

local timers = {}
local cooldowns = {}
local quickWorkouts = config.quickWorkouts or {}
local quickScenarioLocks = {}
local activeQuickWorkout
local quickMenuId = 'qbx_fitness:quick_workouts'
local tickRate = config.tickRate or 1000

local strengthConfig = config.activities.strength or {}
local scenarioConfig = strengthConfig.scenarios or {}
local scenarioEntries = scenarioConfig.entries or {}

for name, entry in pairs(scenarioEntries) do
    entry.identifier = name
end

for name, entry in pairs(quickWorkouts) do
    entry.name = name
    entry.stat = entry.stat or 'strength'
    entry.amount = entry.amount or 0.15
    entry.duration = entry.duration or 15000
    entry.cooldown = entry.cooldown or 60000
    if entry.scenarioEntry and scenarioEntries[entry.scenarioEntry] then
        quickScenarioLocks[entry.scenarioEntry] = false
    end
end

local function resetTimers()
    for key in pairs(timers) do
        timers[key] = 0
    end
end

local function isPlayerAvailable(ped)
    if not ped or ped == 0 then return false end
    if IsEntityDead(ped) then return false end
    if IsPedRagdoll(ped) then return false end
    return true
end

local function onCooldown(key)
    local expires = cooldowns[key]
    return expires and expires > GetGameTimer()
end

local function setCooldown(key, duration)
    if not duration or duration <= 0 then
        cooldowns[key] = nil
        return
    end
    cooldowns[key] = GetGameTimer() + duration
end

local function trackActivity(key, stat, settings, isActive, context)
    if context and context.lockName and quickScenarioLocks[context.lockName] == true then
        timers[key] = 0
        return
    end

    if not settings or settings.enabled == false or not settings.amount or settings.amount == 0 then
        timers[key] = 0
        return
    end

    if not isActive then
        timers[key] = 0
        return
    end

    if not settings.duration or settings.duration <= 0 then return end

    timers[key] = (timers[key] or 0) + tickRate

    if timers[key] < settings.duration then return end
    if onCooldown(key) then return end

    timers[key] = 0
    setCooldown(key, settings.cooldown)
    TriggerServerEvent('qbx_fitness:server:modifyStat', stat, settings.amount, { activity = key })
end

local function getQuickCooldownKey(name)
    return ('quick:%s'):format(name)
end

local function isPedInQuickScenario(ped, entry)
    if not ped or ped == 0 then return false end
    if entry.scenario and IsPedUsingScenario and IsPedUsingScenario(ped, entry.scenario) then
        return true
    end
    if entry.animDict and entry.anim then
        if IsEntityPlayingAnim(ped, entry.animDict, entry.anim, 3) then
            return true
        end
        if IsEntityPlayingAnim(ped, entry.animDict, entry.anim, 1) then
            return true
        end
    end
    return IsPedActiveInScenario(ped)
end

local function finishQuickWorkout(result)
    local state = activeQuickWorkout
    if not state then return end

    activeQuickWorkout = nil

    local entry = state.entry
    if entry and entry.scenarioEntry then
        quickScenarioLocks[entry.scenarioEntry] = nil
    end

    local ped = cache.ped
    if ped and ped ~= 0 then
        ClearPedTasksImmediately(ped)
    end

    if not entry then return end

    local cooldownKey = state.cooldownKey or getQuickCooldownKey(state.name)

    if result == 'success' then
        TriggerServerEvent('qbx_fitness:server:modifyStat', entry.stat, entry.amount, {
            activity = ('quick:%s'):format(state.name),
            label = entry.label or state.name,
            quick = true,
        })
        exports.qbx_core:Notify(('Entrainement rapide termine (%s).'):format(entry.label or state.name), 'success')
        setCooldown(cooldownKey, entry.cooldown or 60000)
    elseif result == 'cancel' then
        exports.qbx_core:Notify('Exercice interrompu.', 'error')
        setCooldown(cooldownKey, entry.cancelCooldown or 5000)
    elseif result == 'failed' then
        exports.qbx_core:Notify("Impossible de lancer l'exercice ici.", 'error')
        setCooldown(cooldownKey, entry.failCooldown or 2000)
    end
end

local function startQuickWorkout(rawName)
    if type(rawName) ~= 'string' then return end

    local name = rawName:lower()
    local entry = quickWorkouts[name]
    if not entry then
        exports.qbx_core:Notify('Exercice introuvable.', 'error')
        return
    end

    if not LocalPlayer or not LocalPlayer.state or not LocalPlayer.state.isLoggedIn then
        exports.qbx_core:Notify('Vous devez etre connecte pour faire cet exercice.', 'error')
        return
    end

    local ped = cache.ped
    if not isPlayerAvailable(ped) or IsPedInAnyVehicle(ped, false) then
        exports.qbx_core:Notify('Vous ne pouvez pas faire cet exercice maintenant.', 'error')
        return
    end

    if activeQuickWorkout then
        if activeQuickWorkout.name == name then
            finishQuickWorkout('cancel')
            return
        else
            finishQuickWorkout('cancel')
        end
    end

    if not entry.scenario then
        exports.qbx_core:Notify('Cet exercice n\'est pas correctement configure.', 'error')
        return
    end

    local cooldownKey = getQuickCooldownKey(name)
    if onCooldown(cooldownKey) then
        exports.qbx_core:Notify('Reprenez votre souffle avant de recommencer.', 'inform')
        return
    end

    if entry.fixedPosition and entry.fixedPosition.heading then
        local target = vec3(entry.fixedPosition.x, entry.fixedPosition.y, entry.fixedPosition.z)
        local radius = entry.fixedPosition.radius or 5.0
        local pedCoords = GetEntityCoords(ped)
        if #(pedCoords - target) <= radius then
            SetEntityHeading(ped, entry.fixedPosition.heading)
        end
    end

    ClearPedTasksImmediately(ped)

    activeQuickWorkout = {
        name = name,
        entry = entry,
        cooldownKey = cooldownKey,
    }

    if entry.scenarioEntry then
        quickScenarioLocks[entry.scenarioEntry] = true
    end

    TaskStartScenarioInPlace(ped, entry.scenario, 0, true)

    CreateThread(function()
        Wait(600)

        if not activeQuickWorkout or activeQuickWorkout.name ~= name then return end

        local pedRef = cache.ped
        if not isPedInQuickScenario(pedRef, entry) then
            finishQuickWorkout('failed')
            return
        end

        exports.qbx_core:Notify(('Debut de %s. Restez en position pour valider.'):format(entry.label or name), 'inform')

        local startTime = GetGameTimer()
        local required = entry.duration or 15000

        while activeQuickWorkout and activeQuickWorkout.name == name do
            Wait(250)

            pedRef = cache.ped
            if not isPlayerAvailable(pedRef) then
                finishQuickWorkout('cancel')
                return
            end

            if not isPedInQuickScenario(pedRef, entry) then
                finishQuickWorkout('cancel')
                return
            end

            if GetGameTimer() - startTime >= required then
                finishQuickWorkout('success')
                return
            end
        end
    end)
end

RegisterNetEvent('qbx_fitness:client:openQuickWorkoutMenu', function()
    if not LocalPlayer or not LocalPlayer.state or not LocalPlayer.state.isLoggedIn then
        exports.qbx_core:Notify('Connectez-vous pour ouvrir ce menu.', 'error')
        return
    end

    if not next(quickWorkouts) then
        exports.qbx_core:Notify('Aucun exercice rapide disponible.', 'error')
        return
    end

    local entries = {}
    for name, entry in pairs(quickWorkouts) do
        entries[#entries + 1] = {
            name = name,
            label = entry.label or name,
            data = entry,
        }
    end

    table.sort(entries, function(a, b)
        return a.label < b.label
    end)

    local options = {}

    if activeQuickWorkout then
        table.insert(options, {
            title = 'Arreter l\'exercice',
            description = 'Met fin a la session en cours.',
            icon = 'circle-xmark',
            iconColor = '#c0392b',
            onSelect = function()
                finishQuickWorkout('cancel')
            end
        })
    end

    local now = GetGameTimer()

    for _, entry in ipairs(entries) do
        local name = entry.name
        local data = entry.data
        local cooldownKey = getQuickCooldownKey(name)
        local onCd = onCooldown(cooldownKey)
        local description = data.description or ''

        if onCd and cooldowns[cooldownKey] then
            local remaining = math.max(cooldowns[cooldownKey] - now, 0) / 1000
            local cdText = ('Disponible dans %.1f s.'):format(remaining)
            if description ~= '' then
                description = ('%s | %s'):format(description, cdText)
            else
                description = cdText
            end
        end

        local metadata = {
            { label = 'Gain', value = ('+%.2f force'):format(data.amount or 0.0) },
            { label = 'Duree', value = ('%d s'):format(math.floor((data.duration or 0) / 1000)) },
        }

        options[#options + 1] = {
            title = entry.label,
            description = description,
            icon = data.icon or 'dumbbell',
            disabled = onCd,
            metadata = metadata,
            onSelect = function()
                TriggerEvent('qbx_fitness:client:startQuickWorkout', name)
            end
        }
    end

    if #options == 0 then
        exports.qbx_core:Notify('Aucun exercice rapide disponible.', 'error')
        return
    end

    lib.registerContext({
        id = quickMenuId,
        title = 'Entrainement rapide',
        options = options,
        canClose = true,
    })

    lib.showContext(quickMenuId)
end)

RegisterNetEvent('qbx_fitness:client:startQuickWorkout', startQuickWorkout)

CreateThread(function()
    while true do
        Wait(tickRate)

        if not LocalPlayer.state.isLoggedIn then
            resetTimers()
        else
            local ped = cache.ped

            if not isPlayerAvailable(ped) then
                resetTimers()
            else
                local inVehicle = IsPedInAnyVehicle(ped, false)
                local enduranceConfig = config.activities.endurance or {}
                local strengthConfig = config.activities.strength or {}

                local sprintActive = not inVehicle and (IsPedSprinting(ped) or (IsPedRunning(ped) and GetEntitySpeed(ped) > 3.0))
                trackActivity('endurance:sprint', 'endurance', enduranceConfig.sprint, sprintActive)

                local swimActive = IsPedSwimming(ped) or IsPedSwimmingUnderWater(ped)
                trackActivity('endurance:swim', 'endurance', enduranceConfig.swim, swimActive)

                local meleeActive = not inVehicle and (IsPedInMeleeCombat(ped) or IsPedPerformingMeleeAction(ped))
                trackActivity('strength:melee', 'strength', strengthConfig.melee, meleeActive)

                local scenarioConfig = strengthConfig.scenarios
                if scenarioConfig and scenarioConfig.enabled then
                    for name, entry in pairs(scenarioConfig.entries or {}) do
                        local key = ('strength:scenario:%s'):format(name)
                        local active = false

                        if entry.animDict and entry.anim then
                            active = IsEntityPlayingAnim(ped, entry.animDict, entry.anim, 3)
                        end

                        if entry.scenario and IsPedUsingScenario and IsPedUsingScenario(ped, entry.scenario) then
                            active = true
                        end

                        if not active and entry.animDict and entry.anim then
                            active = IsEntityPlayingAnim(ped, entry.animDict, entry.anim, 1)
                        end

                        local context = { lockName = entry.identifier or name }
                        trackActivity(key, 'strength', entry, (not inVehicle) and active, context)
                    end
                end
            end
        end
    end
end)

local function modifyStat(stat, amount, activity)
    TriggerServerEvent('qbx_fitness:server:modifyStat', stat, amount, activity)
end

exports('ModifyStat', modifyStat)

exports('GetStat', function(stat)
    if type(stat) ~= 'string' then return 0 end
    stat = stat:lower()
    return LocalPlayer.state[stat] or 0
end)
