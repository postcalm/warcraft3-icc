
WHIRLWIND_EXIST = false

function ResetAnimation()
    if WHIRLWIND_EXIST then
        WHIRLWIND_EXIST = false
    end
    DestroyTimer(timer_reset)
end

function action()
    timer_reset = CreateTimer()
    IssueImmediateOrder(LORD_MARROWGAR, "whirlwind")
    TimerStart(timer_reset, 5., false, ResetAnimation)
    DestroyTimer(whirlwind_timer)
end

function Whirlwind()
    whirlwind_timer = CreateTimer()
    if WHIRLWIND_EXIST then
        TimerStart(whirlwind_timer, GetRandomReal(20., 30.), false, action)
    end
end

function StartWhirlwind()
    if not WHIRLWIND_EXIST then
        WHIRLWIND_EXIST = true
        return WHIRLWIND_EXIST
    end
    return false
end

function Init_Whirlwind()
    local event = EventsUnit(LORD_MARROWGAR)
    event:RegisterAttacked()
    event:AddCondition(StartWhirlwind)
    event:AddAction(Whirlwind)
end
