local sharedConfig = require 'config.shared'
local serverConfig = require 'config.server'

local statConfig = sharedConfig.stats or {}
local statLabels = {
    strength = 'Force',
    endurance = 'Endurance',
}

---@param value number
---@param min number
---@param max number
---@return number
local function clamp(value, min, max)
    if value < min then return min end
    if value > max then return max end
    return value
end

---@param playerSrc number
---@param stat string
---@param amount number
---@param activity? table | string
---@return boolean success, number? newValue
local function applyStatChange(playerSrc, stat, amount, activity)
    if type(playerSrc) ~= 'number' or type(stat) ~= 'string' or type(amount) ~= 'number' then return false end

    stat = stat:lower()

    local configEntry = statConfig[stat]
    if not configEntry then return false end

    local player = exports.qbx_core:GetPlayer(playerSrc)
    if not player then return false end

    local clampedAmount = clamp(amount, -configEntry.maxDelta, configEntry.maxDelta)
    if clampedAmount == 0 then return false end

    local current = player.PlayerData.metadata[stat] or 0
    local newValue = clamp(current + clampedAmount, configEntry.min, configEntry.max)

    if newValue == current then return false end

    player.Functions.SetMetaData(stat, newValue)

    TriggerEvent('qbx_fitness:server:onStatChanged', playerSrc, stat, current, newValue, clampedAmount, activity)

    if serverConfig.notifyOnMilestone and serverConfig.milestoneStep > 0 then
        local previousMilestone = math.floor(current / serverConfig.milestoneStep)
        local newMilestone = math.floor(newValue / serverConfig.milestoneStep)
        if newMilestone > previousMilestone then
            exports.qbx_core:Notify(playerSrc, ('%s améliorée (%d)'):format(statLabels[stat] or stat, newValue), 'success')
        end
    end

    return true, newValue
end

RegisterNetEvent('qbx_fitness:server:modifyStat', function(stat, amount, activity)
    applyStatChange(source, stat, amount, activity)
end)

exports('ModifyStat', applyStatChange)

---@param playerSrc number
---@param stat string
---@return number
local function getStat(playerSrc, stat)
    if type(playerSrc) ~= 'number' or type(stat) ~= 'string' then return 0 end
    local player = exports.qbx_core:GetPlayer(playerSrc)
    if not player then return 0 end
    return player.PlayerData.metadata[stat] or 0
end

exports('GetStat', getStat)
