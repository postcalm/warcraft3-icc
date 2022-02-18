
include "libraries/Buff.j"

int COUNT_BW = 1
setdef SUFFIX_NAME = BW
setdef COUNT = 1
setdef SUFFIX_BUFF_NAME = BW

INIT_STRUCT_ITEMS()
INIT_BUFF_STRUCT()

void BlessingOfWisdom()
{
    unit unit_s = GetSpellTargetUnit()
    int i = 0
    ADD_UNIT(unit_s, COUNT_BW)

    String items_id = String.create("BLESSING_OF_WISDOM_ITEM")
    String items_spells_id = String.create("BLESSING_OF_WISDOM")
    FILL_STRUCT_ITEMS(items_id, items_spells_id)
    REGISTRATION_ITEMS()

    whilenot( i == COUNT_BW )
    {
        if( GET_HERO(i) == null ) { break }
        if( !BUFF_ON_UNIT(i) )
        {
            ADD_ITEMS_TO_UNIT(unit_s)
            SET_BUFF_ON_UNIT(i)
            COUNT_BW++
            break
        }
        i++
    }
    unit_s = null
}

bool IsBlessingOfWisdom()
{
    return GetSpellAbilityId() == BLESSING_OF_WISDOM 
}

void Init_BlessingOfWisdom()
{
    trigger trigger_buff = new trigger

    TriggerRegisterPlayerUnitEvent( trigger_buff, Player(0), EVENT_PLAYER_UNIT_SPELL_CAST, null )
    TriggerAddCondition( trigger_buff, function IsBlessingOfWisdom )
    TriggerAddAction( trigger_buff, function BlessingOfWisdom )
}
    
    