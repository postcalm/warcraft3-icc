
function Paladin.ShieldOfRighteousness()
    if not Paladin.hero:LoseMana{percent=6} then return end
    -- 42% от силы + 520 ед. урона дополнительно
    local damage = GetHeroStr(GetTriggerUnit(), true) * 1.42 + 520.
    Paladin.hero:DealMagicDamage(GetSpellTargetUnit(), damage)
end

function Paladin.IsShieldOfRighteousness()
    return GetSpellAbilityId() == SHIELD_OF_RIGHTEOUSNESS
end


function Paladin.InitShieldOfRighteousness()
    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Paladin.IsShieldOfRighteousness)
    event:AddAction(Paladin.ShieldOfRighteousness)
end
