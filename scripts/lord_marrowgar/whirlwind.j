
bool WHIRLWIND_EXIST = false
timer whirlwind_timer = new timer
timer timer_reset = new timer

void ResetAnimation()
{
    if( WHIRLWIND_EXIST )
    {
        WHIRLWIND_EXIST = false
        whirlwind_timer = null
    }
}

void action()
{
    IssueImmediateOrder( LORD_MARROWGAR, "whirlwind" )
    TimerStart( timer_reset, 5., false, function ResetAnimation )
    timer_reset = null
}

void Whirlwind()
{
    if( WHIRLWIND_EXIST )
    {
        TimerStart( whirlwind_timer, GetRandomReal( 20., 30. ), false, function action )
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
    trigger trigger_ability = new trigger
    
    TriggerRegisterUnitEvent( trigger_ability, LORD_MARROWGAR, EVENT_UNIT_ATTACKED )
    TriggerAddCondition( trigger_ability, Condition( function StartWhirlwind ) )
    TriggerAddAction( trigger_ability, function Whirlwind )
}

