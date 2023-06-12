
function LadyDeathwhisper.Init()
    local items_list = {Items.ARMOR_ITEM, Items.ATTACK_ITEM, Items.HP_ITEM}

    LadyDeathwhisper.unit = Unit(LICH_KING, LADY_DEATHWHISPER, Location(4095., 1498.), 270.)

    LadyDeathwhisper.unit:SetLevel(83)
    LadyDeathwhisper.unit:SetMana(500)

    EquipSystem.AddItemsToUnit(LadyDeathwhisper.unit, items_list)
    EquipSystem.AddItemsToUnit(LadyDeathwhisper.unit, {Items.MP_ITEM}, 4)

    -- both phase
    LadyDeathwhisper.InitDeathAndDecay()
    LadyDeathwhisper.InitSummoning()
    -- только в 25-ке
    --LadyDeathwhisper.InitDominateMind()

    -- first phase
    LadyDeathwhisper.InitManaShield()
    LadyDeathwhisper.InitShadowBolt()

    -- second phase
    LadyDeathwhisper.InitFrostBolt()
    LadyDeathwhisper.InitFrostBoltVolley()
end
