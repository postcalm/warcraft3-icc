
include "common/buffs.j"
include "common/spells.j"
include "common/objects.j"

void JudgementOfLight()
{
    int debuff = GetUnitAbilityLevel( GetAttacker(), JUDGEMENT_OF_LIGHT_BUFF )
    if( debuff > 0 )
    {
        // fixme: юнит хилится пока идёт бой!
        if( GetRandomReal(0., 1.) <= 0.7  )
        {
            real giveHP = GetUnitState(PALADIN, UNIT_STATE_MAX_LIFE) * 0.02
            SetUnitState( PALADIN, \
                          UNIT_STATE_LIFE, \
                          GetUnitState(PALADIN, UNIT_STATE_LIFE) + giveHP )
        }
    }
}

bool IsJudgementOfLightDebuff()
{
    return GetUnitAbilityLevel( GetAttacker(), JUDGEMENT_OF_LIGHT_BUFF ) > 0
}

void CastJudgementOfLight()
{   
    float paladin_loc_x = GetLocationX( GetUnitLoc(PALADIN) )
    float paladin_loc_y = GetLocationY( GetUnitLoc(PALADIN) )
    unit jol_unit = new unit( GetTriggerPlayer(), DUMMY, paladin_loc_x, paladin_loc_y )
    UnitAddAbility( jol_unit, JUDGEMENT_OF_LIGHT )

    IssueTargetOrder( jol_unit, "shadowstrike", GetSpellTargetUnit() )

    UnitApplyTimedLife( jol_unit, COMMON_TIMER, 2. )
    jol_unit = null
}

bool IsJudgementOfLight()
{
    return GetSpellAbilityId() == JUDGEMENT_OF_LIGHT_TR
}

void Init_JudgementOfLight()
{
    trigger trigger_ability = new trigger
    trigger trigger_jol = new trigger

    TriggerRegisterPlayerUnitEvent( trigger_ability, Player(0), EVENT_PLAYER_UNIT_SPELL_CAST, null )
    TriggerAddCondition( trigger_ability, function IsJudgementOfLight )
    TriggerAddAction( trigger_ability, function CastJudgementOfLight )

    TriggerRegisterPlayerUnitEvent( trigger_jol, Player(0), EVENT_PLAYER_UNIT_ATTACKED, null )
    TriggerAddCondition( trigger_jol, function IsJudgementOfLightDebuff )
    TriggerAddAction( trigger_jol, function JudgementOfLight )

}