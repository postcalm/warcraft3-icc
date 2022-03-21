
function AvengersShield()
    local first_target = GetSpellTargetUnit()
    local light_magic_damage = 1
    local factor = 0.07
    local attack_power = GetHeroStr(GetTriggerUnit(), true ) * 2
    local damage = GetRandomInt(1100, 1344) + (factor * light_magic_damage) + (factor * attack_power)
    UnitDamageTargetBJ(GetTriggerUnit(), first_target, damage, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_DIVINE)
    --local next_target = GetUnitInArea(GroupUnitsInRangeOfLocUnit(400, GetUnitLoc(first_target)))
end

function IsAvengersShield()
    return GetSpellAbilityId() == AVENGERS_SHIELD
end

function Init_AvengersShield()
    local trigger_ability = CreateTrigger()

    TriggerRegisterPlayerUnitEvent(trigger_ability, Player(0), EVENT_PLAYER_UNIT_SPELL_CAST, nil)
    TriggerAddCondition(trigger_ability, IsAvengersShield)
    TriggerAddAction(trigger_ability, AvengersShield)
end