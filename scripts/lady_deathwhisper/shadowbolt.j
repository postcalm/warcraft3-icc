
void Actions_ShadowBolt()
{
    unit targetEnemy = GetUnitInArea( GroupHeroesInArea(AREA_LD) )
    
    real damage = GetRandomReal( 9200., 12000. )
    UnitDamageTarget(LADY_DEATHWHISPER, targetEnemy, damage, true, false, \
                     ATTACK_TYPE_CHAOS, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
}

void InitTrig_ShadowBolt()
{
    trigger triggerAction = new trigger

    TriggerRegisterUnitEvent( triggerAction, LADY_DEATHWHISPER, EVENT_UNIT_ATTACKED )
    TriggerAddAction( triggerAction, function Actions_ShadowBolt )

    triggerAction = null
}

