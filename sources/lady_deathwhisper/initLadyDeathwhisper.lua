
function Init_LadyDeathwhisper()
    local items_list = {"ARMOR_ITEM", "ATTACK_ITEM", "HP_ITEM"}
    local items_spells_list = {"ARMOR_500", "ATTACK_1500", "HP_90K"}

    LADY_DEATHWHISPER = Unit(LICH_KING, LADY_DEATHWHISPER, Location(4095., 1498.), 270.)

    SetHeroLevel(LADY_DEATHWHISPER, 83, false)

    EquipSystem.RegisterItems(items_list, items_spells_list)
    EquipSystem.AddItemsToUnit(LADY_DEATHWHISPER, items_list)

    UnitAddAbility(LADY_DEATHWHISPER, SHADOW_BOLT)
    
    Init_ManaShield()
    Init_ShadowBolt()
end
