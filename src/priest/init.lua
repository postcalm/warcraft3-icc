---@author meiso

function Priest.ResetToDefault()
    local items = { Items.ARMOR_ITEM, Items.ATTACK_ITEM }

    EquipSystem.AddItemsToUnit(Priest.hero, items)

    Priest.hero:SetLevel(80)

    Priest.hero:SetLife(100)
    Priest.hero:SetBaseMana(3863)
    Priest.hero:SetMaxMana(5000, true)

    Priest.hero:AddAbilities(ALL_MAIN_PRIEST_SPELLS)
    Priest.hero:AddSpellbook(SPELLBOOK_PRIEST)

    for _, ability in pairs(ALL_MAIN_PRIEST_SPELLS) do
        ability:Init()
        Priest.hero:SetAbilityManacost(ability:GetId(), ability.manacost)
        Priest.hero:SetAbilityCooldown(ability:GetId(), ability.cooldown)
    end
    for _, ability in pairs(ALL_OFF_PRIEST_SPELLS) do
        ability:Init()
        Priest.hero:SetAbilityManacost(ability:GetId(), ability.manacost)
        Priest.hero:SetAbilityCooldown(ability:GetId(), ability.cooldown)
    end
end

function Priest.Init(location, unit, name)
    location = location or Location(4200., 200.)
    name = name or "Priest"
    unit = unit or Unit(GetLocalPlayer(), PRIEST, location, 90.):GetId()

    Priest.hero = Unit(unit)
    Priest.hero:SetName(name)

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
