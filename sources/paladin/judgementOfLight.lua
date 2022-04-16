
function JudgementOfLight()
    if GetRandomReal(0., 1.) <= 0.7  then
        local HP = GetUnitState(PALADIN, UNIT_STATE_MAX_LIFE) * 0.02
        SetUnitState(PALADIN, UNIT_STATE_LIFE, GetUnitState(PALADIN, UNIT_STATE_LIFE) + HP)
    end
end

function IsJudgementOfLightDebuff()
    return GetUnitAbilityLevel(GetEventDamageSource(), JUDGEMENT_OF_LIGHT_BUFF) > 0
end

function CastJudgementOfLight()
    --создаем юнита и выдаем ему основную способность
    --и бьем по таргету паладина
    local jol_unit = Unit:new(GetTriggerPlayer(), STATIC_DUMMY, GetUnitLoc(PALADIN))
    UnitAddAbility(jol_unit, JUDGEMENT_OF_LIGHT)
    IssueTargetOrder(jol_unit, "shadowstrike", GetSpellTargetUnit())
    UnitApplyTimedLife(jol_unit, COMMON_TIMER, 2.)
end

function IsJudgementOfLight()
    return GetSpellAbilityId() == JUDGEMENT_OF_LIGHT_TR
end

function Init_JudgementOfLight()
    local event_ability = EventsPlayer(Player(0))
    local event_jol = EventsPlayer(Player(0))

    --событие того, что персонаж использовал способность
    event_ability:RegisterUnitSpellCast()
    event_ability:AddCondition(IsJudgementOfLight)
    event_ability:AddAction(CastJudgementOfLight)

    --событие того, что персонаж бьёт юнита с дебафом
    event_jol:RegisterUnitDamaging()
    event_jol:AddCondition(IsJudgementOfLightDebuff)
    event_jol:AddAction(JudgementOfLight)
end