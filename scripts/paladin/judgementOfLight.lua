
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
    local trigger_ability = CreateTrigger()
    local trigger_jol = CreateTrigger()

    --событие того, что персонаж использовал способность
    TriggerRegisterPlayerUnitEvent(trigger_ability, Player(0), EVENT_PLAYER_UNIT_SPELL_CAST, nil)
    TriggerAddCondition(trigger_ability, Condition(IsJudgementOfLight))
    TriggerAddAction(trigger_ability, CastJudgementOfLight)

    --событие того, персонаж бьёт юнита с дебафом
    TriggerRegisterPlayerUnitEvent(trigger_jol, Player(0), EVENT_PLAYER_UNIT_DAMAGING, nil)
    TriggerAddCondition(trigger_jol, Condition(IsJudgementOfLightDebuff))
    TriggerAddAction(trigger_jol, JudgementOfLight)
end