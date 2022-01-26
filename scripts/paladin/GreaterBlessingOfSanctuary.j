
// структурка
// требуется для фиксации бафа
struct HeroesWithGBS extends array
{
    // NOTE: здесь может быть утечка памяти!
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
        // возвращает первого юнита в группе
        temp = FirstOfGroup(heroes)
        
        // если нам вернуло ребра, то удаляем его из группы
        // todo: исключать игрока из пати
        if( temp == LORD_MARROWGAR ) { GroupRemoveUnit( heroes, temp ) }
        
        // проверяем не наложен ли баф на юните
        if( GetUnitAbilityLevel( temp, BUFF_GBS) > 0 and !HeroesWithGBS[i].onBuff \
            and !BuffOnUnit( temp, countHeroes) )
        {
            // создаем структуру для текущего игрока
            // и заносим id юнита
            HeroesWithGBS[i].hero = temp
            
            // >> логика бафа <<
            // каждой характеристике даёт прибавку в 10%
            SetHeroStr( HeroesWithGBS[i].hero, GetHeroStr( HeroesWithGBS[i].hero, false ) + \
                                            R2I( GetHeroStr( HeroesWithGBS[i].hero, false ) * 100 ), false )
            SetHeroAgi( HeroesWithGBS[i].hero, GetHeroAgi( HeroesWithGBS[i].hero, false ) + \
                                            R2I( GetHeroAgi( HeroesWithGBS[i].hero, false ) * 0.1 ), false )
            SetHeroInt( HeroesWithGBS[i].hero, GetHeroInt( HeroesWithGBS[i].hero, false ) + \
                                            R2I( GetHeroInt( HeroesWithGBS[i].hero, false ) * 0.1 ), false )
            
            // отмечаем, что юнит получил баф
            HeroesWithGBS[i].onBuff = true
            // удаляем его из группы
            GroupRemoveUnit( heroes, HeroesWithGBS[i].hero )
        }
    }
    // чистим группу окончательно
    GroupClear(heroes)  
}

// проверка нажатой способности
bool IsGreaterBlessingOfSanctuary()
{
    // GetSpellAbilityId вернет id нажатой способности
    return GetSpellAbilityId() == GREATER_BLESSING_SANCTUARY 
}

// main
void Init_GreaterBlessingOfSanctuary()
{
    // переменная, связываемая с событием
    trigger triggerGBSanctuary = new trigger

    // регистриуем событие
    TriggerRegisterPlayerUnitEvent( triggerGBSanctuary, Player(0), EVENT_PLAYER_UNIT_SPELL_CAST, null )
    // условие, при котором будет запущено действие (функция)
    TriggerAddCondition( triggerGBSanctuary, function IsGreaterBlessingOfSanctuary )
    // действие (функция), выполняемое после совершения события
    TriggerAddAction( triggerGBSanctuary, function Actions )

    triggerGBSanctuary = null
}
    
    