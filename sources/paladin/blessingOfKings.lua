
function RemoveBlessingOfKings(unit, stat)
    SetHeroStr(unit, GetHeroStr(unit, false) - stat[1], false)
    SetHeroAgi(unit, GetHeroAgi(unit, false) - stat[2], false)
    SetHeroInt(unit, GetHeroInt(unit, false) - stat[3], false)
    BuffSystem.RemoveBuffToHero(unit, "bok")
    DestroyTimer(GetExpiredTimer())
end

function BlessingOfKings()
    local unit = GetSpellTargetUnit()
    BuffSystem.RegisterHero(unit)

    if not BuffSystem.IsBuffOnHero(unit, "bok") then
        --массив с доп. статами
        local stat = {
            R2I(GetHeroStr(unit, false) * 0.1),
            R2I(GetHeroAgi(unit, false) * 0.1),
            R2I(GetHeroInt(unit, false) * 0.1)
        }
        SetHeroStr(unit, GetHeroStr(unit, false) + stat[1], false)
        SetHeroAgi(unit, GetHeroAgi(unit, false) + stat[2], false)
        SetHeroInt(unit, GetHeroInt(unit, false) + stat[3], false)
        BuffSystem.AddBuffToHero(unit, "bok")

        --скидываем баф через 10 минут
        local remove_buff = function() RemoveBlessingOfKings(unit, stat) end
        local tm = CreateTimer()
        TimerStart(tm, 600., false, remove_buff)
    end
end

function IsBlessingOfKings()
    return GetSpellAbilityId() == BLESSING_OF_KINGS
end

function Init_BlessingOfKings()
    local event = EventsPlayer(Player(0))
    event:RegisterUnitSpellCast()
    event:AddCondition(IsBlessingOfKings)
    event:AddAction(BlessingOfKings)
end
