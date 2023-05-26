-- Copyright (c) meiso

function Paladin.RemovePowerWordFortitude(unit, items_list, timer)
    if BuffSystem.IsBuffOnHero(unit, power_word_fortitude) then
        EquipSystem.RemoveItemsToUnit(unit, items_list)
        BuffSystem.RemoveBuffFromHero(unit, power_word_fortitude)
    end
    DestroyTimer(timer)
end

function Priest.PowerWordFortitude()
    --TODO: пока что даём как есть. потом отскалируем
    local unit = GetSpellTargetUnit()
    local items = { "PRAYER_OF_FORTITUDE_ITEM" }
    local items_spells = { "HP_165_POF" }

    BuffSystem.RegisterHero(unit)
    EquipSystem.RegisterItems(items, items_spells)

    if BuffSystem.IsBuffOnHero(unit, power_word_fortitude) then
        BuffSystem.RemoveBuffFromHeroByFunc(unit, power_word_fortitude)
    end

    EquipSystem.AddItemsToUnit(unit, items)

    local timer = CreateTimer()
    local remove_buff = function()
        Paladin.RemovePowerWordFortitude(unit, items, timer)
    end
    BuffSystem.AddBuffToHero(unit, power_word_fortitude, remove_buff)

    TimerStart(timer, 600., false, remove_buff)

end

function Paladin.IsPowerWordFortitude()
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
