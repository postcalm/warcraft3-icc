--- Created by Kodpi.

function Priest.CastRenew()
    --Прибавка каждые 3 секунды
    local HP = 280
    local unit = Unit(GetSpellTargetUnit())

    Priest.hero:LoseMana{percent=17}
    for _ = 1, 5 do
        unit:GainLife{life=HP}
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