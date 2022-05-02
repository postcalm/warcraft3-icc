
function Paladin.JudgementOfLight()
    if GetRandomReal(0., 1.) <= 0.7  then
        local HP = GetUnitState(PALADIN, UNIT_STATE_MAX_LIFE) * 0.02
        SetUnitState(Paladin.hero, UNIT_STATE_LIFE, GetUnitState(Paladin.hero, UNIT_STATE_LIFE) + HP)
    end
end

function Paladin.IsJudgementOfLightDebuff()
    return GetUnitAbilityLevel(GetEventDamageSource(), JUDGEMENT_OF_LIGHT_BUFF) > 0
end

function Paladin.CastJudgementOfLight()
    --создаем юнита и выдаем ему основную способность
    --и бьем по таргету паладина
    local jol_unit = Unit(GetTriggerPlayer(), DUMMY, GetUnitLoc(PALADIN))
    UnitAddAbility(jol_unit, JUDGEMENT_OF_LIGHT)
    IssueTargetOrder(jol_unit, "shadowstrike", GetSpellTargetUnit())
    UnitApplyTimedLife(jol_unit, COMMON_TIMER, 2.)
end

function Paladin.IsJudgementOfLight()
    return GetSpellAbilityId() == JUDGEMENT_OF_LIGHT_TR
end

function Paladin.InitJudgementOfLight()
    local event_ability = EventsPlayer(PLAYER_1)
    local event_jol = EventsPlayer(PLAYER_1)

    --событие того, что персонаж использовал способность
    event_ability:RegisterUnitSpellCast()
    event_ability:AddCondition(Paladin.IsJudgementOfLight)
    event_ability:AddAction(Paladin.CastJudgementOfLight)

    --событие того, что персонаж бьёт юнита с дебафом
    event_jol:RegisterUnitDamaging()
    event_jol:AddCondition(Paladin.IsJudgementOfLightDebuff)
    event_jol:AddAction(Paladin.JudgementOfLight)
end