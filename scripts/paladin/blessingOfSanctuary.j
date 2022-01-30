
include "libraries/Buff.j"
include "libraries/String.j"
include "libraries/EqSysWrapper.j"

setdef SUFFIX_NAME = BS
setdef COUNT = 1
setdef SUFFIX_BUFF_NAME = BS
setdef HERO_COUNT = 1

INIT_STRUCT_ITEMS()
INIT_BUFF_STRUCT()

void BlessingOfSanctuary()
{
    unit unit_s = GetSpellTargetUnit()
    int i = -1
    ADD_UNIT(unit_s)

    String items_id = String.create("DEC_DMG_ITEM")
    String items_spells_id = String.create("DECREASE_DMG")
    FILL_STRUCT_ITEMS(items_id, items_spells_id)
    REGISTRATION_ITEMS()
    
    whilenot( i++ == HERO_COUNT )
    {
        if( GET_HERO(i) == null ) { break }
        if( !BUFF_ON_UNIT(i) )
        {
            ADD_ITEMS_TO_UNIT(unit_s)
            SetHeroStr( unit_s, \
                        GetHeroStr( unit_s, false ) + R2I( GetHeroStr( unit_s, false ) * 0.1 ), false )
            SET_BUFF_ON_UNIT(i)
            break
        }
    }
    unit_s = null
}

bool IsBlessingOfSanctuary()
{
    return GetSpellAbilityId() == BLESSING_OF_SANCTUARY 
}

void Init_BlessingOfSanctuary()
{
    trigger triggerBuff = new trigger

    TriggerRegisterPlayerUnitEvent( triggerBuff, Player(0), EVENT_PLAYER_UNIT_SPELL_CAST, null )
    TriggerAddCondition( triggerBuff, function IsBlessingOfSanctuary )
    TriggerAddAction( triggerBuff, function BlessingOfSanctuary )

    triggerBuff = null
}
