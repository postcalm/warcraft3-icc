
include "common/buffs.j"
include "common/spells.j"

void JudgementOfLight()
{
    unit target_unit = GetAttacker()
    int debuff = GetUnitAbilityLevel( GetAttacker(), JUDGEMENT_OF_LIGHT_BUFF)
    whilenot( debuff == 0)
    {
        debuff = GetUnitAbilityLevel( target_unit, JUDGEMENT_OF_LIGHT_BUFF)
        if( GetRandomReal( 0., 1.) <= 0.3)
        {
            real giveHP = GetUnitState(PALADIN, UNIT_STATE_MAX_LIFE) * 0.02
            SetUnitState( PALADIN, \
                          UNIT_STATE_LIFE, \
                          GetUnitState(PALADIN, UNIT_STATE_LIFE) + giveHP )
        }
    }
    target_unit = null
}

bool IsJudgementOfLight()
{
    return GetUnitAbilityLevel( GetAttacker(), JUDGEMENT_OF_LIGHT_BUFF) > 0
}

void Init_JudgementOfLight()
{
    trigger triggerAbility = new trigger

    TriggerRegisterPlayerUnitEvent( triggerAbility, Player(0), EVENT_PLAYER_UNIT_ATTACKED, null )
    TriggerAddCondition( triggerAbility, function IsJudgementOfLight )
    TriggerAddAction( triggerAbility, function JudgementOfLight )

    triggerAbility = null
}