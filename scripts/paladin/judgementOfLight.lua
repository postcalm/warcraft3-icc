
function JudgementOfLight()
    local debuff = GetUnitAbilityLevel(GetAttacker(), JUDGEMENT_OF_LIGHT_BUFF)
    if debuff > 0 then
        -- fixme: юнит хилится пока идёт бой!
        if GetRandomReal(0., 1.) <= 0.7  then
            local giveHP = GetUnitState(PALADIN, UNIT_STATE_MAX_LIFE) * 0.02
            SetUnitState(PALADIN, UNIT_STATE_LIFE, GetUnitState(PALADIN, UNIT_STATE_LIFE) + giveHP)
        end
    end
end

function IsJudgementOfLightDebuff()
    return GetUnitAbilityLevel(GetAttacker(), JUDGEMENT_OF_LIGHT_BUFF) > 0
end

function CastJudgementOfLight()
    local paladin_loc_x = GetLocationX(GetUnitLoc(PALADIN))
    local paladin_loc_y = GetLocationY(GetUnitLoc(PALADIN))
    local jol_unit = CreateUnit(GetTriggerPlayer(), DUMMY, paladin_loc_x, paladin_loc_y, 0.)
    UnitAddAbility(jol_unit, JUDGEMENT_OF_LIGHT)
    IssueTargetOrder(jol_unit, "shadowstrike", GetSpellTargetUnit())
    UnitApplyTimedLife(jol_unit, COMMON_TIMER, 2.)
    RemoveUnit(jol_unit)
end

function IsJudgementOfLight()
    return GetSpellAbilityId() == JUDGEMENT_OF_LIGHT_TR
end

function Init_JudgementOfLight()
    local trigger_ability = CreateTrigger()
    local trigger_jol = CreateTrigger()

    TriggerRegisterPlayerUnitEvent(trigger_ability, Player(0), EVENT_PLAYER_UNIT_SPELL_CAST, nil)
    TriggerAddCondition(trigger_ability, IsJudgementOfLight)
    TriggerAddAction(trigger_ability, CastJudgementOfLight)

    TriggerRegisterPlayerUnitEvent(trigger_jol, Player(0), EVENT_PLAYER_UNIT_ATTACKED, nil)
    TriggerAddCondition(trigger_jol, IsJudgementOfLightDebuff)
    TriggerAddAction(trigger_jol, JudgementOfLight)
end