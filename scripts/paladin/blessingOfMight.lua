
function RemoveBlessingOfMight(unit)
    SetHeroStr(unit, GetHeroStr(unit, false) - 225, false)
    BuffSystem.RemoveBuffToHero(unit, "bom")
    DestroyTimer(GetExpiredTimer())
end

function BlessingOfMight()
    local unit = GetSpellTargetUnit()

    BuffSystem.RegisterHero(unit)

    if not BuffSystem.IsBuffOnHero(unit, "bom") then
        -- fixme: увеличивать урон напрямую (3.5 AP = 1 ед. урона)
        SetHeroStr(unit, GetHeroStr(unit, false) + 225, false)
        BuffSystem.AddBuffToHero(unit, "bom")

        local remove_buff = function() RemoveBlessingOfMight(unit) end
        local tm = CreateTimer()
        TimerStart(tm, 600., false, remove_buff)
    end
end

function IsBlessingOfMight()
    return GetSpellAbilityId() == BLESSING_OF_MIGHT
end

function Init_BlessingOfMight()
    local trigger_buff = CreateTrigger()
    TriggerRegisterPlayerUnitEvent(trigger_buff, Player(0), EVENT_PLAYER_UNIT_SPELL_CAST, nil)
    TriggerAddCondition(trigger_buff, Condition(IsBlessingOfMight))
    TriggerAddAction(trigger_buff, BlessingOfMight)
end
    