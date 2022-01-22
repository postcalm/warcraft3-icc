//

bool COLDFLAME_EXIST = false

// механика
void Coldflame_Actions()
{
    TriggerSleepAction( GetRandomReal( 2., 3. ) )
    
    unit coldflameObj = null
    unit randUnit = GetUnitInArea( GroupHeroesInArea() )
    
    float MarrowgarLocX = GetLocationX( GetUnitLoc(LORD_MARROWGAR) )
    float MarrowgarLocY = GetLocationY( GetUnitLoc(LORD_MARROWGAR) )
    
    float randUnitLocX = GetLocationX( GetUnitLoc(randUnit) )
    float randUnitLocY = GetLocationY( GetUnitLoc(randUnit) )
    
    // fix me
    location vector = GetVectorBetweenUnits( GetUnitLoc(LORD_MARROWGAR), GetUnitLoc(randUnit), true )
    location position = Location( randUnitLocX + GetLocationX(vector), \
                                  randUnitLocY + GetLocationY(vector) )
    
    if( COLDFLAME_EXIST )
    {
        // призываем дамми-юнита и направляем его в сторону игрока
        coldflameObj = new unit( GetTriggerPlayer(), DUMMY, MarrowgarLocX, MarrowgarLocY )
        
        SetUnitMoveSpeed( coldflameObj, 0.5 )
        SetUnitPathing( coldflameObj, false )
        IssuePointOrderLoc( coldflameObj, "move", position )
        
        // через 9 сек он должен умереть
        UnitApplyTimedLife( coldflameObj, COMMON_TIMER, 9. )
        
        while( true )
        {
            // другим дамми-юнитом кастуем flame strike иммитирующий coldflame 
            IssueTargetOrder( DUMMY_LM, "flamestrike", coldflameObj )
            TriggerSleepAction( 0.03 )
            if( GetUnitState( coldflameObj, UNIT_STATE_LIFE ) <= 0 ){ break }
        }
        
        COLDFLAME_EXIST = false
        coldflameObj = null
        randUnit = null
        position = null
    }
    
}

bool StartColdflame()
{
    if( !COLDFLAME_EXIST )
    {
        COLDFLAME_EXIST = true
        return COLDFLAME_EXIST
    }
    return false
}

// main
void InitTrig_Coldflame()
{
    trigger triggerAttacked = new trigger
    
    TriggerRegisterUnitEvent( triggerAttacked, LORD_MARROWGAR, EVENT_UNIT_ATTACKED )
    
    TriggerAddCondition( triggerAttacked, Condition( function StartColdflame ) )
    TriggerAddAction( triggerAttacked, function Coldflame_Actions )
    
    triggerAttacked = null
}

