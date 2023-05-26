-- Copyright (c) meiso

function Paladin.RemoveBlessingOfKings(unit, stat)
    if BuffSystem.IsBuffOnHero(unit, blessing_of_kings) then
        SetHeroStr(unit, GetHeroStr(unit, false) - stat[1], false)
        SetHeroAgi(unit, GetHeroAgi(unit, false) - stat[2], false)
        SetHeroInt(unit, GetHeroInt(unit, false) - stat[3], false)
        BuffSystem.RemoveBuffFromHero(unit, blessing_of_kings)
    end
end

function Paladin.BlessingOfKings()
    local unit = GetSpellTargetUnit()
    BuffSystem.RegisterHero(unit)

    if BuffSystem.IsBuffOnHero(unit, blessing_of_kings) then
        BuffSystem.RemoveBuffFromHeroByFunc(unit, blessing_of_kings)
    end

    --массив с доп. статами
    local stat = {
        R2I(GetHeroStr(unit, false) * 0.1),
        R2I(GetHeroAgi(unit, false) * 0.1),
        R2I(GetHeroInt(unit, false) * 0.1)
    }
    --бафаем цель
    SetHeroStr(unit, GetHeroStr(unit, false) + stat[1], false)
    SetHeroAgi(unit, GetHeroAgi(unit, false) + stat[2], false)
    SetHeroInt(unit, GetHeroInt(unit, false) + stat[3], false)

    --создаем лямбду для снятия бафа
    local timer = CreateTimer()
    local remove_buff = function()
        Paladin.RemoveBlessingOfKings(unit, stat)
        DestroyTimer(timer)
    end

    BuffSystem.AddBuffToHero(unit, blessing_of_kings, remove_buff)

    --скидываем баф через 10 минут
    TimerStart(timer, 600., false, remove_buff)

end

function Paladin.IsBlessingOfKings()
    return blessing_of_kings:SpellCasted()
end

function Paladin.InitBlessingOfKings()
    blessing_of_kings:Init()
    Paladin.hero:SetAbilityManacost(blessing_of_kings:GetId(), 6)
    Paladin.hero:SetAbilityCooldown(blessing_of_kings:GetId(), 1.5)

    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Paladin.IsBlessingOfKings)
    event:AddAction(Paladin.BlessingOfKings)
end
