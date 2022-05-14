
function LordMarrowgar.Init()
    local items_list = {"ARMOR_ITEM", "ATTACK_ITEM", "HP_ITEM"}
    local items_spells_list = {"ARMOR_500", "ATTACK_1500", "HP_90K"}

    LordMarrowgar.unit = Unit(LICH_KING, LORD_MARROWGAR, Location(4090., -1750.), -131.)
    LordMarrowgar.coldflame = Unit(LICH_KING, DUMMY, Location(4410., -1750.), -131.)

    EquipSystem.RegisterItems(items_list, items_spells_list)
    EquipSystem.AddItemsToUnit(LordMarrowgar.unit:GetUnit(), items_list)

    LordMarrowgar.unit:SetLevel(83)

    LordMarrowgar.coldflame:AddAbilities(COLDFLAME)
    --LordMarrowgar.unit:AddAbilities(WHIRLWIND)

    LordMarrowgar.InitColdflame()
    --LordMarrowgar.InitBoneSpike()
    --LordMarrowgar.InitWhirlwind()
end
