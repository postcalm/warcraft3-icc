
function Priest.Init()
    local items_list = {"ARMOR_ITEM", "ATTACK_ITEM", "HP_ITEM"}
    local items_spells_list = {"ARMOR_500", "ATTACK_1500", "HP_90K"}
    Priest.hero = Unit(PLAYER_1, PRIEST, Location(3950., -3040.), 90.)

    --EquipSystem.RegisterItems(items_list, items_spells_list)
    --EquipSystem.AddItemsToUnit(hero, items_list)

    Priest.hero:SetLevel(80)
    Priest.hero:SetStateMana(2000)

    Priest.hero:AddAbilities(FLASH_HEAL, RENEW, CIRCLE_OF_HEALING)

    Priest.InitFlashHeal()
    Priest.InitRenew()
    Priest.InitCircleOfHealing()
end
