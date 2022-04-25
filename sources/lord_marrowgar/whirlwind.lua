
WHIRLWIND_EXIST = false

function ResetAnimation()
    if WHIRLWIND_EXIST then
        WHIRLWIND_EXIST = false
    end
    DestroyTimer(GetExpiredTimer())
end

function Whirlwind()
    local whirlwind_timer = CreateTimer()

    local function action()
        local timer_reset = CreateTimer()
        IssueImmediateOrder(LORD_MARROWGAR, "whirlwind")
        TimerStart(timer_reset, 5., false, ResetAnimation)
        DestroyTimer(whirlwind_timer)
    end

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
