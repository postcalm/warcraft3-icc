
include "common/spells.j"
include "libraries/Buff.j"

setdef SUFFIX_BUFF_NAME = BK
setdef HERO_COUNT = 1

INIT_BUFF_STRUCT()

void BlessingOfKings()
{   
    unit unit_s = GetSpellTargetUnit()
    int i = -1
    // note: в структуру не заносятся новые юниты!
    ADD_UNIT(unit_s)
    whilenot(i++ == HERO_COUNT)
    {
        if( GET_HERO(i) == null ) { break }
        if( !BUFF_ON_UNIT(i) )
        {
            SetHeroStr( unit_s, \
                        GetHeroStr( unit_s, false ) + R2I( GetHeroStr( unit_s, false ) * 0.1 ), false )
            SetHeroAgi( unit_s, \
                        GetHeroAgi( unit_s, false ) + R2I( GetHeroAgi( unit_s, false ) * 0.1 ), false )
            SetHeroInt( unit_s, \
                        GetHeroInt( unit_s, false ) + R2I( GetHeroInt( unit_s, false ) * 0.1 ), false )
            
            SET_BUFF_ON_UNIT(i)
            break
        }
    }
    unit_s = null
}

bool IsBlessingOfKings()
{
    return GetSpellAbilityId() == BLESSING_OF_KINGS 
}

void Init_BlessingOfKings()
{
    trigger trigger_buff = new trigger

    TriggerRegisterPlayerUnitEvent( trigger_buff, Player(0), EVENT_PLAYER_UNIT_SPELL_EFFECT, null )
    TriggerAddCondition( trigger_buff, function IsBlessingOfKings )
    TriggerAddAction( trigger_buff, function BlessingOfKings )
}
    
    