-- Copyright (c) meiso

function Paladin.RemoveBlessingOfMight(unit)
    if BuffSystem.IsBuffOnHero(unit, blessing_of_might) then
        unit:SetBaseDamage(unit:GetBaseDamage() - 550 // DPS)
        BuffSystem.RemoveBuffFromHero(unit, blessing_of_might)
    end
end

function Paladin.BlessingOfMight()
    local unit = Unit(GetSpellTargetUnit())
    local timer = Timer(600.)
    BuffSystem.RegisterHero(unit)

    if BuffSystem.IsBuffOnHero(unit, blessing_of_might) then
        BuffSystem.RemoveBuffFromHeroByFunc(unit, blessing_of_might)
    end

    unit:SetBaseDamage(unit:GetBaseDamage() + 550 // DPS)

    local remove_buff = function()
        Paladin.RemoveBlessingOfMight(unit)
        timer:Destroy()
    end
    BuffSystem.AddBuffToHero(unit, blessing_of_might, remove_buff)
    timer:SetFunc(remove_buff)
    timer:Start()
end

function Paladin.IsBlessingOfMight()
    return blessing_of_might:SpellCasted()
end

function Paladin.InitBlessingOfMight()
    blessing_of_might:Init()
    Paladin.hero:SetAbilityManacost(blessing_of_might:GetId(), 5)
    Paladin.hero:SetAbilityCooldown(blessing_of_might:GetId(), 1.5)

    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Paladin.IsBlessingOfMight)
    event:AddAction(Paladin.BlessingOfMight)
end
