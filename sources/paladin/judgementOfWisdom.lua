
function Paladin.JudgementOfWisdom()
    if GetRandomReal(0., 1.) <= 0.7 then
        local MP = GetUnitState(PALADIN, UNIT_STATE_MAX_MANA) * 0.02
        SetUnitState(Paladin.hero, UNIT_STATE_MANA, GetUnitState(Paladin.hero, UNIT_STATE_MANA) + MP)
    end
end

function Paladin.IsJudgementOfWisdomDebuff()
    return GetUnitAbilityLevel(GetEventDamageSource(), JUDGEMENT_OF_WISDOM_BUFF) > 0
end

function Paladin.CastJudgementOfWisdom()
    local jow_unit = Unit(GetTriggerPlayer(), DUMMY, GetUnitLoc(PALADIN))
    UnitAddAbility(jow_unit, JUDGEMENT_OF_WISDOM)
    IssueTargetOrder(jow_unit, "shadowstrike", GetSpellTargetUnit())
    UnitApplyTimedLife(jow_unit, COMMON_TIMER, 2.)
end

function Paladin.IsJudgementOfWisdom()
    return GetSpellAbilityId() == JUDGEMENT_OF_WISDOM_TR
end

function Paladin.InitJudgementOfWisdom()
    local event_ability = EventsPlayer(PLAYER_1)
    local event_jow = EventsPlayer(PLAYER_1)

    --событие того, что персонаж использовал способность
    event_ability:RegisterUnitSpellCast()
    event_ability:AddCondition(Paladin.IsJudgementOfWisdom)
    event_ability:AddAction(Paladin.CastJudgementOfWisdom)

    --событие того, персонаж бьёт юнита с дебафом
    event_jow:RegisterUnitDamaging()
    event_jow:AddCondition(Paladin.IsJudgementOfWisdomDebuff)
    event_jow:AddAction(Paladin.JudgementOfWisdom)
end