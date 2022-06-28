-- Copyright (c) 2022 Kodpi

function Priest.CastFlashHeal()
    local target = Unit(GetSpellTargetUnit())
    --TODO: скалировать от стат
    local heal = GetRandomInt(1887, 2193)
    if not Priest.hero:LoseMana{percent=18} then return end
    target:GainLife{life=heal}
end

function Priest.IsFlashHeal()
    return GetSpellAbilityId() == FLASH_HEAL
end

function Priest.InitFlashHeal()
    local event = EventsPlayer(PLAYER_1)
    event:RegisterUnitSpellCast()
    event:AddCondition(Priest.IsFlashHeal)
    event:AddAction(Priest.CastFlashHeal)
end
