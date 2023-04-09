-- Copyright (c) meiso

function Priest.Init(location)
    local loc = location or Location(4200., 200.)
    local items = { "ARMOR_ITEM", "ATTACK_ITEM", "HP_ITEM" }
    local items_spells = { "ARMOR_500", "ATTACK_1500", "HP_90K" }

    Priest.hero = Unit(GetLocalPlayer(), PRIEST, loc, 90.)

    EquipSystem.RegisterItems(items, items_spells)
    EquipSystem.AddItemsToUnit(Priest.hero, items)

    Priest.hero:SetLevel(80)

    Priest.hero:SetLife(5000)
    Priest.hero:SetBaseMana(3863)
    Priest.hero:SetMaxMana(5000, true)

    Priest.hero:AddAbilities(FLASH_HEAL, RENEW, CIRCLE_OF_HEALING, PRAYER_OF_MENDING)

    Priest.InitFlashHeal()
    Priest.InitRenew()
    Priest.InitCircleOfHealing()
    Priest.InitPrayerOfMending()
end
