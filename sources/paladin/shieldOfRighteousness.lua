
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
    local event = EventsPlayer(Player(0))
    event:RegisterUnitSpellCast()
    event:AddCondition(IsShieldOfRighteousness)
    event:AddAction(ShieldOfRighteousness)
end
