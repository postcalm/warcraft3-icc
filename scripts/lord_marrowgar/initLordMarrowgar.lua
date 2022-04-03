
function Init_LordMarrowgar()
    local items_list = {"ARMOR_ITEM", "ATTACK_ITEM", "HP_ITEM"}
    local items_spells_list = {"ARMOR_500", "ATTACK_1500", "HP_90K"}

    LORD_MARROWGAR = Unit:new(LICH_KING, LORD_MARROWGAR, Location(4090., -1750.), -131.)
    COLDFLAME_DUMMY = Unit:new(LICH_KING, STATIC_DUMMY, Location(4410., -1750.), -131.)

    SetHeroLevel(LORD_MARROWGAR, 83, false)

    UnitAddAbility(COLDFLAME_DUMMY, COLDFLAME)
    UnitAddAbility(LORD_MARROWGAR, WHIRLWIND)

    EquipSystem.RegisterItems(items_list, items_spells_list)
    EquipSystem.AddItemsToUnit(LORD_MARROWGAR, items_list)

    Init_Coldflame()
    --Init_BoneSpike()
    --Init_Whirlwind()
end
