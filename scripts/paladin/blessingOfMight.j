
include "libraries/Buff.j"

int COUNT_BM = 1
setdef SUFFIX_BUFF_NAME = BM

INIT_BUFF_STRUCT()

void BlessingOfMight()
{
    unit unit_s = GetSpellTargetUnit()
    int i = 0
    ADD_UNIT(unit_s, COUNT_BM)

    whilenot( i == COUNT_BM )
    {
        if( GET_HERO(i) == null ) { break }
        if( !BUFF_ON_UNIT(i) )
        {
            // fixme: увеличивать урон напрямую (3.5 AP = 1 ед. урона)
            SetHeroStr( unit_s, \
                        GetHeroStr( unit_s, false ) + 225, false )
            SET_BUFF_ON_UNIT(i)
            COUNT_BM++
            break
        }
        i++
    }
    unit_s = null
}

bool IsBlessingOfMight()
{
    return GetSpellAbilityId() == BLESSING_OF_MIGHT 
}

void Init_BlessingOfMight()
{
    trigger trigger_buff = new trigger

    TriggerRegisterPlayerUnitEvent( trigger_buff, Player(0), EVENT_PLAYER_UNIT_SPELL_CAST, null )
    TriggerAddCondition( trigger_buff, function IsBlessingOfMight )
    TriggerAddAction( trigger_buff, function BlessingOfMight )
}
    
    