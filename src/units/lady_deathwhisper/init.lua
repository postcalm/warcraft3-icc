---@author meiso

function LadyDeathwhisper.ResetToDefault()
    local items_list = {Items.ARMOR_ITEM, Items.ATTACK_ITEM, Items.HP_ITEM}

    EquipSystem.AddItemsToUnit(LadyDeathwhisper.unit, items_list)
    EquipSystem.AddItemsToUnit(LadyDeathwhisper.unit, {Items.MP_ITEM}, 4)

    LadyDeathwhisper.unit:SetLevel(83)
    LadyDeathwhisper.unit:SetMana(500)
end

function LadyDeathwhisper.Init()
    local location = GetRandomLocInRect(gg_rct_LadyDeathSpawn)
    LadyDeathwhisper.unit = Unit(LICH_KING, LADY_DEATHWHISPER, location, -90.)

    LadyDeathwhisper.unit:AutoRegen()

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

    LadyDeathwhisper.ResetToDefault()
end
