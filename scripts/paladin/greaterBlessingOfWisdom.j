
include "libraries/UnitLocation.j"
include "libraries/Hero.j"

struct HeroesWithGBW extends array
{
    // NOTE: здесь может быть утечка памяти!
    unit hero
    bool onBuff
}

bool BuffOnHeroGBW(unit u, int count)
{
    int i = -1
    whilenot( i++ >= count - 1 )
    {
        if( HeroesWithGBW[i].hero == u ) { return true }
    }
    return false
}

void GBW()
{
    TriggerSleepAction( 0.5 )
    
    bj_groupCountUnits = 0
    int i = -1
    unit temp = null
    group heroes = GroupHeroesInRangeOnSpell( GetUnitLoc( GetTriggerUnit() ), 900., null )
    RemoveEnemies(heroes)
    int countHeroes = CountUnitsInGroup(heroes)

    whilenot( i++ >= countHeroes - 1 )
    {
        temp = FirstOfGroup(heroes)

        if( !HeroesWithGBW[i].onBuff and !BuffOnHeroGBW( temp, countHeroes ) )
        {
            HeroesWithGBW[i].hero = temp
            
            HeroesWithGBW[i].onBuff = true
            GroupRemoveUnit( heroes, HeroesWithGBW[i].hero )
        }
        temp = null
    }
    GroupClear(heroes)  
}

bool IsGreaterBlessingOfWisdom()
{
    return GetSpellAbilityId() == GREATER_BLESSING_WISDOM_TR 
}

void Init_GreaterBlessingOfWisdom()
{
    trigger triggerGBWisdom = new trigger

    TriggerRegisterPlayerUnitEvent( triggerGBWisdom, Player(0), EVENT_PLAYER_UNIT_SPELL_CAST, null )
    TriggerAddCondition( triggerGBWisdom, function IsGreaterBlessingOfWisdom )
    TriggerAddAction( triggerGBWisdom, function GBW )

    triggerGBWisdom = null
}
    
    