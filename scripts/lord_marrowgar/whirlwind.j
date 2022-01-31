
bool WHIRLWIND_EXIST = false
timer whirlwindTimer = new timer
timer timerReset = new timer

void ResetAnimation()
{
    if( WHIRLWIND_EXIST )
    {
        WHIRLWIND_EXIST = false
        whirlwindTimer = null
    }
}

void action()
{
    IssueImmediateOrder( LORD_MARROWGAR, "whirlwind" )
    TimerStart( timerReset, 5., false, function ResetAnimation )
    timerReset = null
}

void Whirlwind()
{
    if( WHIRLWIND_EXIST )
    {
        TimerStart( whirlwindTimer, GetRandomReal( 20., 30. ), false, function action )
    }
}

bool StartWhirlwind()
{
    if( !WHIRLWIND_EXIST )
    {
        WHIRLWIND_EXIST = true
        return WHIRLWIND_EXIST
    }
    return false
}

void Init_Whirlwind()
{
    trigger triggerAbility = new trigger
    
    TriggerRegisterUnitEvent( triggerAbility, LORD_MARROWGAR, EVENT_UNIT_ATTACKED )
    TriggerAddCondition( triggerAbility, Condition( function StartWhirlwind ) )
    TriggerAddAction( triggerAbility, function Whirlwind )
    
    triggerAbility = null
}

