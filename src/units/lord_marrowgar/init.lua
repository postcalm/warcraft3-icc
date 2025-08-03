---@author meiso

function LordMarrowgar.ResetToDefault()
    local items_list = { Items.ARMOR_ITEM, Items.ATTACK_ITEM, Items.HP_ITEM }

    EquipSystem.AddItemsToUnit(LordMarrowgar.unit, items_list)

    LordMarrowgar.unit:SetLevel(83)

    LordMarrowgar.coldflame:AddAbilities(COLDFLAME)
end

function LordMarrowgar.Init()
    local location = GetRandomLocInRect(gg_rct_LordMarrowSpawn)

    LordMarrowgar.unit = Unit(LICH_KING, LORD_MARROWGAR, location, -90.)
    LordMarrowgar.coldflame = Unit(LICH_KING, DUMMY, location, -90.)

    LordMarrowgar.unit:AutoRegen()

    LordMarrowgar.InitColdflame()
    LordMarrowgar.InitBoneSpike()
    LordMarrowgar.InitWhirlwind()

    LordMarrowgar.ResetToDefault()
end
