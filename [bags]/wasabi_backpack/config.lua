-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
Config = {}

Config.checkForUpdates = true -- Check for updates?

Config.OneBagInInventory = true -- Allow only one bag in inventory?

-- Which rotation axis should LEFT/RIGHT arrows edit as "yaw" during bagedit?
-- Valid values: 'x', 'y', 'z'. Default is 'z'.
-- If your bag rotates around the wrong axis when using arrow keys,
-- try setting this to 'x' or 'y' depending on your model/orientation.
-- While editing you can also press NUMPAD0 to cycle through the axes
-- or NUMPADENTER to reset back to the configured default.
Config.EditYawAxis = 'z'

-- Optional: override the yaw axis per bag variant by adding `editYawAxis`
-- to the variant table (or within male/female attach tables). This is
-- useful for models that are rotated 90 degrees by default where the
-- horizontal spin corresponds to a different axis (commonly 'y').

-- Default (legacy) storage for backpacks if no variant match
Config.BackpackStorage = {
    slots = 8, -- Slots of backpack storage
    weight = 10000 -- Total weight for backpack
}

-- Multiple bag variants (name must match ox_inventory item name)
-- Each variant can define its own model, slots and weight
-- Optional: add an `attach` table with custom bone/offset/rotation overrides
Config.BagVariants = {
    backpack = {
        label = 'Backpack',
        model = `p_michael_backpack_s`,
        dropModel = `p_michael_backpack_s`,
        slots = 8,
        weight = 10000,
        -- Use the default yaw axis (Z) so LEFT/RIGHT spin the bag horizontally
        editYawAxis = 'z',
        attach = {
            male = {
                bone = 24818, -- Spine
                offset = { x = 0.10, y = -0.17, z = -0.06 },
                rotation = { x = 0.0, y = 90.0, z = 180.0 }
            },
            female = {
                bone = 24818, -- Spine
                offset = { x = 0.11, y = -0.18, z = -0.07 },
                rotation = { x = 0.0, y = 90.0, z = 180.0 }
            }
        }
    },

    duffelbag = {
        label = 'Duffel Bag',
        model = `p_ld_heist_bag_s`,
        dropModel = `p_ld_heist_bag_s`,
        slots = 10,
        weight = 14000,
        -- Horizontal spin also follows the default Z axis for this model
        editYawAxis = 'z',
        attach = {
            male = {
                bone = 24818, -- Spine
                offset = { x = 0.10, y = -0.19, z = -0.16 },
                rotation = { x = 0.0, y = 90.0, z = 100.0 }
            },
            female = {
                bone = 24818, -- Spine
                offset = { x = 0.11, y = -0.20, z = -0.17 },
                rotation = { x = 0.0, y = 90.0, z = 100.0 }
            }
        }
    },

    duffelbag_pro2 = {
        label = 'Duffel Bag (Pro2)',
        model = `p_ld_heist_bag_s_pro2_s`,
        dropModel = `p_ld_heist_bag_s_pro2_s`,
        slots = 10,
        weight = 14000,
        -- Horizontal spin also follows the default Z axis for this model
        editYawAxis = 'z',
        attach = {
            male = {
                bone = 24818, -- Spine
                offset = { x = 0.10, y = -0.19, z = -0.16 },
                rotation = { x = 0.0, y = 90.0, z = 100.0 }
            },
            female = {
                bone = 24818, -- Spine
                offset = { x = 0.11, y = -0.20, z = -0.17 },
                rotation = { x = 0.0, y = 90.0, z = 100.0 }
            }
        }
    },

    -- Handheld variants (attach to right hand)
    handbag = {
        label = 'Handbag',
        model = `prop_ld_handbag`,
        dropModel = `prop_ld_handbag`,
        slots = 6,
        weight = 6000,
        attach = {
            male = {
                bone = 57005, -- Right Hand
                offset = { x = 0.11, y = 0.02, z = -0.02 },
                rotation = { x = 90.0, y = 0.0, z = 90.0 }
            },
            female = {
                bone = 57005, -- Right Hand
                offset = { x = 0.11, y = 0.02, z = -0.02 },
                rotation = { x = 90.0, y = 0.0, z = 90.0 }
            }
        }
    },

    briefcase = {
        label = 'Briefcase',
        model = `prop_ld_case_01`,
        dropModel = `prop_ld_case_01`,
        slots = 8,
        weight = 8000,
        attach = {
            male = {
                bone = 57005, -- Right Hand
                offset = { x = 0.12, y = 0.02, z = -0.02 },
                rotation = { x = 90.0, y = 0.0, z = 90.0 }
            },
            female = {
                bone = 57005, -- Right Hand
                offset = { x = 0.12, y = 0.02, z = -0.02 },
                rotation = { x = 90.0, y = 0.0, z = 90.0 }
            }
        }
    }
}

Strings = { -- Notification strings
    action_incomplete = 'Action Incomplete',
    one_backpack_only = 'You can only have 1x backpack!',
    backpack_in_backpack = 'You can\'t place a backpack within another!',
}
