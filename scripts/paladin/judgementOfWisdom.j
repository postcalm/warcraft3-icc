
include "common/buffs.j"
include "common/spells.j"
include "common/objects.j"

trigger trigger_jow = new trigger

void JudgementOfWisdom()
{
    int debuff = GetUnitAbilityLevel( GetAttacker(), JUDGEMENT_OF_WISDOM_BUFF )
    if( debuff > 0 )
    {
        if( GetRandomReal(0., 1.) <= 0.7 )
        {
            real giveMP = GetUnitState(PALADIN, UNIT_STATE_MAX_MANA) * 0.02
            sBJDebugMsg("%r", giveMP)
            SetUnitState( PALADIN, \
                          UNIT_STATE_MANA, \
                          GetUnitState(PALADIN, UNIT_STATE_MANA) + giveMP )
        }
    }
}

bool IsJudgementOfWisdomDebuff()
{
    return GetUnitAbilityLevel( GetAttacker(), JUDGEMENT_OF_WISDOM_BUFF) > 0
}

void CastJudgementOfWisdom()
{
    float paladin_loc_x = GetLocationX( GetUnitLoc(PALADIN) )
    float paladin_loc_y = GetLocationY( GetUnitLoc(PALADIN) )
    unit jow_unit = new unit( GetTriggerPlayer(), DUMMY, paladin_loc_x, paladin_loc_y )
    UnitAddAbility( jow_unit, JUDGEMENT_OF_WISDOM )

    IssueTargetOrder( jow_unit, "shadowstrike", GetSpellTargetUnit() )

    TriggerRegisterPlayerUnitEvent( trigger_jow, Player(0), EVENT_PLAYER_UNIT_ATTACKED, null )
    TriggerAddCondition( trigger_jow, function IsJudgementOfWisdomDebuff )
    TriggerAddAction( trigger_jow, function JudgementOfWisdom )

    UnitApplyTimedLife( jow_unit, COMMON_TIMER, 2. )
    jow_unit = null
}

bool IsJudgementOfWisdom()
{
    return GetSpellAbilityId() == JUDGEMENT_OF_WISDOM_TR
}

void Init_JudgementOfWisdom()
{
    trigger trigger_ability = new trigger
    
    TriggerRegisterPlayerUnitEvent( trigger_ability, Player(0), EVENT_PLAYER_UNIT_SPELL_CAST, null )
    TriggerAddCondition( trigger_ability, function IsJudgementOfWisdom )
    TriggerAddAction( trigger_ability, function CastJudgementOfWisdom )
}