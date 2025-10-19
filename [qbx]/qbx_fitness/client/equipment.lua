local config = require 'config.client'

local equipmentConfig = config.equipment or {}
local workouts = equipmentConfig.workouts or {}
local spots = equipmentConfig.spots or {}
local areas = equipmentConfig.areas or {}

if (#spots == 0 and #areas == 0) or next(workouts) == nil then
    return
end

local useTarget = equipmentConfig.useTarget ~= false
local targetResource = equipmentConfig.targetResource or 'ox_target'
local targetIcon = equipmentConfig.targetIcon or 'fa-solid fa-dumbbell'
local interactControl = equipmentConfig.interactControl or 38
local cancelControl = equipmentConfig.cancelControl or 73
local defaultDuration = equipmentConfig.defaultDuration or 15000
local defaultCooldown = equipmentConfig.defaultCooldown or 0
local oxygenConfig = equipmentConfig.oxygen or {}
local oxygenDrain = oxygenConfig.drain or 4
local oxygenDrainInterval = oxygenConfig.drainInterval or 1500
local oxygenRecovery = oxygenConfig.recovery or 8
local oxygenRecoveryInterval = oxygenConfig.recoveryInterval or 1200
local oxygenWarningThreshold = oxygenConfig.warningThreshold or 25
local oxygenPostFx = oxygenConfig.postFx or 'DrugsDrivingIn'
local oxygenFaintDuration = oxygenConfig.faintDuration or 5000
local oxygenRecoveryAfterFaint = oxygenConfig.recoveryAfterFaint or 35
local oxygenRecoveryAnimDict = oxygenConfig.recoveryAnimDict or 'get_up@sat_on_floor@to_stand'
local oxygenRecoveryAnim = oxygenConfig.recoveryAnim or 'getup_0'
local oxygenRecoveryAnimFlag = oxygenConfig.recoveryAnimFlag or 0
-- Seuil de souffle pour autoriser l'enchaînement malgré le cooldown (par défaut: 100)
local oxygenChainThreshold = oxygenConfig.chainThreshold or 100
local zones = {}
local cooldowns = {}
local usingWorkout = false
local textVisible = false
local oxygenLevel = 100
local oxygenWarned = false
local shouldCancelWorkout = false
local fainting = false

-- Forward declaration so earlier functions capture the local
local canUseWorkout

local function updateFitnessOxygenState()
    if not LocalPlayer or not LocalPlayer.state then return end

    local active = usingWorkout or oxygenLevel < 100
    LocalPlayer.state:set('fitnessOxygen', math.floor(oxygenLevel + 0.5), false)
    LocalPlayer.state:set('fitnessOxygenActive', active, false)
end

local function handleOxygenWarning()
    if oxygenWarned or oxygenLevel > oxygenWarningThreshold then return end

    oxygenWarned = true
    exports.qbx_core:Notify('Vous commencez à manquer d\'oxygène, faites une pause !', 'warning')
end

local function resetOxygenWarning()
    if oxygenLevel > oxygenWarningThreshold then
        oxygenWarned = false
    end
end

local function handleOxygenDepleted()
    if fainting then return end

    fainting = true
    usingWorkout = false
    shouldCancelWorkout = true

    CreateThread(function()
        Wait(150)

        local ped = cache.ped
        if not ped or ped == 0 then
            fainting = false
            return
        end

        exports.qbx_core:Notify('Vous vous évanouissez par manque d\'oxygène.', 'error')

        AnimpostfxPlay(oxygenPostFx, 0, false)
        SetPedToRagdoll(ped, oxygenFaintDuration, oxygenFaintDuration, 0, true, true, false)
        Wait(oxygenFaintDuration)
        AnimpostfxStop(oxygenPostFx)

        ResetPedRagdollTimer(ped)
        ClearPedTasks(ped)

        if not IsEntityDead(ped) and not IsPedInAnyVehicle(ped, true) then
            loadAnimDict(oxygenRecoveryAnimDict)

            TaskPlayAnim(ped, oxygenRecoveryAnimDict, oxygenRecoveryAnim, 8.0, -8.0, -1, oxygenRecoveryAnimFlag, 0.0, false, false, false)

            local animationDuration = GetAnimDuration(oxygenRecoveryAnimDict, oxygenRecoveryAnim)
            if animationDuration and animationDuration > 0 then
                Wait(math.floor(animationDuration * 1000))
            else
                Wait(1500)
            end

            ClearPedTasks(ped)
        end

        oxygenLevel = oxygenRecoveryAfterFaint
        updateFitnessOxygenState()
        resetOxygenWarning()

        fainting = false
    end)
end

CreateThread(function()
    while not LocalPlayer or not LocalPlayer.state do
        Wait(0)
    end

    updateFitnessOxygenState()
end)

CreateThread(function()
    while true do
        local waitTime = 1000
        local state = LocalPlayer and LocalPlayer.state

        if state and state.isLoggedIn then
            if usingWorkout then
                waitTime = oxygenDrainInterval
                oxygenLevel = math.max(oxygenLevel - oxygenDrain, 0)
                updateFitnessOxygenState()

                if oxygenLevel <= oxygenWarningThreshold then
                    handleOxygenWarning()
                else
                    resetOxygenWarning()
                end

                if oxygenLevel <= 0 then
                    handleOxygenDepleted()
                end
            elseif oxygenLevel < 100 then
                waitTime = oxygenRecoveryInterval
                oxygenLevel = math.min(oxygenLevel + oxygenRecovery, 100)
                updateFitnessOxygenState()
                resetOxygenWarning()
            else
                resetOxygenWarning()
                if state.fitnessOxygenActive then
                    LocalPlayer.state:set('fitnessOxygenActive', false, false)
                end
            end
        else
            oxygenLevel = 100
            oxygenWarned = false
            updateFitnessOxygenState()
        end

        Wait(waitTime)
    end
end)

local function loadAnimDict(dict)
    if not dict or HasAnimDictLoaded(dict) then return end

    RequestAnimDict(dict)

    while not HasAnimDictLoaded(dict) do
        Wait(0)
        RequestAnimDict(dict)
    end
end

local function ensureAnimationsLoaded(animations)
    if not animations then return end

    for _, anim in pairs(animations) do
        if type(anim) == 'table' and anim.dict then
            loadAnimDict(anim.dict)
        end
    end
end

local function loadModel(model)
    if type(model) == 'string' then
        model = joaat(model)
    end

    if HasModelLoaded(model) then return model end

    RequestModel(model)

    while not HasModelLoaded(model) do
        Wait(0)
        RequestModel(model)
    end

    return model
end

local function attachProps(ped, props)
    if not props then return {} end

    local objects = {}
    local pedCoords = GetEntityCoords(ped)

    for index = 1, #props do
        local definition = props[index]

        if definition and definition.model then
            local model = loadModel(definition.model)
            local object = CreateObject(model, pedCoords.x, pedCoords.y, pedCoords.z, true, true, false)

            local offset = definition.offset or vec3(0.0, 0.0, 0.0)
            local rotation = definition.rotation or vec3(0.0, 0.0, 0.0)
            local bone = definition.bone or 28422

            AttachEntityToEntity(object, ped, GetPedBoneIndex(ped, bone), offset.x, offset.y, offset.z, rotation.x, rotation.y, rotation.z, true, true, false, true, 1, true)

            objects[#objects + 1] = object
            SetModelAsNoLongerNeeded(model)
        end
    end

    return objects
end

local function cleanupProps(objects)
    if not objects then return end

    for index = 1, #objects do
        local object = objects[index]

        if object and DoesEntityExist(object) then
            if IsEntityAttached(object) then
                DetachEntity(object, true, true)
            end
            SetEntityAsMissionEntity(object, true, true)
            DeleteEntity(object)
        end
    end
end

local function resolveWorkoutAnchor(ped, workout, context)
    if not workout then return end

    local animations = workout.animations
    local anchorConfig = workout.anchor or (animations and animations.anchor)
    if not anchorConfig then return end

    local searchCoords
    if context and context.coords then
        local c = context.coords
        searchCoords = vec3(c.x, c.y, c.z)
    else
        local pedCoords = GetEntityCoords(ped)
        searchCoords = vec3(pedCoords.x, pedCoords.y, pedCoords.z)
    end

    local anchorEntity
    local anchorPosition
    local anchorRotation

    if anchorConfig.model then
        local model = type(anchorConfig.model) == 'string' and joaat(anchorConfig.model) or anchorConfig.model
        local radius = anchorConfig.radius or 2.0
        local entity = GetClosestObjectOfType(searchCoords.x, searchCoords.y, searchCoords.z, radius, model, false, false, false)
        if entity and entity ~= 0 then
            anchorEntity = entity
            anchorPosition = GetEntityCoords(entity)
            anchorRotation = GetEntityRotation(entity, 2)
        end
    end

    if not anchorPosition then
        anchorPosition = searchCoords
        local heading = context and context.coords and context.coords.w or GetEntityHeading(ped)
        anchorRotation = vec3(0.0, 0.0, heading)
    end

    local offset = anchorConfig.offset
    if offset then
        anchorPosition = vec3(
            anchorPosition.x + offset.x,
            anchorPosition.y + offset.y,
            anchorPosition.z + offset.z
        )
    end

    local rotationOffset = anchorConfig.rotation or anchorConfig.rotationOffset
    if rotationOffset then
        anchorRotation = vec3(
            anchorRotation.x + rotationOffset.x,
            anchorRotation.y + rotationOffset.y,
            anchorRotation.z + rotationOffset.z
        )
    end

    return {
        entity = anchorEntity,
        position = anchorPosition,
        rotation = anchorRotation,
    }
end

-- Utility: robustly snap a ped to the nearest ground at their XY
local function snapPedToGround(ped)
    if not ped or ped == 0 then return end

    local pos = GetEntityCoords(ped)
    local found, groundZ = GetGroundZFor_3dCoord(pos.x, pos.y, pos.z + 1.5, false)
    if found then
        SetEntityCoordsNoOffset(ped, pos.x, pos.y, groundZ, false, false, false)
    end
end

-- Start a workout for an ad-hoc area (no fixed spot)
local function startAreaWorkout(area)
    if not area or not area.workout then return end

    local workout = workouts[area.workout]
    if not workout or not workout.stat then return end
    if not workout.animations and not workout.scenario then return end
    if not canUseWorkout() then return end

    -- Oxygen gate
    if oxygenLevel <= oxygenWarningThreshold then
        exports.qbx_core:Notify('Vous devez reprendre votre souffle avant de continuer.', 'error')
        return
    end

    local cooldownKey = area.key or ('area:' .. tostring(area.workout))
    local cooldown = cooldowns[cooldownKey]
    if cooldown and cooldown > GetGameTimer() then
        if oxygenLevel < oxygenChainThreshold then
            local remaining = math.max(0, math.ceil((cooldown - GetGameTimer()) / 1000))
            local msg
            if remaining >= 60 then
                local minutes = math.floor(remaining / 60)
                local seconds = remaining % 60
                if minutes > 0 and seconds > 0 then
                    msg = ("Veuillez patienter %d min %d s avant de recommencer."):format(minutes, seconds)
                else
                    msg = ("Veuillez patienter %d min avant de recommencer."):format(minutes)
                end
            else
                msg = ("Veuillez patienter %d s avant de recommencer."):format(remaining)
            end
            exports.qbx_core:Notify(msg, 'error')
            return
        end
        -- souffle suffisant: on enchaîne en ignorant le cooldown courant
    end

    usingWorkout = true
    lib.hideTextUI()
    textVisible = false
    updateFitnessOxygenState()

    local ped = cache.ped
    local pedCoords = GetEntityCoords(ped)
    local coords = vec4(pedCoords.x, pedCoords.y, pedCoords.z, GetEntityHeading(ped))

    -- Rester en place et assurer un sol sûr
    snapPedToGround(ped)
    ClearPedTasksImmediately(ped)

    local requiredDuration = workout.duration or defaultDuration
    local success, elapsed, manualStop, requirementMet

    if workout.animations then
        success, elapsed, manualStop, requirementMet = playWorkoutAnimation(ped, workout, requiredDuration, area)
    elseif workout.scenario then
        TaskStartScenarioAtPosition(ped, workout.scenario, coords.x, coords.y, coords.z, coords.w or 0.0, 0, true, true)
        success, elapsed, manualStop, requirementMet = waitForWorkoutCompletion(requiredDuration, ped)
        ClearPedTasksImmediately(ped)
    else
        success = false
        elapsed = 0
    end

    if success then
        if not workout.usesScenario and workout.amount then
            TriggerServerEvent('qbx_fitness:server:modifyStat', workout.stat, workout.amount, {
                activity = ('equipment:%s'):format(area.workout),
                label = workout.label or area.workout,
            })
        end

        exports.qbx_core:Notify(('Entraînement terminé (%s)'):format(workout.label or area.workout), 'success')
        cooldowns[cooldownKey] = GetGameTimer() + (workout.cooldown or defaultCooldown)
    else
        if manualStop and requirementMet == false then
            exports.qbx_core:Notify("Vous avez arrêté l'exercice trop tôt.", 'error')
        else
            exports.qbx_core:Notify('Entraînement annulé.', 'error')
        end
        cooldowns[cooldownKey] = GetGameTimer() + 5000
    end

    shouldCancelWorkout = false
    usingWorkout = false
    updateFitnessOxygenState()

    if DoesEntityExist(ped) and not IsPedInAnyVehicle(ped, true) then
        snapPedToGround(ped)
    end
end

-- Ask the ped to walk naturally to a nearby spot
local function walkPedTo(ped, x, y, z, heading, timeout)
    if not ped or ped == 0 then return false end

    local t = timeout or 2000
    local dest = vec3(x, y, z)

    -- Start a short, straight walk; keep collisions enabled for natural movement
    TaskGoStraightToCoord(ped, x, y, z, 1.0, t, heading or 0.0, 0.0)

    local ends = GetGameTimer() + t
    while GetGameTimer() < ends do
        local pos = GetEntityCoords(ped)
        if #(pos - dest) <= 0.35 then
            return true
        end
        Wait(0)
    end

    return false
end
-- Extra safety: clean up any workout props lingering near the ped (fallback)
local function cleanupNearbyWorkoutProps(ped, workoutProps)
    if not workoutProps or not ped or ped == 0 then return end

    local pedCoords = GetEntityCoords(ped)

    for i = 1, #workoutProps do
        local def = workoutProps[i]
        if def and def.model then
            local model = type(def.model) == 'string' and joaat(def.model) or def.model
            local obj = GetClosestObjectOfType(pedCoords.x, pedCoords.y, pedCoords.z, 2.0, model, false, false, false)
            if obj and obj ~= 0 and DoesEntityExist(obj) then
                if IsEntityAttached(obj) then
                    DetachEntity(obj, true, true)
                end
                SetEntityAsMissionEntity(obj, true, true)
                DeleteEntity(obj)
            end
        end
    end
end

-- Try to place the ped just beside the equipment to avoid getting stuck
local function safeExitFromSpot(ped, coords, workoutName)
    if not ped or ped == 0 or not coords then return end

    local heading = coords.w or GetEntityHeading(ped)

    -- Prefer minimal displacement; escalate distances only if nécessaire
    local angles = { 90.0, -90.0, 180.0, 0.0 }
    local distances = { 1.0, 1.25, 1.5, 1.75 }

    local function findSafe(x, y, z)
        -- Try GTA safe coord search (signature varies across builds)
        local ok, a, b, c, d = pcall(function()
            return GetSafeCoordForPed(x, y, z, false, 16)
        end)

        if ok and a then
            if type(a) == 'vector3' then
                return a.x, a.y, a.z
            elseif type(a) == 'number' and type(b) == 'number' and type(c) == 'number' then
                return a, b, c
            end
        end

        local found, groundZ = GetGroundZFor_3dCoord(x, y, z + 0.5, false)
        return x, y, found and groundZ or z
    end

    for _, d in ipairs(distances) do
        for _, ang in ipairs(angles) do
            local rad = math.rad((heading or 0.0) + ang)
            local x = coords.x + math.cos(rad) * d
            local y = coords.y + math.sin(rad) * d
            local z = coords.z + 0.2

            local sx, sy, sz = findSafe(x, y, z)
            local occupied = IsPositionOccupied(sx, sy, sz + 0.4, 0.6, false, true, true, false, false, 0.0, false)
            if not occupied then
                -- Try walking naturally first
                local ok = walkPedTo(ped, sx, sy, sz, heading, 2000)
                if ok then
                    SetEntityHeading(ped, heading)
                    snapPedToGround(ped)
                    return
                end
            end
        end
    end

    -- Last resort: lift slightly and drop to ground to free from bench
    local pos = GetEntityCoords(ped)
    SetEntityCollision(ped, false, false)
    SetEntityCoordsNoOffset(ped, pos.x, pos.y, pos.z + 0.8, false, false, false)
    snapPedToGround(ped)
    Wait(10)
    SetEntityCollision(ped, true, true)
end

local function playWorkoutAnimation(ped, workout, requiredDuration, context)
    local animations = workout.animations
    if not animations then return false, 0, false, false end

    ensureAnimationsLoaded(animations)

    local anchor = resolveWorkoutAnchor(ped, workout, context)
    local usingAdvanced = animations.useAdvanced and anchor ~= nil

    local function resolveDurationMs(data, fallback)
        if not data then return fallback or -1 end
        if data.duration ~= nil then
            return data.duration
        end

        local animDuration = GetAnimDuration(data.dict, data.anim)
        if animDuration and animDuration > 0 then
            return math.floor(animDuration * 1000)
        end

        return fallback or -1
    end

    -- Defer prop attachment until after the enter animation (e.g., bench press when player is lying down)
    local props
    local attachPropsEarly = true
    if animations.enter then
        attachPropsEarly = false
    end

    if attachPropsEarly then
        props = attachProps(ped, workout.props)
    end

    local constraintsApplied = false
    if not usingAdvanced then
        constraintsApplied = true
        FreezeEntityPosition(ped, true)
        SetEntityCollision(ped, false, false)
    else
        SetEntityCollision(ped, true, true)
    end

    local released = not constraintsApplied

    local function releaseConstraints()
        if released then return end

        released = true
        if constraintsApplied then
            FreezeEntityPosition(ped, false)
            SetEntityCollision(ped, true, true)
        end
    end

    local function advancedAnchorFor(data)
        if not usingAdvanced then return end

        local anchorPos = anchor.position
        local anchorRot = anchor.rotation

        if data and data.anchorOffset then
            anchorPos = vec3(
                anchorPos.x + data.anchorOffset.x,
                anchorPos.y + data.anchorOffset.y,
                anchorPos.z + data.anchorOffset.z
            )
        end

        if data and data.rotationOffset then
            anchorRot = vec3(
                anchorRot.x + data.rotationOffset.x,
                anchorRot.y + data.rotationOffset.y,
                anchorRot.z + data.rotationOffset.z
            )
        end

        if not anchorPos then
            local pedCoords = GetEntityCoords(ped)
            anchorPos = vec3(pedCoords.x, pedCoords.y, pedCoords.z)
        end

        if not anchorRot then
            anchorRot = vec3(0.0, 0.0, GetEntityHeading(ped))
        end

        return anchorPos, anchorRot
    end

    local function playAnimation(data, flagOverride)
        if not data then return end

        local flag = flagOverride or data.flag or 0
        local duration = resolveDurationMs(data, -1)

        if usingAdvanced then
            local anchorPos, anchorRot = advancedAnchorFor(data)
            TaskPlayAnimAdvanced(
                ped,
                data.dict,
                data.anim,
                anchorPos.x,
                anchorPos.y,
                anchorPos.z,
                anchorRot.x,
                anchorRot.y,
                anchorRot.z,
                8.0,
                -8.0,
                duration,
                flag,
                0.0,
                2,
                0
            )
        else
            TaskPlayAnim(ped, data.dict, data.anim, 8.0, -8.0, duration, flag, 0.0, false, false, false)
        end

        if duration and duration > 0 and flag == 0 then
            Wait(duration)
        else
            Wait(0)
        end
    end

    local requirementMet = not requiredDuration or requiredDuration <= 0
    local requirementNotified = requirementMet
    local manualStop = false
    local success = true
    local startTime = GetGameTimer()

    local function checkRequirement()
        if requirementMet or not requiredDuration or requiredDuration <= 0 then
            requirementMet = true
            return
        end

        if GetGameTimer() - startTime >= requiredDuration then
            requirementMet = true

            if not requirementNotified then
                requirementNotified = true
                exports.qbx_core:Notify('Vous pouvez arrêter l\'exercice avec X.', 'inform')
            end
        end
    end

    local function shouldStopWorkout()
        if shouldCancelWorkout then
            success = false
            return true
        end

        if IsControlJustPressed(0, cancelControl) then
            manualStop = true
            return true
        end

        if not DoesEntityExist(ped) or IsEntityDead(ped) then
            success = false
            return true
        end

        return false
    end

    playAnimation(animations.enter)

    -- Attach props after entering position when applicable
    if not attachPropsEarly and not props then
        props = attachProps(ped, workout.props)
    end

    if animations.idle then
        playAnimation(animations.idle, animations.idle.flag or 1)
    end

    local activeAnimation = animations.exercise or animations.training

    while true do
        checkRequirement()

        if shouldStopWorkout() then break end

        if activeAnimation then
            local loopDuration = resolveDurationMs(activeAnimation, 1000)
            if loopDuration <= 0 then
                loopDuration = 1000
            end

            local loopFlag = activeAnimation.flag or 0

            if usingAdvanced then
                local anchorPos, anchorRot = advancedAnchorFor(activeAnimation)
                TaskPlayAnimAdvanced(
                    ped,
                    activeAnimation.dict,
                    activeAnimation.anim,
                    anchorPos.x,
                    anchorPos.y,
                    anchorPos.z,
                    anchorRot.x,
                    anchorRot.y,
                    anchorRot.z,
                    8.0,
                    -8.0,
                    loopDuration,
                    loopFlag,
                    0.0,
                    2,
                    0
                )
            else
                TaskPlayAnim(ped, activeAnimation.dict, activeAnimation.anim, 8.0, -8.0, loopDuration, loopFlag, 0.0, false, false, false)
            end

            local loopEnds = GetGameTimer() + loopDuration

            while GetGameTimer() < loopEnds do
                checkRequirement()

                if shouldStopWorkout() then break end

                Wait(0)
            end

            if manualStop or not success then break end

            if animations.idle then
                playAnimation(animations.idle, animations.idle.flag or 1)
            end
        else
            Wait(0)
        end
    end

    if manualStop and not requirementMet then
        success = false
    elseif success then
        success = requirementMet
    end

    -- Stop oxygen drain immediately once we exit the loop
    usingWorkout = false
    updateFitnessOxygenState()

    -- Proactively cleanup props before exit so nothing stays in hand
    if props then
        cleanupProps(props)
    end

    local canPlayExit = animations.exit and (success or manualStop) and DoesEntityExist(ped) and not IsEntityDead(ped) and not IsPedRagdoll(ped)

    if canPlayExit then
        -- Release freeze so the exit clip can move the ped naturally off the bench
        releaseConstraints()
        playAnimation(animations.exit)
    else
        releaseConstraints()
    end

    ClearPedTasks(ped)

    -- Safety: if the ped ends up slightly above ground (levitation effect)
    -- after cancelling or finishing, snap them back to ground cleanly.
    if DoesEntityExist(ped) and not IsPedInAnyVehicle(ped, true) then
        Wait(10)
        snapPedToGround(ped)
    end
    -- Second-chance cleanup in case something reattached during exit
    cleanupProps(props)

    local elapsed = GetGameTimer() - startTime

    return success, elapsed, manualStop, requirementMet
end

function canUseWorkout()
    if usingWorkout then return false end
    if not LocalPlayer.state.isLoggedIn then return false end

    local ped = cache.ped
    if not ped or ped == 0 then return false end
    if IsEntityDead(ped) then return false end
    if IsPedRagdoll(ped) then return false end
    if IsPedInAnyVehicle(ped, false) then return false end

    return true
end

local function waitForWorkoutCompletion(requiredDuration, ped)
    local startTime = GetGameTimer()
    local scenarioGrace = GetGameTimer() + 1500
    local requirementMet = not requiredDuration or requiredDuration <= 0
    local requirementNotified = requirementMet
    local manualStop = false
    local success = true

    while true do
        if not DoesEntityExist(ped) or IsEntityDead(ped) then
            success = false
            break
        end

        if shouldCancelWorkout then
            success = false
            break
        end

        if not requirementMet and requiredDuration and requiredDuration > 0 then
            if GetGameTimer() - startTime >= requiredDuration then
                requirementMet = true

                if not requirementNotified then
                    requirementNotified = true
                    exports.qbx_core:Notify('Vous pouvez arrêter l\'exercice avec X.', 'inform')
                end
            end
        end

        if IsControlJustPressed(0, cancelControl) then
            manualStop = true
            break
        end

        if GetGameTimer() > scenarioGrace and not IsPedUsingAnyScenario(ped) then
            success = false
            break
        end

        Wait(0)
    end

    local elapsed = GetGameTimer() - startTime

    if manualStop and not requirementMet then
        success = false
    elseif success then
        success = requirementMet
    end

    return success, elapsed, manualStop, requirementMet
end

local function startWorkout(spotIndex)
    local spot = spots[spotIndex]
    if not spot then return end

    shouldCancelWorkout = false

    local workout = workouts[spot.workout]
    if not workout or not workout.stat then
        return
    end

    if not workout.animations and not workout.scenario then
        return
    end

    if not canUseWorkout() then
        return
    end

    -- Bloque l'accès si le souffle est trop bas (cohérent avec l'avertissement oxygène)
    if oxygenLevel <= oxygenWarningThreshold then
        exports.qbx_core:Notify('Vous devez reprendre votre souffle avant de continuer.', 'error')
        return
    end

    -- Cooldown d'équipement: ignoré si le souffle est revenu au seuil défini
    local cooldown = cooldowns[spotIndex]
    if cooldown and cooldown > GetGameTimer() then
        if oxygenLevel < oxygenChainThreshold then
            local remaining = math.max(0, math.ceil((cooldown - GetGameTimer()) / 1000))
            local msg
            if remaining >= 60 then
                local minutes = math.floor(remaining / 60)
                local seconds = remaining % 60
                if minutes > 0 and seconds > 0 then
                    msg = ("Veuillez patienter %d min %d s avant de recommencer."):format(minutes, seconds)
                else
                    msg = ("Veuillez patienter %d min avant de recommencer."):format(minutes)
                end
            else
                msg = ("Veuillez patienter %d s avant de recommencer."):format(remaining)
            end
            exports.qbx_core:Notify(msg, 'error')
            return
        end
        -- souffle suffisant: on enchaîne en ignorant le cooldown courant
    end

    usingWorkout = true
    lib.hideTextUI()
    textVisible = false
    updateFitnessOxygenState()

    local ped = cache.ped
    local pedCoords = GetEntityCoords(ped)
    local coords = spot.coords or vec4(pedCoords.x, pedCoords.y, pedCoords.z, GetEntityHeading(ped))
    local position = vec3(coords.x, coords.y, coords.z)

    SetEntityCoords(ped, position.x, position.y, position.z, false, false, false, true)
    SetEntityHeading(ped, coords.w or GetEntityHeading(ped))
    ClearPedTasksImmediately(ped)

    local requiredDuration = workout.duration or defaultDuration
    local success, elapsed, manualStop, requirementMet

    if workout.animations then
        success, elapsed, manualStop, requirementMet = playWorkoutAnimation(ped, workout, requiredDuration, spot)
    elseif workout.scenario then
        TaskStartScenarioAtPosition(ped, workout.scenario, coords.x, coords.y, coords.z, coords.w or 0.0, 0, true, true)
        success, elapsed, manualStop, requirementMet = waitForWorkoutCompletion(requiredDuration, ped)
        ClearPedTasksImmediately(ped)
    else
        success = false
        elapsed = 0
    end

    if success then
        if not workout.usesScenario and workout.amount then
            TriggerServerEvent('qbx_fitness:server:modifyStat', workout.stat, workout.amount, {
                activity = ('equipment:%s'):format(spot.workout),
                label = workout.label or spot.workout,
            })
        end

        exports.qbx_core:Notify(('Entraînement terminé (%s)'):format(workout.label or spot.workout), 'success')
        cooldowns[spotIndex] = GetGameTimer() + (workout.cooldown or defaultCooldown)
    else
        if manualStop and requirementMet == false then
            exports.qbx_core:Notify('Vous avez arrêté l\'entraînement trop tôt.', 'error')
        else
            exports.qbx_core:Notify('Entraînement annulé.', 'error')
        end
        cooldowns[spotIndex] = GetGameTimer() + 5000
    end

    -- Mark workout as over before any reposition/cleanup to stop oxygen drain ASAP
    shouldCancelWorkout = false
    usingWorkout = false
    updateFitnessOxygenState()

    -- Additional safety: ensure no prop lingers and move the ped out of the equipment
    cleanupNearbyWorkoutProps(ped, workout.props)
    -- Only the bench requires a forced side exit; others just snap to ground
    if spot.workout == 'bench' then
        -- Use the equipment base coordinates for minimal displacement
        safeExitFromSpot(ped, coords, spot.workout)
    else
        if DoesEntityExist(ped) and not IsPedInAnyVehicle(ped, true) then
            snapPedToGround(ped)
        end
    end
end

local targetState = GetResourceState(targetResource)
local targetAvailable = useTarget and targetState and targetState:find('start') ~= nil
local useOxTarget = targetAvailable and targetResource == 'ox_target'
local useQbTarget = targetAvailable and targetResource == 'qb-target'

for index, spot in ipairs(spots) do
    if not workouts[spot.workout] then goto continue end

    local interact = spot.interact or vec3(spot.coords.x, spot.coords.y, spot.coords.z)
    local radius = spot.radius or 1.5

    if useOxTarget then
        local zoneId = exports.ox_target:addSphereZone({
            coords = interact,
            radius = radius,
            debug = equipmentConfig.debug or false,
            options = {{
                name = ('qbx_fitness_%s_%d'):format(spot.workout, index),
                icon = targetIcon,
                label = workouts[spot.workout].label or spot.workout,
                distance = spot.distance or 1.5,
                onSelect = function()
                    startWorkout(index)
                end,
                canInteract = function()
                    return not usingWorkout and LocalPlayer.state.isLoggedIn
                end,
            }},
        })

        zones[#zones + 1] = {type = 'ox', id = zoneId}
    elseif useQbTarget then
        local zoneName = ('qbx_fitness_%s_%d'):format(spot.workout, index)
        exports['qb-target']:AddCircleZone(zoneName, interact, radius, {
            name = zoneName,
            useZ = spot.useZ or false,
            debugPoly = equipmentConfig.debug or false,
        }, {
            options = {{
                icon = targetIcon,
                label = workouts[spot.workout].label or spot.workout,
                action = function()
                    startWorkout(index)
                end,
                canInteract = function()
                    return not usingWorkout and LocalPlayer.state.isLoggedIn
                end,
            }},
            distance = spot.distance or 1.5,
        })

        zones[#zones + 1] = {type = 'qb', name = zoneName}
    else
        local zone = lib.zones.sphere({
            coords = interact,
            radius = radius,
            debug = equipmentConfig.debug or false,
            inside = function()
                if usingWorkout then return end

                if not textVisible then
                    lib.showTextUI(('[E] %s'):format(workouts[spot.workout].label or spot.workout), {
                        position = equipmentConfig.textUIPosition or 'left-center',
                    })
                    textVisible = true
                end

                if IsControlJustPressed(0, interactControl) then
                    startWorkout(index)
                end
            end,
            onExit = function()
                if textVisible then
                    lib.hideTextUI()
                    textVisible = false
                end
            end,
        })

        zones[#zones + 1] = {type = 'zone', zone = zone}
    end

    ::continue::
end

-- Zones de zone (poly) pour des exercices sans point fixe
for _, area in ipairs(areas) do
    local workout = workouts[area.workout]
    if workout then
        -- Utilise une zone polygonale avec ox_lib
        local zone = lib.zones.poly({
            points = area.points or {},
            thickness = (area.maxZ or 6.0) - (area.minZ or 2.0),
            debug = equipmentConfig.debug or false,
            onEnter = function()
                -- rien, on gère l'affichage dans inside()
            end,
            inside = function()
                if usingWorkout then return end

                if not textVisible then
                    lib.showTextUI(('[E] %s'):format(workout.label or area.workout), {
                        position = equipmentConfig.textUIPosition or 'left-center',
                    })
                    textVisible = true
                end

                if IsControlJustPressed(0, interactControl) then
                    startAreaWorkout(area)
                end
            end,
            onExit = function()
                if textVisible then
                    lib.hideTextUI()
                    textVisible = false
                end
            end,
        })

        zones[#zones + 1] = { type = 'zone', zone = zone }
    end
end

AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then return end

    if textVisible then
        lib.hideTextUI()
        textVisible = false
    end

    for _, entry in ipairs(zones) do
        if entry.type == 'ox' and useOxTarget then
            exports.ox_target:removeZone(entry.id)
        elseif entry.type == 'qb' and useQbTarget then
            exports['qb-target']:RemoveZone(entry.name)
        elseif entry.type == 'zone' then
            entry.zone:remove()
        end
    end

    if LocalPlayer and LocalPlayer.state then
        LocalPlayer.state:set('fitnessOxygen', 100, false)
        LocalPlayer.state:set('fitnessOxygenActive', false, false)
    end
end)
