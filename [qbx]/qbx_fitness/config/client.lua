local function minutes(value)
    return value * 60000
end

return {
    tickRate = 1000,
    activities = {
        endurance = {
            sprint = {
                enabled = true,
                duration = 15000,
                amount = 0.75,
                cooldown = minutes(1),
            },
            swim = {
                enabled = true,
                duration = 12000,
                amount = 1.0,
                cooldown = minutes(1),
            },
        },
        strength = {
            melee = {
                enabled = true,
                duration = 8000,
                amount = 0.5,
                cooldown = minutes(1),
            },
            scenarios = {
                enabled = true,
                cooldown = minutes(1),
                entries = {
                    situps = {
                        label = 'Serie abdominaux',
                        duration = 6000,
                        amount = 0.6,
                        animDict = 'amb@world_human_sit_ups@male@base',
                        anim = 'base',
                        scenario = 'world_human_sit_ups',
                    },
                    chinups = {
                        label = 'Tractions guidees',
                        duration = 8000,
                        amount = 0.8,
                        animDict = 'amb@prop_human_muscle_chin_ups@male@base',
                        anim = 'base',
                        scenario = 'prop_human_muscle_chin_ups',
                    },
                },
            },
        },
    },
    quickWorkouts = {
        arm = {
            label = 'Serie biceps libre',
            description = 'Charges legeres pour entretenir les bras, sans materiel.',
            icon = 'dumbbell',
            stat = 'strength',
            amount = 0.28,
            duration = 15000,
            cooldown = minutes(2),
            scenario = 'world_human_muscle_free_weights',
            animDict = 'amb@world_human_muscle_free_weights@male@barbell@idle_a',
            anim = 'idle_a',
        },
        pushups = {
            label = 'Pompes au sol',
            description = 'Renforcement general, ideal pour un echauffement rapide.',
            icon = 'hand-fist',
            stat = 'strength',
            amount = 0.22,
            duration = 14000,
            cooldown = minutes(2),
            scenario = 'world_human_push_ups',
            animDict = 'amb@world_human_push_ups@male@base',
            anim = 'base',
        },
        yoga = {
            label = 'Yoga tonique',
            description = 'Postures lentes pour gainer sans forcer comme sur les machines.',
            icon = 'person-praying',
            stat = 'strength',
            amount = 0.18,
            duration = 18000,
            cooldown = minutes(2),
            scenario = 'world_human_yoga',
            animDict = 'amb@world_human_yoga@male@base',
            anim = 'base',
        },
        situps = {
            label = 'Abdos au sol',
            description = 'Entretien des abdominaux sans materiel.',
            icon = 'user',
            stat = 'strength',
            amount = 0.24,
            duration = 16000,
            cooldown = minutes(2),
            scenario = 'world_human_sit_ups',
            animDict = 'amb@world_human_sit_ups@male@base',
            anim = 'base',
            scenarioEntry = 'situps',
        },
        chins = {
            label = 'Tractions libres',
            description = 'Serie de tractions sans assistance, effort modere.',
            icon = 'grip-lines',
            stat = 'strength',
            amount = 0.3,
            duration = 18000,
            cooldown = minutes(2),
            scenario = 'prop_human_muscle_chin_ups',
            animDict = 'amb@prop_human_muscle_chin_ups@male@base',
            anim = 'base',
            scenarioEntry = 'chinups',
            fixedPosition = { x = -1199.84, y = -1571.40, z = 4.61, heading = 40.0, radius = 4.5 },
        },
    },
    equipment = {
        useTarget = true,
        targetResource = 'ox_target',
        targetIcon = 'fa-solid fa-dumbbell',
        interactControl = 38, -- INPUT_CONTEXT / E
        cancelControl = 73, -- INPUT_VEH_DUCK / X
        defaultDuration = 15000, -- Durée minimale requise (ms) avant que l'entraînement puisse être validé. L'utilisateur doit appuyer sur X pour s'arrêter.
        defaultCooldown = minutes(1),
        oxygen = {
            drain = 4,
            drainInterval = 1500,
            recovery = 8,
            recoveryInterval = 1200,
            warningThreshold = 25,
            -- Seuil de souffle pour autoriser l'enchaînement en ignorant le cooldown
            chainThreshold = 80,
            postFx = 'DrugsDrivingIn',
            faintDuration = 5000,
            recoveryAfterFaint = 35,
            recoveryAnimDict = 'get_up@sat_on_floor@to_stand',
            recoveryAnim = 'getup_0',
            recoveryAnimFlag = 0,
        },
        workouts = {
            bench = {
                label = 'Développé couché',
                stat = 'strength',
                amount = 0.9,
                duration = 20000, -- durée minimale avant validation (ms)
                cooldown = minutes(2),
                animations = {
                    useAdvanced = true,
                    enter = { dict = 'amb@prop_human_seat_muscle_bench_press@enter', anim = 'enter', duration = 2500 },
                    idle = { dict = 'amb@prop_human_seat_muscle_bench_press@base', anim = 'base', duration = -1, flag = 1 },
                    exercise = { dict = 'amb@prop_human_seat_muscle_bench_press@idle_a', anim = 'idle_a', duration = 2350 },
                    exit = { dict = 'amb@prop_human_seat_muscle_bench_press@exit', anim = 'exit', duration = 2500 },
                },
                anchor = {
                    model = 'prop_muscle_bench_03',
                    radius = 2.0,
                    offset = vec3(0.0, 0.0, -1.25),
                    rotation = vec3(0.0, 0.0, 180.0),
                },
                props = {
                    {
                        model = 'prop_barbell_60kg',
                        bone = 28422,
                        offset = vec3(0.0, 0.0, 0.0),
                        rotation = vec3(0.0, 0.0, 0.0),
                    },
                },
            },
            chinup = {
                label = 'Tractions',
                stat = 'strength',
                amount = 0.75,
                duration = 15000, -- durée minimale avant validation (ms)
                cooldown = minutes(1),
                usesScenario = true,
                animations = {
                    enter = { dict = 'amb@prop_human_muscle_chin_ups@male@enter', anim = 'enter', duration = 1800 },
                    idle = { dict = 'amb@prop_human_muscle_chin_ups@male@idle_a', anim = 'idle_a', duration = -1, flag = 1 },
                    exercise = { dict = 'amb@prop_human_muscle_chin_ups@male@base', anim = 'base', duration = 2900 },
                    exit = { dict = 'amb@prop_human_muscle_chin_ups@male@exit', anim = 'exit', duration = 2000 },
                },
            },
            freeweight = {
                label = 'Musculation libre',
                stat = 'strength',
                amount = 0.6,
                duration = 14000, -- durée minimale avant validation (ms)
                animations = {
                    idle = { dict = 'amb@world_human_muscle_free_weights@male@barbell@idle_a', anim = 'idle_a', duration = -1, flag = 1 },
                    exercise = { dict = 'amb@world_human_muscle_free_weights@male@barbell@base', anim = 'base', duration = 4500 },
                },
                props = {
                    {
                        model = 'prop_barbell_01',
                        bone = 28422,
                        offset = vec3(-0.24, 0.0, -0.03),
                        rotation = vec3(0.0, -50.0, 0.0),
                    },
                    {
                        model = 'prop_barbell_01',
                        bone = 60309,
                        offset = vec3(0.05, 0.0, 0.0),
                        rotation = vec3(0.0, -90.0, 120.0),
                    },
                },
            },
            
        },
        spots = {
            {
                workout = 'bench',
                coords = vec4(-1200.64, -1562.11, 3.10, 125.29),
                interact = vec3(-1201.55, -1562.81, 4.5),
                radius = 1.5,
            },
            {
                workout = 'bench',
                coords = vec4(-1207.11, -1560.81, 3.10, 212.49),
                interact = vec3(-1206.53, -1561.62, 4.5),
                radius = 1.5,
            },
            {
                workout = 'bench',
                coords = vec4(-1201.3, -1575.02, 3.10, 216.27),
                interact = vec3(-1200.68, -1575.89, 4.5),
                radius = 1.5,
            },
            {
                workout = 'bench',
                coords = vec4(-1197.96, -1568.22, 3.10, 305.69),
                interact = vec3(-1197.13, -1567.6, 4.5),
                radius = 1.5,
            },
            {
                workout = 'chinup',
                coords = vec4(-1204.74, -1564.35, 3.585, 35.88),
                interact = vec3(-1204.74, -1564.35, 4.5),
                radius = 1.2,
            },
            {
                workout = 'chinup',
                coords = vec4(-1200.02, -1571.14, 3.585, 213.62),
                interact = vec3(-1200.19, -1570.93, 4.5),
                radius = 1.2,
            },
            {
                workout = 'freeweight',
                coords = vec4(-1199.03, -1574.59, 3.61, 215.48),
                interact = vec3(-1198.97, -1574.5, 4.5),
                radius = 1.2,
            },
            {
                workout = 'freeweight',
                coords = vec4(-1197.01, -1572.9, 3.61, 214.71),
                interact = vec3(-1197.01, -1572.9, 4.5),
                radius = 1.2,
            },
            {
                workout = 'freeweight',
                coords = vec4(-1202.67, -1565.53, 3.61, 32.46),
                interact = vec3(-1202.67, -1565.53, 4.5),
                radius = 1.2,
            },
            {
                workout = 'freeweight',
                coords = vec4(-1210.31, -1561.34, 3.61, 77.1),
                interact = vec3(-1210.31, -1561.34, 4.5),
                radius = 1.2,
            },
            {
                workout = 'freeweight',
                coords = vec4(-1202.6, -1572.78, 3.61, 127.31),
                interact = vec3(-1202.6, -1572.78, 4.5),
                radius = 1.2,
            },
            {
                workout = 'freeweight',
                coords = vec4(-1209.33, -1559.18, 3.61, 48.95),
                interact = vec3(-1209.33, -1559.18, 4.5),
                radius = 1.2,
            },
            {
                workout = 'freeweight',
                coords = vec4(-1198.32, -1565.38, 3.62, 240.3),
                interact = vec3(-1198.32, -1565.41, 4.5),
                radius = 1.2,
            },
            
        },
        -- Zones libres: exercice sans appareil
        areas = {},
    },
}
