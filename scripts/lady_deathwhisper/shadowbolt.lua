
function ShadowBolt()
    local whoPlayer = GetOwningPlayer(GetAttacker())
    local target_enemy = GetUnitInArea(GroupHeroesInArea(AREA_LD, whoPlayer))
    
    local damage = GetRandomReal(9200., 12000.)
    UnitDamageTarget(LADY_DEATHWHISPER, target_enemy, damage, true, false,
                     ATTACK_TYPE_CHAOS, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
end

function Init_ShadowBolt()
    local trigger_ability = CreateTrigger()
    TriggerRegisterUnitEvent(trigger_ability, LADY_DEATHWHISPER, EVENT_UNIT_ATTACKED)
    TriggerAddAction(trigger_ability, ShadowBolt)
end

