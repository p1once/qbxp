Config = Config or {}

-- When enabled, players must possess one of the items listed in `Config.PhoneList`
-- to open the phone. Disable this to allow everyone to access NPWD without a
-- physical phone item in their inventory.
if Config.PhoneAsItem == nil then
    Config.PhoneAsItem = false
end

-- List the items you want to register as a phone here. These are only used when
-- `Config.PhoneAsItem` is enabled.
Config.PhoneList = Config.PhoneList or {
    'phone',
}

-- Backwards compatibility for existing references.
PhoneList = Config.PhoneList
