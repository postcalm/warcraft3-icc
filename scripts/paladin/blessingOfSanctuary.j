
include "libraries/Buff.j"
include "libraries/String.j"
include "libraries/EqSysWrapper.j"

int COUNT_BS = 1
setdef SUFFIX_NAME = BS
setdef COUNT = 1
setdef SUFFIX_BUFF_NAME = BS

INIT_STRUCT_ITEMS()
INIT_BUFF_STRUCT()

void BlessingOfSanctuary()
{
    unit unit_s = GetSpellTargetUnit()
    int i = 0
    ADD_UNIT(unit_s, COUNT_BS)

    String items_id = String.create("DEC_DMG_ITEM")
    String items_spells_id = String.create("DECREASE_DMG")
    FILL_STRUCT_ITEMS(items_id, items_spells_id)
    REGISTRATION_ITEMS()
    
    whilenot( i == COUNT_BS )
    {
        if( GET_HERO(i) == null ) { break }
        if( !BUFF_ON_UNIT(i) )
        {
            ADD_ITEMS_TO_UNIT(unit_s)
            SetHeroStr( unit_s, \
                        GetHeroStr( unit_s, false ) + R2I( GetHeroStr( unit_s, false ) * 0.1 ), false )
            SET_BUFF_ON_UNIT(i)
            COUNT_BS++
            break
        }
        i++
    }
    unit_s = null
}

bool IsBlessingOfSanctuary()
{
    return GetSpellAbilityId() == BLESSING_OF_SANCTUARY 
}

void Init_BlessingOfSanctuary()
{
    trigger trigger_buff = new trigger

    TriggerRegisterPlayerUnitEvent( trigger_buff, Player(0), EVENT_PLAYER_UNIT_SPELL_CAST, null )
    TriggerAddCondition( trigger_buff, function IsBlessingOfSanctuary )
    TriggerAddAction( trigger_buff, function BlessingOfSanctuary )
}
