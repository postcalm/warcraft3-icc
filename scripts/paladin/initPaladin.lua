
function Init_Paladin()
    local u = CreateUnit(Player(0), PALADIN, 3839.9, -2903.6, 90.000)
    PALADIN = u
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
    
    UnitAddAbility(PALADIN, SPELLBOOK_PALADIN)
    UnitMakeAbilityPermanent(PALADIN, true, SPELLBOOK_PALADIN)
    SetPlayerAbilityAvailable(Player(0), SPELLBOOK_PALADIN, true)
    
    Init_Consecration()
    Init_BlessingOfKings()
    Init_BlessingOfMight()
    Init_BlessingOfSanctuary()
    Init_BlessingOfWisdom()
    --Init_JudgementOfLight()
    --Init_JudgementOfWisdom()
    Init_ShieldOfRighteousness()
    --Init_AvengersShield()
end

