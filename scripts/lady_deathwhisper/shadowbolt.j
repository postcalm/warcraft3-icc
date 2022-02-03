
include "libraries/UnitLocation.j"
include "common/areas.j"

void Actions_ShadowBolt()
{
    unit target_enemy = GetUnitInArea( GroupHeroesInArea(AREA_LD) )
    
    real damage = GetRandomReal( 9200., 12000. )
    UnitDamageTarget(LADY_DEATHWHISPER, target_enemy, damage, true, false, \
                     ATTACK_TYPE_CHAOS, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
}

void Init_ShadowBolt()
{
    trigger trigger_ability = new trigger

    TriggerRegisterUnitEvent( trigger_ability, LADY_DEATHWHISPER, EVENT_UNIT_ATTACKED )
    TriggerAddAction( trigger_ability, function Actions_ShadowBolt )

}

