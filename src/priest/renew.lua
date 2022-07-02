-- Copyright (c) 2022 Kodpi

function Priest.CastRenew()
    --Прибавка каждые 3 секунды
    local HP = 280
    local unit = Unit(GetSpellTargetUnit())

    if not Priest.hero:LoseMana{percent=17} then return end
    for _ = 1, 5 do
        unit:GainLife{life=HP}
        TriggerSleepAction(3.)
    end
end

function Priest.IsRenew()
    return GetSpellAbilityId() == RENEW
end

function Priest.InitRenew()
    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Priest.IsRenew)
    event:AddAction(Priest.CastRenew)
end