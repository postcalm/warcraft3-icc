
function Paladin.ShieldOfRighteousness()
    -- 42% от силы + 520 ед. урона дополнительно
    local damage = GetHeroStr(GetTriggerUnit(), true) * 1.42 + 520.
    UnitDamageTarget(GetTriggerUnit(), GetSpellTargetUnit(), damage, true, false,
            ATTACK_TYPE_MAGIC, DAMAGE_TYPE_LIGHTNING, WEAPON_TYPE_WHOKNOWS)
end

function Paladin.IsShieldOfRighteousness()
    return GetSpellAbilityId() == SHIELD_OF_RIGHTEOUSNESS
end


function Paladin.InitShieldOfRighteousness()
    local event = EventsPlayer(PLAYER_1)
    event:RegisterUnitSpellCast()
    event:AddCondition(Paladin.IsShieldOfRighteousness)
    event:AddAction(Paladin.ShieldOfRighteousness)
end
