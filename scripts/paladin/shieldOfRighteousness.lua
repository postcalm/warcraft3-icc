
function ShieldOfRighteousness()
    -- 42% от силы + 520 ед. урона дополнительно
    local damage = GetHeroStr(GetTriggerUnit(), true) * 1.42 + 520.
    UnitDamageTarget(GetTriggerUnit(), GetSpellTargetUnit(), damage, true, false,
                     ATTACK_TYPE_MAGIC, DAMAGE_TYPE_LIGHTNING, WEAPON_TYPE_WHOKNOWS)
end

function IsShieldOfRighteousness()
    return GetSpellAbilityId() == SHIELD_OF_RIGHTEOUSNESS
end

function Init_ShieldOfRighteousness()
    local trigger_ability = CreateTrigger()
    TriggerRegisterPlayerUnitEvent(trigger_ability, Player(0), EVENT_PLAYER_UNIT_SPELL_CAST, nil)
    TriggerAddCondition(trigger_ability, IsShieldOfRighteousness)
    TriggerAddAction(trigger_ability, ShieldOfRighteousness)
end
