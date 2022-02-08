
include "common/spells.j"

void AvengersShield()
{
    unit first_target = GetSpellTargetUnit()
    // unit next_target = null
    real light_magic_damage = 1
    real factor = 0.07
    real attack_power = GetHeroStr( GetTriggerUnit(), true ) * 2
    real damage = GetRandomInt( 1100, 1344 ) + (factor * light_magic_damage) + (factor * attack_power)
    sBJDebugMsg("%r", damage)
    UnitDamageTargetBJ( GetTriggerUnit(), first_target, damage, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_DIVINE )
    // next_target = GetUnitInArea( GroupUnitsInRangeOfLocUnit( 400, GetUnitLoc(first_target) ) )


    first_target = null
    // next_target = null
}

bool IsAvengersShield()
{
    return GetSpellAbilityId() == AVENGERS_SHIELD
}

void Init_AvengersShield()
{
    trigger trigger_ability = new trigger

    TriggerRegisterPlayerUnitEvent( trigger_ability, Player(0), EVENT_PLAYER_UNIT_SPELL_CAST, null )
    TriggerAddCondition( trigger_ability, function IsAvengersShield )
    TriggerAddAction( trigger_ability, function AvengersShield )
}