---@author meiso

function DeathKnight.Init(location)
    local loc = location or Location(4000., 150.)
    local items_list = {Items.ARMOR_ITEM, Items.ATTACK_ITEM, Items.HP_ITEM}

    DeathKnight.hero = Unit(GetLocalPlayer(), DEATH_KNIGHT, loc)

    --EquipSystem.AddItemsToUnit(DeathKnight.hero, items_list)

    DeathKnight.hero:SetLevel(80)

    DeathKnight.Runes()
end
