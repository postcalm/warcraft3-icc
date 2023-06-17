---@author meiso

function Priest.ResetToDefault()
    for _, ability in pairs(ALL_MAIN_PRIEST_SPELLS) do
        Priest.hero:SetAbilityManacost(ability:GetId(), ability.manacost)
        Priest.hero:SetAbilityCooldown(ability:GetId(), ability.cooldown)
    end
    for _, ability in pairs(ALL_OFF_PRIEST_SPELLS) do
        Priest.hero:SetAbilityManacost(ability:GetId(), ability.manacost)
        Priest.hero:SetAbilityCooldown(ability:GetId(), ability.cooldown)
    end
end

function Priest.Init(location)
    local loc = location or Location(4200., 200.)
    local items = { Items.ARMOR_ITEM, Items.ATTACK_ITEM }

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

    Priest.ResetToDefault()
end
