
function JudgementOfWisdom()
    local debuff = GetUnitAbilityLevel(GetAttacker(), JUDGEMENT_OF_WISDOM_BUFF)
    if debuff > 0 then
        -- fixme: юнит хилится пока идёт бой!
        if GetRandomReal(0., 1.) <= 0.7 then
            local giveMP = GetUnitState(PALADIN, UNIT_STATE_MAX_MANA) * 0.02
            SetUnitState(PALADIN, UNIT_STATE_MANA, GetUnitState(PALADIN, UNIT_STATE_MANA) + giveMP)
        end
    end
end

function IsJudgementOfWisdomDebuff()
    return GetUnitAbilityLevel( GetAttacker(), JUDGEMENT_OF_WISDOM_BUFF) > 0
end

function CastJudgementOfWisdom()
    local paladin_loc_x = GetLocationX(GetUnitLoc(PALADIN))
    local paladin_loc_y = GetLocationY(GetUnitLoc(PALADIN))
    local jow_unit = CreateUnit(GetTriggerPlayer(), DUMMY, paladin_loc_x, paladin_loc_y, 0.)
    UnitAddAbility(jow_unit, JUDGEMENT_OF_WISDOM)
    IssueTargetOrder(jow_unit, "shadowstrike", GetSpellTargetUnit())
    UnitApplyTimedLife(jow_unit, COMMON_TIMER, 2.)
    RemoveUnit(jow_unit)
end

function IsJudgementOfWisdom()
    return GetSpellAbilityId() == JUDGEMENT_OF_WISDOM_TR
end

function Init_JudgementOfWisdom()
    local trigger_ability = CreateTrigger()
    local trigger_jow = CreateTrigger()
    
    TriggerRegisterPlayerUnitEvent(trigger_ability, Player(0), EVENT_PLAYER_UNIT_SPELL_CAST, nil)
    TriggerAddCondition(trigger_ability, IsJudgementOfWisdom)
    TriggerAddAction(trigger_ability, CastJudgementOfWisdom)

    TriggerRegisterPlayerUnitEvent(trigger_jow, Player(0), EVENT_PLAYER_UNIT_ATTACKED, nil)
    TriggerAddCondition(trigger_jow, IsJudgementOfWisdomDebuff)
    TriggerAddAction(trigger_jow, JudgementOfWisdom)
end