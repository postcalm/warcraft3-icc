-- Copyright (c) meiso

function Paladin.RemoveBlessingOfMight(unit, timer)
    if BuffSystem.IsBuffOnHero(unit, blessing_of_might) then
        SetHeroStr(unit, GetHeroStr(unit, false) - 225, false)
        BuffSystem.RemoveBuffFromHero(unit, blessing_of_might)
    end
    DestroyTimer(timer)
end

function Paladin.BlessingOfMight()
    local unit = GetSpellTargetUnit()
    BuffSystem.RegisterHero(unit)

    if BuffSystem.IsBuffOnHero(unit, blessing_of_might) then
        BuffSystem.RemoveBuffFromHeroByFunc(unit, blessing_of_might)
    end

    -- fixme: увеличивать урон напрямую (3.5 AP = 1 ед. урона)
    SetHeroStr(unit, GetHeroStr(unit, false) + 225, false)

    local timer = CreateTimer()
    local remove_buff = function()
        Paladin.RemoveBlessingOfMight(unit, timer)
    end

    BuffSystem.AddBuffToHero(unit, blessing_of_might, remove_buff)

    TimerStart(timer, 600., false, remove_buff)
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
