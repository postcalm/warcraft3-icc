
function Priest.Init()
    local items_list = {"ARMOR_ITEM", "ATTACK_ITEM", "HP_ITEM"}
    local items_spells_list = {"ARMOR_500", "ATTACK_1500", "HP_90K"}
    Priest.hero = Unit(PLAYER_1, PRIEST, Location(3950., -3040.), 90.)
    local hero = Priest.hero:GetUnit()

    --EquipSystem.RegisterItems(items_list, items_spells_list)
    --EquipSystem.AddItemsToUnit(hero, items_list)

    SetHeroLevel(hero, 80, false)
    SetUnitState(hero, UNIT_STATE_MANA, 2000)

    UnitAddAbility(hero, FLASH_HEAL)
    UnitAddAbility(hero, RENEW)
    UnitAddAbility(hero, CIRCLE_OF_HEALING)

    Priest.InitFlashHeal()
    Priest.InitRenew()
    Priest.InitCircleOfHealing()
end
