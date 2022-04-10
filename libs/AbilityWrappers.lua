

--- Устанавливает кулдаун способности
---@param unit unit
---@param ability ability
---@param cooldown real
function SetCooldown(unit, ability, cooldown)
    local level = GetUnitAbilityLevel(unit, ability)
    BlzSetUnitAbilityCooldown(unit, ability, level, cooldown)
end

