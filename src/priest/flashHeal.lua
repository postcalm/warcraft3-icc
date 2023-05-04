-- Copyright (c) Kodpi, meiso

function Priest.CastFlashHeal()
    local cast_time = 1.5
    local target = Unit(GetSpellTargetUnit())

    --TODO: скалировать от стат
    local heal = GetRandomInt(1887, 2193)
    heal = BuffSystem.ImproveSpell(target, heal)

    -- проверяем есть ли мана
    if not Priest.hero:LoseMana{ percent = 18 } then return end

    -- отображаем кастбар
    Frame:CastBar(cast_time, "Быстрое исцеление", Priest.hero)
    TriggerSleepAction(cast_time)
    -- дропаем каст заклинания, если кастбар был сброшен
    if Frame:IsDrop() then return end

    -- даем хп указанному юниту
    target:GainLife { life = heal, show = true}
end

function Priest.IsFlashHeal()
    return GetSpellAbilityId() == FLASH_HEAL
end

function Priest.InitFlashHeal()
    Ability(FLASH_HEAL, flash_heal_tooltip, flash_heal_desc)
    Priest.hero:SetAbilityManacost(FLASH_HEAL, 18)
    Priest.hero:SetAbilityCooldown(FLASH_HEAL, 1.5)

    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Priest.IsFlashHeal)
    event:AddAction(Priest.CastFlashHeal)
end
