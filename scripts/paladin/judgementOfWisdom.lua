
function JudgementOfWisdom()
    -- fixme: юнит хилится пока идёт бой!
    if GetRandomReal(0., 1.) <= 0.7 then
        local give_MP = GetUnitState(PALADIN, UNIT_STATE_MAX_MANA) * 0.02
        SetUnitState(PALADIN, UNIT_STATE_MANA, GetUnitState(PALADIN, UNIT_STATE_MANA) + give_MP)
    end
end

function IsJudgementOfWisdomDebuff()
    return GetUnitAbilityLevel(GetEventDamageSource(), JUDGEMENT_OF_WISDOM_BUFF) > 0
end

function CastJudgementOfWisdom()
    local paladin_loc = GetUnitLoc(PALADIN)
    local jow_unit = CreateUnitAtLoc(GetTriggerPlayer(), DUMMY, paladin_loc, 0.)
    UnitAddAbility(jow_unit, JUDGEMENT_OF_WISDOM)
    IssueTargetOrder(jow_unit, "shadowstrike", GetSpellTargetUnit())
    UnitApplyTimedLife(jow_unit, COMMON_TIMER, 2.)
end

function IsJudgementOfWisdom()
    return GetSpellAbilityId() == JUDGEMENT_OF_WISDOM_TR
end

function Init_JudgementOfWisdom()
    local trigger_ability = CreateTrigger()
    local trigger_jow = CreateTrigger()
    
    TriggerRegisterPlayerUnitEvent(trigger_ability, Player(0), EVENT_PLAYER_UNIT_SPELL_CAST, nil)
    TriggerAddCondition(trigger_ability, Condition(IsJudgementOfWisdom))
    TriggerAddAction(trigger_ability, CastJudgementOfWisdom)

    TriggerRegisterPlayerUnitEvent(trigger_jow, Player(0), EVENT_PLAYER_UNIT_DAMAGING, nil)
    TriggerAddCondition(trigger_jow, Condition(IsJudgementOfWisdomDebuff))
    TriggerAddAction(trigger_jow, JudgementOfWisdom)
end