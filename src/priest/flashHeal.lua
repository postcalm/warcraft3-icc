-- Copyright (c) 2022 Kodpi

function Priest.CastFlashHeal()
    Frame:CastBar(1.5)
    local target = Unit(GetSpellTargetUnit())
    TriggerSleepAction(1.5)
    --TODO: скалировать от стат
    local heal = GetRandomInt(1887, 2193)
    if not Priest.hero:LoseMana{percent=18} then return end
    target:GainLife{life=heal}
end

function Priest.IsFlashHeal()
    return GetSpellAbilityId() == FLASH_HEAL
end

function Priest.InitFlashHeal()
    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Priest.IsFlashHeal)
    event:AddAction(Priest.CastFlashHeal)
end
