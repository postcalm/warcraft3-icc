
function Init_LadyDeathwhisper()
    local items_list = {"ARMOR_ITEM", "ATTACK_ITEM", "HP_ITEM"}
    local items_spells_list = {"ARMOR_500", "ATTACK_1500", "HP_90K"}
    local player = Player(10)

    local lady_deathwhisper = CreateUnit(player, LADY_DEATHWHISPER, 4095.6, 1498.8, 270.000)
    LADY_DEATHWHISPER = lady_deathwhisper
    AREA_LM = gg_rct_areaLD

    EquipSystem.RegisterItems(items_list, items_spells_list)
    EquipSystem.AddItemsToUnit(LADY_DEATHWHISPER, items_list)
    
    Init_ManaShield()
    Init_ShadowBolt()
end
