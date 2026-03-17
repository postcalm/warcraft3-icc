---@author meiso

function Paladin.ResetToDefault()
    local items_list = { Items.ARMOR_ITEM, Items.ATTACK_ITEM }

    EquipSystem.AddItemsToUnit(Paladin.hero, items_list)

    Paladin.hero:SetLevel(80)
    Paladin.hero:SetBaseMana(4394)
    Paladin.hero:SetMaxMana(4394, true)

    Paladin.hero:AddAbilities(ALL_MAIN_PALADIN_SPELLS)
    Paladin.hero:AddSpellbook(SPELLBOOK_PALADIN)

    for _, ability in pairs(ALL_MAIN_PALADIN_SPELLS) do
        ability:Init()
        Paladin.hero:SetAbilityManacost(ability:GetId(), ability.manacost)
        Paladin.hero:SetAbilityCooldown(ability:GetId(), ability.cooldown)
    end
    for _, ability in pairs(ALL_OFF_PALADIN_SPELLS) do
        ability:Init()
        Paladin.hero:SetAbilityManacost(ability:GetId(), ability.manacost)
        Paladin.hero:SetAbilityCooldown(ability:GetId(), ability.cooldown)
    end
end

function Paladin.Init(location, unit, name, player)
    location = location or GetRandomLocInRect(AREAS.START_SPAWN)
    location = Location(850., 3850.)
    name = name or "Paladin"
    unit = unit or Unit(player, PALADIN, location, 90.):GetId()

    Paladin.hero = Unit(unit)
    Paladin.hero:SetName(name)

    Paladin.InitConsecration(player)
    Paladin.InitBlessingOfKings(player)
    Paladin.InitBlessingOfMight(player)
    Paladin.InitBlessingOfSanctuary(player)
    Paladin.InitBlessingOfWisdom(player)
    Paladin.InitJudgementOfLight(player)
    Paladin.InitJudgementOfWisdom(player)
    Paladin.InitShieldOfRighteousness(player)
    Paladin.InitAvengersShield(player)

    Paladin.ResetToDefault()
end
