--- Created by Kodpi.

function Priest.RenewHOT(unit, HP)
    SetUnitState(unit, UNIT_STATE_LIFE, GetUnitState(unit, UNIT_STATE_LIFE) + HP)
end

function Priest.CastRenew()
    --Прибавка каждые 3 секунды
    local HP = 280
    local unit = GetSpellTargetUnit()
    local mana = Priest.hero:GetManaCost(0.17)

    Priest.hero:SpendMana(mana)
    for _ = 1, 5 do
        print(unit)
        Priest.RenewHOT(unit, HP)
        TriggerSleepAction(3.)
    end
end

function Priest.IsRenew()
    return GetSpellAbilityId() == RENEW
end

function Priest.InitRenew()
    local event = EventsPlayer(PLAYER_1)
    event:RegisterUnitSpellCast()
    event:AddCondition(Priest.IsRenew)
    event:AddAction(Priest.CastRenew)
end