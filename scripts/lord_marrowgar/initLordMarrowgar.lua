
--setdef SUFFIX_NAME = LM
--setdef COUNT = 3
--INIT_STRUCT_ITEMS()

function Init_LordMarrowgar()
    local lord_marrowgar = CreateUnit(Player(10), LORD_MARROWGAR, 4090., -1750., -131.)
    UnitAddAbility(DUMMY_LM, COLDFLAME)
    UnitAddAbility(lord_marrowgar, WHIRLWIND)
    
    --String items_id = String.create("ARMOR_ITEM, ATTACK_ITEM, HP_ITEM")
    --String items_spells_id = String.create("ARMOR_500, ATTACK_1500, HP_90K")
    print("init")
    print(FourCC('I001'))
    reg_item_eq(FourCC('I001'), "A008", 1)
    equip_items_id(lord_marrowgar, FourCC('I001'), 1)
    --FILL_STRUCT_ITEMS(items_id, items_spells_id)
    --REGISTRATION_ITEMS()
    --ADD_ITEMS_TO_UNIT(LORD_MARROWGAR)
    print("endinit")
    --Init_Coldflame()
    --Init_BoneSpike()
    --Init_Whirlwind()
end
