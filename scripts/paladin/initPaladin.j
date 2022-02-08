include "common/spells.j"
include "scripts/paladin/consecration.j"
include "scripts/paladin/blessingOfKings.j"
include "scripts/paladin/blessingOfSanctuary.j"
include "scripts/paladin/blessingOfWisdom.j"
include "scripts/paladin/blessingOfMight.j"
include "scripts/paladin/judgementOfLight.j"
include "scripts/paladin/judgementOfWisdom.j"
include "scripts/paladin/shieldOfRighteousness.j"
include "scripts/paladin/avengersShield.j"

void InitTrig_Paladin()
{
    UnitAddAbility( PALADIN, DEVOTION_AURA )
    UnitAddAbility( PALADIN, DIVINE_SHIELD )
    UnitAddAbility( PALADIN, CONSECRATION )
    UnitAddAbility( PALADIN, CONSECRATION_TR )
    UnitAddAbility( PALADIN, HAMMER_RIGHTEOUS )
    UnitAddAbility( PALADIN, JUDGEMENT_OF_LIGHT_TR )
    UnitAddAbility( PALADIN, JUDGEMENT_OF_WISDOM_TR )
    UnitAddAbility( PALADIN, SHIELD_OF_RIGHTEOUSNESS )
    UnitAddAbility( PALADIN, AVENGERS_SHIELD )
    
    UnitAddAbility( PALADIN, SPELLBOOK_PALADIN )
    UnitMakeAbilityPermanent( PALADIN, true, SPELLBOOK_PALADIN )
    SetPlayerAbilityAvailable( Player(0), SPELLBOOK_PALADIN, true )
    
    Init_Consecration()
    Init_BlessingOfKings()
    Init_BlessingOfSanctuary()
    Init_BlessingOfWisdom()
    Init_BlessingOfMight()
    Init_JudgementOfLight()
    Init_JudgementOfWisdom()
    Init_ShieldOfRighteousness()
    Init_AvengersShield()
}

