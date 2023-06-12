---@author meiso

function Priest.Reset()

end

function Priest.Init(location)
    local loc = location or Location(4200., 200.)
    local items = { Items.ARMOR_ITEM, Items.ATTACK_ITEM, Items.HP_ITEM }

    Priest.hero = Unit(GetLocalPlayer(), PRIEST, loc, 90.)

    EquipSystem.AddItemsToUnit(Priest.hero, items)
    Priest.hero:SetName("MeisoHolyPriest")
    Priest.hero:SetLevel(80)

    Priest.hero:SetLife(100)
    Priest.hero:SetBaseMana(3863)
    Priest.hero:SetMaxMana(5000, true)

    Priest.hero:AddAbilities(ALL_MAIN_PRIEST_SPELLS)
    Priest.hero:AddSpellbook(SPELLBOOK_PRIEST)

    Priest.InitFlashHeal()
    Priest.InitRenew()
    Priest.InitCircleOfHealing()
    Priest.InitPrayerOfMending()
    Priest.InitPowerWordShield()
    Priest.InitGuardianSpirit()
    Priest.InitPowerWordFortitude()
    Priest.InitInnerFire()
    Priest.InitSpiritOfRedemption()
end
