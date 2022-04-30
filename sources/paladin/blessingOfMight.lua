
function Paladin.RemoveBlessingOfMight(unit)
    if BuffSystem.IsBuffOnHero(unit, "BlessingOfMight") then
        SetHeroStr(unit, GetHeroStr(unit, false) - 225, false)
        BuffSystem.RemoveBuffToHero(unit, "BlessingOfMight")
    end
    DestroyTimer(GetExpiredTimer())
end

function Paladin.BlessingOfMight()
    local unit = GetSpellTargetUnit()
    BuffSystem.RegisterHero(unit)

    if not BuffSystem.IsBuffOnHero(unit, "BlessingOfMight") then
        -- fixme: увеличивать урон напрямую (3.5 AP = 1 ед. урона)
        SetHeroStr(unit, GetHeroStr(unit, false) + 225, false)

        local remove_buff = function() Paladin.RemoveBlessingOfMight(unit) end
        local timer = CreateTimer()

        BuffSystem.AddBuffToHero(unit, "BlessingOfMight", remove_buff)

        TimerStart(timer, 600., false, remove_buff)
    end
end

function Paladin.IsBlessingOfMight()
    return GetSpellAbilityId() == BLESSING_OF_MIGHT
end

function Paladin.InitBlessingOfMight()
    local event = EventsPlayer(PLAYER_1)
    event:RegisterUnitSpellCast()
    event:AddCondition(Paladin.IsBlessingOfMight)
    event:AddAction(Paladin.BlessingOfMight)
end
    