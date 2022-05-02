
function Paladin.Init()
    local items_list = {"ARMOR_ITEM", "ATTACK_ITEM", "HP_ITEM"}
    local items_spells_list = {"ARMOR_500", "ATTACK_1500", "HP_90K"}
    Paladin.hero = Unit(PLAYER_1, PALADIN, Location(3800., 200.), 90.)
    local hero = Paladin.hero:GetUnit()

    --EquipSystem.RegisterItems(items_list, items_spells_list)
    --EquipSystem.AddItemsToUnit(hero, items_list)

    SetHeroLevel(hero, 80, false)
    SetUnitState(hero, UNIT_STATE_MANA, 800)

    UnitAddAbility(hero, DEVOTION_AURA)
    UnitAddAbility(hero, DIVINE_SHIELD)
    UnitAddAbility(hero, CONSECRATION)
    UnitAddAbility(hero, CONSECRATION_TR)
    UnitAddAbility(hero, HAMMER_RIGHTEOUS)
    UnitAddAbility(hero, JUDGEMENT_OF_LIGHT_TR)
    UnitAddAbility(hero, JUDGEMENT_OF_WISDOM_TR)
    UnitAddAbility(hero, SHIELD_OF_RIGHTEOUSNESS)
    UnitAddAbility(hero, AVENGERS_SHIELD)

    --даём паладину книжку с бафами и пассивками
    UnitAddAbility(hero, SPELLBOOK_PALADIN)
    UnitMakeAbilityPermanent(hero, true, SPELLBOOK_PALADIN)
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

