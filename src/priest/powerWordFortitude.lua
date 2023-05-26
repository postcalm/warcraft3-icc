-- Copyright (c) meiso

function Priest.RemovePowerWordFortitude(unit, items_list, timer)
    if BuffSystem.IsBuffOnHero(unit, power_word_fortitude) then
        EquipSystem.RemoveItemsToUnit(unit, items_list)
        BuffSystem.RemoveBuffFromHero(unit, power_word_fortitude)
    end
    DestroyTimer(timer)
end

function Priest.PowerWordFortitude()
    --TODO: пока что даём как есть. потом отскалируем
    local unit = GetSpellTargetUnit()
    local items = { "POWER_WORD_FORTITUDE_ITEM" }

    BuffSystem.RegisterHero(unit)

    if BuffSystem.IsBuffOnHero(unit, power_word_fortitude) then
        BuffSystem.RemoveBuffFromHeroByFunc(unit, power_word_fortitude)
    end

    EquipSystem.AddItemsToUnit(unit, items)

    local timer = CreateTimer()
    local remove_buff = function()
        Paladin.RemovePowerWordFortitude(unit, items)
    end
    BuffSystem.AddBuffToHero(unit, power_word_fortitude, remove_buff)

    TimerStart(timer, 600., false, remove_buff)
end

function Priest.IsPowerWordFortitude()
    return power_word_fortitude:SpellCasted()
end

function Priest.InitPowerWordFortitude()
    power_word_fortitude:Init()
    Priest.hero:SetAbilityManacost(power_word_fortitude:GetId(), 27)
    Priest.hero:SetAbilityCooldown(power_word_fortitude:GetId(), 1.5)

    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Priest.IsPowerWordFortitude)
    event:AddAction(Priest.PowerWordFortitude)
end
