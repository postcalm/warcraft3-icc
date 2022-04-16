
function Init_Paladin()
    local items_list = {"ARMOR_ITEM", "ATTACK_ITEM", "HP_ITEM"}
    local items_spells_list = {"ARMOR_500", "ATTACK_1500", "HP_90K"}
    PALADIN = Unit:new(Player(0), PALADIN, Location(3800., 200.), 90.)

    --EquipSystem.RegisterItems(items_list, items_spells_list)
    --EquipSystem.AddItemsToUnit(PALADIN, items_list)

    SetHeroLevel(PALADIN, 80, false)
    SetUnitState(PALADIN, UNIT_STATE_MANA, 800)

    UnitAddAbility(PALADIN, DEVOTION_AURA)
    UnitAddAbility(PALADIN, DIVINE_SHIELD)
    UnitAddAbility(PALADIN, CONSECRATION)
    UnitAddAbility(PALADIN, CONSECRATION_TR)
    UnitAddAbility(PALADIN, HAMMER_RIGHTEOUS)
    UnitAddAbility(PALADIN, JUDGEMENT_OF_LIGHT_TR)
    UnitAddAbility(PALADIN, JUDGEMENT_OF_WISDOM_TR)
    UnitAddAbility(PALADIN, SHIELD_OF_RIGHTEOUSNESS)
    UnitAddAbility(PALADIN, AVENGERS_SHIELD)

    --даём паладину книжку с бафами и пассивками
    UnitAddAbility(PALADIN, SPELLBOOK_PALADIN)
    UnitMakeAbilityPermanent(PALADIN, true, SPELLBOOK_PALADIN)
    SetPlayerAbilityAvailable(Player(0), SPELLBOOK_PALADIN, true)
    
    Init_Consecration()
    Init_BlessingOfKings()
    Init_BlessingOfMight()
    Init_BlessingOfSanctuary()
    Init_BlessingOfWisdom()
    Init_JudgementOfLight()
    Init_JudgementOfWisdom()
    Init_ShieldOfRighteousness()
    Init_AvengersShield()
end

