---@author meiso

function Paladin.Init(location)
    local loc = location or Location(4000., 200.)
    local items_list = {Items.ARMOR_ITEM, Items.ATTACK_ITEM, Items.HP_ITEM}

    Paladin.hero = Unit(GetLocalPlayer(), PALADIN, loc, 90.)

    --EquipSystem.AddItemsToUnit(Paladin.hero, items_list)

    Paladin.hero:SetLevel(80)
    Paladin.hero:SetBaseMana(4394)
    Paladin.hero:SetMaxMana(4394, true)

    Paladin.hero:AddAbilities(
            DIVINE_SHIELD,
            CONSECRATION,
            HAMMER_RIGHTEOUS,
            JUDGEMENT_OF_LIGHT_TR,
            JUDGEMENT_OF_WISDOM_TR,
            SHIELD_OF_RIGHTEOUSNESS,
            AVENGERS_SHIELD,
            SPELLBOOK_PALADIN
    )

    --даём паладину книжку с бафами и пассивками
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
end
