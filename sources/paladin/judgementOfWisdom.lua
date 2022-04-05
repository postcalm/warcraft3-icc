
function JudgementOfWisdom()
    if GetRandomReal(0., 1.) <= 0.7 then
        local MP = GetUnitState(PALADIN, UNIT_STATE_MAX_MANA) * 0.02
        SetUnitState(PALADIN, UNIT_STATE_MANA, GetUnitState(PALADIN, UNIT_STATE_MANA) + MP)
    end
end

function IsJudgementOfWisdomDebuff()
    return GetUnitAbilityLevel(GetEventDamageSource(), JUDGEMENT_OF_WISDOM_BUFF) > 0
end

function CastJudgementOfWisdom()
    local jow_unit = Unit:new(GetTriggerPlayer(), STATIC_DUMMY, GetUnitLoc(PALADIN))
    UnitAddAbility(jow_unit, JUDGEMENT_OF_WISDOM)
    IssueTargetOrder(jow_unit, "shadowstrike", GetSpellTargetUnit())
    UnitApplyTimedLife(jow_unit, COMMON_TIMER, 2.)
end

function IsJudgementOfWisdom()
    return GetSpellAbilityId() == JUDGEMENT_OF_WISDOM_TR
end

function Init_JudgementOfWisdom()
    local event_ability = EventsPlayer(Player(0))
    local event_jow = EventsPlayer(Player(0))

    --событие того, что персонаж использовал способность
    event_ability:RegisterUnitSpellCast()
    event_ability:AddCondition(IsJudgementOfWisdom)
    event_ability:AddAction(CastJudgementOfWisdom)

    --событие того, персонаж бьёт юнита с дебафом
    event_jow:RegisterUnitDamaging()
    event_jow:AddCondition(IsJudgementOfWisdomDebuff)
    event_jow:AddAction(JudgementOfWisdom)
end