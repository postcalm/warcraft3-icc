--- Created by meiso.

function Init_Priest()
    local items_list = {"ARMOR_ITEM", "ATTACK_ITEM", "HP_ITEM"}
    local items_spells_list = {"ARMOR_500", "ATTACK_1500", "HP_90K"}
    PRIEST = Unit:new(Player(0), PRIEST, Location(3950., -3040.), 90.)

    EquipSystem.RegisterItems(items_list, items_spells_list)
    EquipSystem.AddItemsToUnit(PRIEST, items_list)

    SetHeroLevel(PRIEST, 80, false)
    SetUnitState(PRIEST, UNIT_STATE_MANA, 2000)

    --UnitAddAbility(PRIEST, FLASH_HEAL)
    --Init_Flash_Heal()

    --Спел Обновление
    UnitAddAbility(PRIEST, RENEW)
    Init_Renew()

end