
function Paladin.Init()
    local items_list = {"ARMOR_ITEM", "ATTACK_ITEM", "HP_ITEM"}
    local items_spells_list = {"ARMOR_500", "ATTACK_1500", "HP_90K"}
    Paladin.hero = Unit(PLAYER_1, PALADIN, Location(3800., 200.), 90.)

    --EquipSystem.RegisterItems(items_list, items_spells_list)
    --EquipSystem.AddItemsToUnit(PALADIN, items_list)

    SetHeroLevel(Paladin.hero, 80, false)
    SetUnitState(Paladin.hero, UNIT_STATE_MANA, 800)

    UnitAddAbility(Paladin.hero, DEVOTION_AURA)
    UnitAddAbility(Paladin.hero, DIVINE_SHIELD)
    UnitAddAbility(Paladin.hero, CONSECRATION)
    UnitAddAbility(Paladin.hero, CONSECRATION_TR)
    UnitAddAbility(Paladin.hero, HAMMER_RIGHTEOUS)
    UnitAddAbility(Paladin.hero, JUDGEMENT_OF_LIGHT_TR)
    UnitAddAbility(Paladin.hero, JUDGEMENT_OF_WISDOM_TR)
    UnitAddAbility(Paladin.hero, SHIELD_OF_RIGHTEOUSNESS)
    UnitAddAbility(Paladin.hero, AVENGERS_SHIELD)

    --даём паладину книжку с бафами и пассивками
    UnitAddAbility(Paladin.hero, SPELLBOOK_PALADIN)
    UnitMakeAbilityPermanent(Paladin.hero, true, SPELLBOOK_PALADIN)
    SetPlayerAbilityAvailable(PLAYER_1, SPELLBOOK_PALADIN, true)

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

