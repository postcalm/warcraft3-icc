
function LadyDeathwhisper.Init()
    local items_list = {"ARMOR_ITEM", "ATTACK_ITEM", "MP_ITEM"}
    local items_spells_list = {"ARMOR_500", "ATTACK_1500", "MP_50K"}

    LadyDeathwhisper.unit = Unit(LICH_KING, LADY_DEATHWHISPER, Location(4095., 1498.), 270.)

    SetHeroLevel(LadyDeathwhisper.unit, 83, false)
    SetUnitState(LadyDeathwhisper.unit, UNIT_STATE_MANA, 1000)

    EquipSystem.RegisterItems(items_list, items_spells_list)
    EquipSystem.AddItemsToUnit(LadyDeathwhisper.unit, items_list)
    --EquipSystem.AddItemsToUnit(LADY_DEATHWHISPER, {"MP_ITEM"}, 4)

    LadyDeathwhisper.InitManaShield()
    --LadyDeathwhisper.InitShadowBolt()
    --LadyDeathwhisper.InitDeathAndDecay()
    --LadyDeathwhisper.InitDominateMind()
end
