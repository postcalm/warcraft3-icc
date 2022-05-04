
function LadyDeathwhisper.Init()
    local items_list = {"ARMOR_ITEM", "ATTACK_ITEM", "MP_ITEM"}
    local items_spells_list = {"ARMOR_500", "ATTACK_1500", "MP_50K"}

    LadyDeathwhisper.unit = Unit(LICH_KING, LADY_DEATHWHISPER, Location(4095., 1498.), 270.)

    LadyDeathwhisper.unit:SetLevel(83)
    LadyDeathwhisper.unit:SetMana(2000)

    --EquipSystem.RegisterItems(items_list, items_spells_list)
    --EquipSystem.AddItemsToUnit(LadyDeathwhisper.unit:GetUnit(), items_list)
    --EquipSystem.AddItemsToUnit(LadyDeathwhisper.unit:GetUnit(), {"MP_ITEM"}, 4)

    -- both phase
    --LadyDeathwhisper.InitDeathAndDecay()
    -- только в 25-ке
    --LadyDeathwhisper.InitDominateMind()

    -- first phase
    LadyDeathwhisper.InitManaShield()
    --LadyDeathwhisper.InitShadowBolt()

    -- second phase
    --LadyDeathwhisper.InitFrostBolt()
    LadyDeathwhisper.InitFrostBoltVolley()
end
