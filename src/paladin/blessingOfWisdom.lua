-- Copyright (c) meiso

function Paladin.RemoveBlessingOfWisdom(unit, items_list, timer)
    if BuffSystem.IsBuffOnHero(unit, blessing_of_wisdom) then
        EquipSystem.RemoveItemsToUnit(unit, items_list)
        BuffSystem.RemoveBuffFromHero(unit, blessing_of_wisdom)
    end
    DestroyTimer(timer)
end

function Paladin.BlessingOfWisdom()
    local unit = GetSpellTargetUnit()
    local items_list = { "BLESSING_OF_WISDOM_ITEM" }
    local items_spells_list = { "BLESSING_OF_WISDOM" }

    BuffSystem.RegisterHero(unit)
    EquipSystem.RegisterItems(items_list, items_spells_list)

    if BuffSystem.IsBuffOnHero(unit, blessing_of_wisdom) then
        BuffSystem.RemoveBuffFromHeroByFunc(unit, blessing_of_wisdom)
    end

    EquipSystem.AddItemsToUnit(unit, items_list)

    local timer = CreateTimer()
    local remove_buff = function()
        Paladin.RemoveBlessingOfWisdom(unit, items_list, timer)
    end
    BuffSystem.AddBuffToHero(unit, blessing_of_wisdom, remove_buff)

    TimerStart(timer, 600., false, remove_buff)
end

function Paladin.IsBlessingOfWisdom()
    return blessing_of_wisdom:SpellCasted()
end

function Paladin.InitBlessingOfWisdom()
    blessing_of_wisdom:Init()
    Paladin.hero:SetAbilityManacost(blessing_of_wisdom:GetId(), 5)
    Paladin.hero:SetAbilityCooldown(blessing_of_wisdom:GetId(), 1.5)

    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Paladin.IsBlessingOfWisdom)
    event:AddAction(Paladin.BlessingOfWisdom)
end
