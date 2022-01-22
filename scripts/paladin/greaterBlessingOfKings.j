
// структурка
// требуется для фиксации бафа
struct HeroesWithGBK extends array
{
    unit hero  // id юнита
    bool onBuff  // есть баф или нет (true or false)
}

// если юнит дружественный
bool filter()
{
    return IsUnitAlly(GetTriggerUnit(), Player(0)) == true
}

// функция, проверяет наложен ли баф на игрока
bool BuffOnUnit(unit u, int count)
{
    int i = 0
    whilenot( i++ >= count )
    {
        if( HeroesWithGBK[i].hero == u ) { return true }
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
        // возвращает первого юнита в группе
        temp = FirstOfGroup(heroes)
        
        // если нам вернуло ребра, то удаляем его из группы
        // todo: исключать игрока из пати
        if( temp == LORD_MARROWGAR ) { GroupRemoveUnit( heroes, temp ) }
        
        // проверяем не наложен ли баф на юните
        if( GetUnitAbilityLevel( temp, BUFF_GBK) > 0 and !HeroesWithGBK[i].onBuff \
            and !BuffOnUnit( temp, countHeroes) )
        {
            // создаем структуру для текущего игрока
            // и заносим id юнита
            HeroesWithGBK[i].hero = temp
            
            // >> логика бафа <<
            // каждой характеристике даёт прибавку в 10%
            SetHeroStr( HeroesWithGBK[i].hero, GetHeroStr( HeroesWithGBK[i].hero, false ) + \
                                            R2I( GetHeroStr( HeroesWithGBK[i].hero, false ) * 0.1 ), false )
            SetHeroAgi( HeroesWithGBK[i].hero, GetHeroAgi( HeroesWithGBK[i].hero, false ) + \
                                            R2I( GetHeroAgi( HeroesWithGBK[i].hero, false ) * 0.1 ), false )
            SetHeroInt( HeroesWithGBK[i].hero, GetHeroInt( HeroesWithGBK[i].hero, false ) + \
                                            R2I( GetHeroInt( HeroesWithGBK[i].hero, false ) * 0.1 ), false )
            
            // отмечаем, что юнит получил баф
            HeroesWithGBK[i].onBuff = true
            // удаляем его из группы
            GroupRemoveUnit( heroes, HeroesWithGBK[i].hero )
        }
    }
    // чистим группу окончательно
    GroupClear(heroes)  
}

// проверка нажатой способности
bool IsGreaterBlessingOfKings()
{
    // GetSpellAbilityId вернет id нажатой способности
    return GetSpellAbilityId() == GREATER_BLESSING_KINGS 
}

// main
void Init_GreaterBlessingOfKings()
{
    // переменная, связываемая с событием
    trigger triggerGBKings = new trigger

    // регистриуем событие
    TriggerRegisterPlayerUnitEvent( triggerGBKings, Player(0), EVENT_PLAYER_UNIT_SPELL_CAST, null )
    // условие, при котором будет запущено действие (функция)
    TriggerAddCondition( triggerGBKings, function IsGreaterBlessingOfKings )
    // действие (функция), выполняемое после совершения события
    TriggerAddAction( triggerGBKings, function Actions )

    triggerGBKings = null
}
    
    