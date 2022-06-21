
function Paladin.RemoveBlessingOfKings(unit, stat, timer)
    if BuffSystem.IsBuffOnHero(unit, BLESSING_OF_KINGS) then
        SetHeroStr(unit, GetHeroStr(unit, false) - stat[1], false)
        SetHeroAgi(unit, GetHeroAgi(unit, false) - stat[2], false)
        SetHeroInt(unit, GetHeroInt(unit, false) - stat[3], false)
        BuffSystem.RemoveBuffToHero(unit, BLESSING_OF_KINGS)
    end
    DestroyTimer(timer)
end

function Paladin.BlessingOfKings()
    local unit = GetSpellTargetUnit()
    BuffSystem.RegisterHero(unit)

    Paladin.hero:LoseMana{percent=6}

    if BuffSystem.IsBuffOnHero(unit, BLESSING_OF_KINGS) then
        BuffSystem.RemoveBuffToHeroByFunc(unit, BLESSING_OF_KINGS)
    end

    --массив с доп. статами
    local stat = {
        R2I(GetHeroStr(unit, false) * 0.1),
        R2I(GetHeroAgi(unit, false) * 0.1),
        R2I(GetHeroInt(unit, false) * 0.1)
    }
    SetHeroStr(unit, GetHeroStr(unit, false) + stat[1], false)
    SetHeroAgi(unit, GetHeroAgi(unit, false) + stat[2], false)
    SetHeroInt(unit, GetHeroInt(unit, false) + stat[3], false)

    --создаем лямбду для снятия бафа
    local timer = CreateTimer()
    local remove_buff = function() Paladin.RemoveBlessingOfKings(unit, stat, timer) end

    BuffSystem.AddBuffToHero(unit, BLESSING_OF_KINGS, remove_buff)

    --скидываем баф через 10 минут
    TimerStart(timer, 600., false, remove_buff)

end

function Paladin.IsBlessingOfKings()
    return GetSpellAbilityId() == BLESSING_OF_KINGS
end

function Paladin.InitBlessingOfKings()
    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Paladin.IsBlessingOfKings)
    event:AddAction(Paladin.BlessingOfKings)
end
