
function Priest.CastFlashHeal()
    local target = GetSpellTargetUnit()
    local heal = GetRandomInt(1887, 2193)
    local priest = Priest.hero:GetUnit()
    local mana = GetManaCost(priest, 0.18)
    SetUnitState(priest, UNIT_STATE_MANA, GetUnitState(priest, UNIT_STATE_MANA) - mana)
    SetUnitState(target, UNIT_STATE_LIFE, GetUnitState(target, UNIT_STATE_LIFE) + heal)
end

function Priest.IsFlashHeal()
    return GetSpellAbilityId() == FLASH_HEAL
end

function Priest.InitFlashHeal()
    local event = EventsPlayer(PLAYER_1)
    event:RegisterUnitSpellCast()
    event:AddCondition(Priest.IsFlashHeal)
    event:AddAction(Priest.CastFlashHeal)
end