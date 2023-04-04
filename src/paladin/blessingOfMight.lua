-- Copyright (c) meiso

function Paladin.RemoveBlessingOfMight(unit, timer)
    if BuffSystem.IsBuffOnHero(unit, BLESSING_OF_MIGHT) then
        SetHeroStr(unit, GetHeroStr(unit, false) - 225, false)
        BuffSystem.RemoveBuffToHero(unit, BLESSING_OF_MIGHT)
    end
    DestroyTimer(timer)
end

function Paladin.BlessingOfMight()
    local unit = GetSpellTargetUnit()
    BuffSystem.RegisterHero(unit)

    if BuffSystem.IsBuffOnHero(unit, BLESSING_OF_MIGHT) then
        BuffSystem.RemoveBuffToHeroByFunc(unit, BLESSING_OF_MIGHT)
    end

    -- fixme: увеличивать урон напрямую (3.5 AP = 1 ед. урона)
    SetHeroStr(unit, GetHeroStr(unit, false) + 225, false)

    local timer = CreateTimer()
    local remove_buff = function()
        Paladin.RemoveBlessingOfMight(unit, timer)
    end

    BuffSystem.AddBuffToHero(unit, BLESSING_OF_MIGHT, remove_buff)

    TimerStart(timer, 600., false, remove_buff)
end

function Paladin.IsBlessingOfMight()
    return GetSpellAbilityId() == BLESSING_OF_MIGHT
end

function Paladin.InitBlessingOfMight()
    Ability(BLESSING_OF_MIGHT, blessing_of_might_tooltip, blessing_of_might_desc)
    Paladin.hero:SetAbilityManacost(BLESSING_OF_MIGHT, 5)
    Paladin.hero:SetAbilityCooldown(BLESSING_OF_MIGHT, 1.5)

    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Paladin.IsBlessingOfMight)
    event:AddAction(Paladin.BlessingOfMight)
end
