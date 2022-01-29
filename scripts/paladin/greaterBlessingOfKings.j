
include "libraries/UnitLocation.j"
include "libraries/Hero.j"

struct HeroesWithGBK extends array
{
    // NOTE: здесь может быть утечка памяти!
    unit hero
    bool onBuff
}

bool BuffOnHeroGBK(unit u, int count)
{
    int i = -1
    whilenot( i++ >= count - 1 )
    {
        if( HeroesWithGBK[i].hero == u ) { return true }
    }
    return false
}

void GBK()
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

        if( !HeroesWithGBK[i].onBuff and !BuffOnHeroGBK( temp, countHeroes ) )
        {
            HeroesWithGBK[i].hero = temp
            
            SetHeroStr( HeroesWithGBK[i].hero, \
                        GetHeroStr( HeroesWithGBK[i].hero, false ) + \
                        R2I( GetHeroStr( HeroesWithGBK[i].hero, false ) * 0.1 ), false )
            SetHeroAgi( HeroesWithGBK[i].hero, \
                        GetHeroAgi( HeroesWithGBK[i].hero, false ) + \
                        R2I( GetHeroAgi( HeroesWithGBK[i].hero, false ) * 0.1 ), false )
            SetHeroInt( HeroesWithGBK[i].hero, \
                        GetHeroInt( HeroesWithGBK[i].hero, false ) + \
                        R2I( GetHeroInt( HeroesWithGBK[i].hero, false ) * 0.1 ), false )
            
            HeroesWithGBK[i].onBuff = true
            GroupRemoveUnit( heroes, HeroesWithGBK[i].hero )
        }
        temp = null
    }
    GroupClear(heroes)  
}

bool IsGreaterBlessingOfKings()
{
    return GetSpellAbilityId() == GREATER_BLESSING_KINGS 
}

void Init_GreaterBlessingOfKings()
{
    trigger triggerGBKings = new trigger

    TriggerRegisterPlayerUnitEvent( triggerGBKings, Player(0), EVENT_PLAYER_UNIT_SPELL_CAST, null )
    TriggerAddCondition( triggerGBKings, function IsGreaterBlessingOfKings )
    TriggerAddAction( triggerGBKings, function GBK )

    triggerGBKings = null
}
    
    