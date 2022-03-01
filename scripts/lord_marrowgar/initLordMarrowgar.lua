
function Init_LordMarrowgar()
    local items_list = {"ARMOR_ITEM", "ATTACK_ITEM", "HP_ITEM"}
    local items_spells_list = {"ARMOR_500", "ATTACK_1500", "HP_90K"}
    local player = Player(10)

    local lord_marrowgar = CreateUnit(player, LORD_MARROWGAR, 4090., -1750., -131.)
    local dummy_lm = CreateUnit(player, DUMMY, 4410., -1750., -131.)
    UnitAddAbility(dummy_lm, COLDFLAME)
    UnitAddAbility(lord_marrowgar, WHIRLWIND)

    EquipSystem.RegisterItems(items_list, items_spells_list)
    EquipSystem.AddItemsToUnit(lord_marrowgar, items_list)

    --Init_Coldflame()
    --Init_BoneSpike()
    --Init_Whirlwind()
end
