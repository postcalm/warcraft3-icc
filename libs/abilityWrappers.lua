

--- Устанавливает кулдаун способности
---@param unit unit
---@param ability ability
---@param cooldown real
function SetCooldown(unit, ability, cooldown)
    local level = GetUnitAbilityLevel(unit, ability)
    BlzSetUnitAbilityCooldown(unit, ability, level, cooldown)
end

function GetManaCost(unit, percent)
    return GetUnitState(unit, UNIT_STATE_MAX_MANA) * percent
end

