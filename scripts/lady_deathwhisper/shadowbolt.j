
void Actions_ShadowBolt()
{
    unit targetEnemy = GetUnitInArea( GroupHeroesInArea(AREA_LD) )
    
    real damage = GetRandomReal( 9200., 12000. )
    UnitDamageTarget(LADY_DEATHWHISPER, targetEnemy, damage, true, false, \
                     ATTACK_TYPE_CHAOS, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
}

void Init_ShadowBolt()
{
    trigger triggerShadowBolt = new trigger

    TriggerRegisterUnitEvent( triggerShadowBolt, LADY_DEATHWHISPER, EVENT_UNIT_ATTACKED )
    TriggerAddAction( triggerShadowBolt, function Actions_ShadowBolt )

    triggerShadowBolt = null
}

