
struct HeroesWithGBS extends array
{
    // NOTE: здесь может быть утечка памяти!
    unit hero
    bool onBuff
}

// NOTE: дублируется!
//bool filter()
//{
    //return IsUnitAlly(GetTriggerUnit(), Player(0)) == true
//}

// NOTE: дублируется!
// функция, проверяет наложен ли баф на игрока
bool BuffOnUnitT(unit u, int count)
{
    int i = 0
    whilenot( i++ >= count )
    {
        if( HeroesWithGBS[i].hero == u ) { return true }
    }
    return false
}

// реализация способности
void Actions()
{
    // добавим маленькую задержку
    TriggerSleepAction( 0.5 )
    
    bj_groupCountUnits = 0
    // итератор для прохода по группе
    int i = 0
    // временная переменная, для проверки юнита
    unit temp = null
    // получаем всех игроков в области бафа
    group heroes = GroupHeroesInRangeOnSpell( GetUnitLoc( GetTriggerUnit() ), 900., Condition( function filter ) )
    // кол-во всех игроков
    int countHeroes = CountUnitsInGroup(heroes)
    
    // проходим по всем юнитам
    whilenot( i++ >= countHeroes )
    {
        temp = FirstOfGroup(heroes)
        
        // todo: исключать игрока из пати
        if( temp == LORD_MARROWGAR ) { GroupRemoveUnit( heroes, temp ) }
        
        if( !HeroesWithGBS[i].onBuff and !BuffOnUnitT( temp, countHeroes) )
        {
            HeroesWithGBS[i].hero = temp
            
            SetHeroStr( HeroesWithGBS[i].hero, GetHeroStr( HeroesWithGBS[i].hero, false ) + \
                                            R2I( GetHeroStr( HeroesWithGBS[i].hero, false ) * 0.5 ), false )
            SetHeroAgi( HeroesWithGBS[i].hero, GetHeroAgi( HeroesWithGBS[i].hero, false ) + \
                                            R2I( GetHeroAgi( HeroesWithGBS[i].hero, false ) * 0.1 ), false )
            SetHeroInt( HeroesWithGBS[i].hero, GetHeroInt( HeroesWithGBS[i].hero, false ) + \
                                            R2I( GetHeroInt( HeroesWithGBS[i].hero, false ) * 0.1 ), false )
            
            HeroesWithGBS[i].onBuff = true
            GroupRemoveUnit( heroes, HeroesWithGBS[i].hero )
        }
    }
    GroupClear(heroes)  
}

bool IsGreaterBlessingOfSanctuary()
{
    return GetSpellAbilityId() == GREATER_BLESSING_SANCTUARY 
}

void Init_GreaterBlessingOfSanctuary()
{
    trigger triggerGBSanctuary = new trigger

    TriggerRegisterPlayerUnitEvent( triggerGBSanctuary, Player(0), EVENT_PLAYER_UNIT_SPELL_CAST, null )
    TriggerAddCondition( triggerGBSanctuary, function IsGreaterBlessingOfSanctuary )
    TriggerAddAction( triggerGBSanctuary, function Actions )

    triggerGBSanctuary = null
}
    
    