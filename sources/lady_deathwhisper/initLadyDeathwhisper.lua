
function Init_LadyDeathwhisper()
    local items_list = {"ARMOR_ITEM", "ATTACK_ITEM", "MP_ITEM"}
    local items_spells_list = {"ARMOR_500", "ATTACK_1500", "MP_50K"}

    LADY_DEATHWHISPER = Unit(LICH_KING, LADY_DEATHWHISPER, Location(4095., 1498.), 270.)

    SetHeroLevel(LADY_DEATHWHISPER, 83, false)

    EquipSystem.RegisterItems(items_list, items_spells_list)
    EquipSystem.AddItemsToUnit(LADY_DEATHWHISPER, items_list)
    EquipSystem.AddItemsToUnit(LADY_DEATHWHISPER, {"MP_ITEM"}, 4)

    Init_ManaShield()
    Init_ShadowBolt()
    --Init_DeathAndDecay()
    Init_DominateMind()
end
