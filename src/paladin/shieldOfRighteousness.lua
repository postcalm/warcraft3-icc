-- Copyright (c) meiso

function Paladin.ShieldOfRighteousness()
    -- 42% от силы + 520 ед. урона дополнительно
    local damage = GetHeroStr(GetTriggerUnit(), true) * 1.42 + 520.
    Paladin.hero:DealMagicDamage(GetSpellTargetUnit(), damage)
end

function Paladin.IsShieldOfRighteousness()
    return shield_of_righteousness:SpellCasted()
end

function Paladin.InitShieldOfRighteousness()
    shield_of_righteousness:Init()
    Paladin.hero:SetAbilityManacost(shield_of_righteousness:GetId(), 6)
    Paladin.hero:SetAbilityCooldown(shield_of_righteousness:GetId(), 6.)

    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Paladin.IsShieldOfRighteousness)
    event:AddAction(Paladin.ShieldOfRighteousness)
end
