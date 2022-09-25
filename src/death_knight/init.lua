-- Copyright (c) meiso

function DeathKnight.Init(location)
    local loc = location or Location(4000., 150.)
    local items_list = {"ARMOR_ITEM", "ATTACK_ITEM", "HP_ITEM"}
    local items_spells_list = {"ARMOR_500", "ATTACK_1500", "HP_90K"}

    DeathKnight.hero = Unit(GetLocalPlayer(), DEATH_KNIGHT, loc)

    --EquipSystem.RegisterItems(items_list, items_spells_list)
    --EquipSystem.AddItemsToUnit(DeathKnight.hero, items_list)

    DeathKnight.hero:SetLevel(80)

    DeathKnight.Runes()
end
