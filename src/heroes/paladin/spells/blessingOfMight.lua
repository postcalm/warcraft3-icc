---@author meiso

function Paladin.RemoveBlessingOfMight(unit)
    if BuffSystem.IsBuffOnHero(unit, Spells.paladin.blessing_of_might) then
        unit:SetBaseDamage(unit:GetBaseDamage() - 550 // DPS)
        BuffSystem.RemoveBuffFromHero(unit, Spells.paladin.blessing_of_might)
    end
end

function Paladin.BlessingOfMight()
    local unit = Unit(GetSpellTargetUnit())
    local timer = Timer(600.)
    BuffSystem.RegisterHero(unit)

    if BuffSystem.IsBuffOnHero(unit, Spells.paladin.blessing_of_might) then
        BuffSystem.RemoveBuffFromHeroByFunc(unit, Spells.paladin.blessing_of_might)
    end

    unit:SetBaseDamage(unit:GetBaseDamage() + 550 // DPS)

    local remove_buff = function()
        Paladin.RemoveBlessingOfMight(unit)
        timer:Destroy()
    end
    BuffSystem.AddBuffToHero(unit, Spells.paladin.blessing_of_might, remove_buff)
    timer:SetFunc(remove_buff)
    timer:Start()
end

function Paladin.IsBlessingOfMight()
    return Spells.paladin.blessing_of_might:SpellCasted()
end

function Paladin.InitBlessingOfMight(player)
    local event = EventsPlayer(player)
    event:RegisterUnitSpellCast()
    event:AddCondition(Paladin.IsBlessingOfMight)
    event:AddAction(Paladin.BlessingOfMight)
end
