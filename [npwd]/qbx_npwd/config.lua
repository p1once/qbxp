Config = Config or {}

-- When enabled, players must possess one of the items listed in `PhoneList`
-- to open the phone. Disable this to allow everyone to access NPWD without a
-- physical phone item in their inventory.
if Config.PhoneAsItem == nil then
    Config.PhoneAsItem = true
end

-- List the items you want to register as a phone here. These are only used when
-- `Config.PhoneAsItem` is enabled. Keep `PhoneList` in sync with the Config
-- entry so legacy references continue to work.
PhoneList = PhoneList or {
    'phone',
}

Config.PhoneList = Config.PhoneList or PhoneList
PhoneList = Config.PhoneList
