
function Init_LordMarrowgar()
    local items_list = {"ARMOR_ITEM", "ATTACK_ITEM", "HP_ITEM"}
    local items_spells_list = {"ARMOR_500", "ATTACK_1500", "HP_90K"}
    local player = Player(10)

    LORD_MARROWGAR = CreateUnit(player, LORD_MARROWGAR, 4090., -1750., -131.)
    COLDFLAME_DUMMY = CreateUnit(player, STATIC_DUMMY, 4410., -1750., -131.)

    UnitAddAbility(COLDFLAME_DUMMY, COLDFLAME)
    UnitAddAbility(LORD_MARROWGAR, WHIRLWIND)

    EquipSystem.RegisterItems(items_list, items_spells_list)
    EquipSystem.AddItemsToUnit(LORD_MARROWGAR, items_list)
    Init_Coldflame()
    --Init_BoneSpike()
    --Init_Whirlwind()
end
