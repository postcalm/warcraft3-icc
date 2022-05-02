
function Priest.CastCircleOfHealing()
    local target = GetSpellTargetUnit()
    local priest = Priest.hero:GetUnit()
    local mana = GetManaCost(priest, 0.21)
    SetUnitState(priest, UNIT_STATE_MANA, GetUnitState(priest, UNIT_STATE_MANA) - mana)

    local heal = GetRandomInt(958, 1058)
    bj_groupCountUnits()
    SetUnitState(target, UNIT_STATE_LIFE, GetUnitState(target, UNIT_STATE_LIFE) + heal)
end

function Priest.IsCircleOfHealing()
    return GetSpellAbilityId() == CIRCLE_OF_HEALING
end

function Priest.InitCircleOfHealing()
    local event = EventsPlayer(PLAYER_1)
    event:RegisterUnitSpellCast()
    event:AddCondition(Priest.IsCircleOfHealing)
    event:AddAction(Priest.CastCircleOfHealing)
end