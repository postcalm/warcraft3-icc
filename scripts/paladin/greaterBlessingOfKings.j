
struct HeroesWithGBK extends array
{
    // NOTE: здесь может быть утечка памяти!
    unit hero
    bool onBuff
}

bool filter()
{
    return IsUnitAlly(GetTriggerUnit(), Player(0)) == true
}

bool BuffOnUnit(unit u, int count)
{
    int i = -1
    whilenot( i++ >= count )
    {
        if( HeroesWithGBK[i].hero == u ) { return true }
    }
    return false
}

/*
void SetUnitBuff(int count)
{
    int i = -1
    UnitAddAbility( PALADIN, 'A00C' )
    whilenot( i++ >= count)
    {
        IssueImmediateOrder(HeroesWithGBK[i].hero, "roar")        
    }
    UnitRemoveAbility( PALADIN, 'A00C' )
}
*/
void ActionsBK()
{
    sBJDebugMsg("start")
    TriggerSleepAction( 0.5 )
    
    bj_groupCountUnits = 0
    int i = 0
    unit temp = null
    group heroes = GroupHeroesInRangeOnSpell( GetUnitLoc( GetTriggerUnit() ), 900., Condition( function filter ) )
    int countHeroes = CountUnitsInGroup(heroes)
    
    whilenot( i++ >= countHeroes )
    {
        temp = FirstOfGroup(heroes)

        // todo: исключать игрока из пати
        if( temp == LORD_MARROWGAR ) { GroupRemoveUnit( heroes, temp ) }

        if( !HeroesWithGBK[i].onBuff \
            and !BuffOnUnit( temp, countHeroes) )
        {
            HeroesWithGBK[i].hero = temp
            
            SetHeroStr( HeroesWithGBK[i].hero, GetHeroStr( HeroesWithGBK[i].hero, false ) + \
                                            R2I( GetHeroStr( HeroesWithGBK[i].hero, false ) * 0.1 ), false )
            SetHeroAgi( HeroesWithGBK[i].hero, GetHeroAgi( HeroesWithGBK[i].hero, false ) + \
                                            R2I( GetHeroAgi( HeroesWithGBK[i].hero, false ) * 0.1 ), false )
            SetHeroInt( HeroesWithGBK[i].hero, GetHeroInt( HeroesWithGBK[i].hero, false ) + \
                                            R2I( GetHeroInt( HeroesWithGBK[i].hero, false ) * 0.1 ), false )
            
            HeroesWithGBK[i].onBuff = true
            GroupRemoveUnit( heroes, HeroesWithGBK[i].hero )
        }
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
    TriggerAddAction( triggerGBKings, function ActionsBK )

    triggerGBKings = null
}
    
    