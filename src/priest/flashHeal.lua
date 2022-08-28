-- Copyright (c) 2022 Kodpi, meiso

function Priest.CastFlashHeal()
    local cast_time = 1.5
    local target = Unit(GetSpellTargetUnit())

    --TODO: скалировать от стат
    local heal = GetRandomInt(1887, 2193)

    -- проверяем есть ли мана
    if not Priest.hero:LoseMana{percent=18} then return end

    -- отображаем кастбар
    Frame:CastBar(cast_time, "Быстрое исцеление", Priest.hero)
    TriggerSleepAction(cast_time)
    -- дропаем каст заклинания, если кастбар был сброшен
    if Frame:IsDrop() then return end

    -- даем хп указанному юниту
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
