-- Copyright (c) 2022 Kodpi

function Priest.CastCircleOfHealing()
    local target = Unit(GetSpellTargetUnit())

    Priest.hero:LoseMana{percent=21}

    local heal = GetRandomInt(958, 1058)
    bj_groupCountUnits()
    target:GainLife{life=heal}
    TextTag(heal, target):Preset("heal")
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
