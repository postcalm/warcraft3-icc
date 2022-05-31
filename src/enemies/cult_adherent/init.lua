
function CultAdherent.Init()
    CultAdherent.summoned = true

    local items_list = {"ARMOR_ITEM", "HP_ITEM"}
    local items_spells_list = {"ARMOR_500", "HP_50K"}

    CultAdherent.unit = Unit(LICH_KING, CULT_ADHERENT, Location(4671., 1483.), 300.)

    CultAdherent.unit:SetLevel(83)
    CultAdherent.unit:SetMana(2000)

    --EquipSystem.RegisterItems(items_list, items_spells_list)
    --EquipSystem.AddItemsToUnit(CultAdherent.unit:GetUnit(), items_list)

    CultAdherent.InitDeathchillBolt()
end
