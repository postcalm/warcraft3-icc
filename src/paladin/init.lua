---@author meiso

function Paladin.ResetToDefault()
    for _, ability in pairs(ALL_MAIN_PALADIN_SPELLS) do
        Paladin.hero:SetAbilityManacost(ability:GetId(), ability.manacost)
        Paladin.hero:SetAbilityCooldown(ability:GetId(), ability.cooldown)
    end
    for _, ability in pairs(ALL_OFF_PALADIN_SPELLS) do
        Paladin.hero:SetAbilityManacost(ability:GetId(), ability.manacost)
        Paladin.hero:SetAbilityCooldown(ability:GetId(), ability.cooldown)
    end
end

function Paladin.Init(location)
    local loc = location or Location(4000., 200.)
    local items_list = {Items.ARMOR_ITEM, Items.ATTACK_ITEM}

    Paladin.hero = Unit(GetLocalPlayer(), PALADIN, loc, 90.)

    EquipSystem.AddItemsToUnit(Paladin.hero, items_list)

    Paladin.hero:SetLevel(80)
    Paladin.hero:SetBaseMana(4394)
    Paladin.hero:SetMaxMana(4394, true)

    Paladin.hero:AddAbilities(ALL_MAIN_PALADIN_SPELLS)
    Paladin.hero:AddSpellbook(SPELLBOOK_PALADIN)

    Paladin.InitConsecration()
    Paladin.InitBlessingOfKings()
    Paladin.InitBlessingOfMight()
    Paladin.InitBlessingOfSanctuary()
    Paladin.InitBlessingOfWisdom()
    Paladin.InitJudgementOfLight()
    Paladin.InitJudgementOfWisdom()
    Paladin.InitShieldOfRighteousness()
    Paladin.InitAvengersShield()

    Paladin.ResetToDefault()
end
