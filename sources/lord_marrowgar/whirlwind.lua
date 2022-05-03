
function LordMarrowgar.ResetAnimation()
    if LordMarrowgar.whirlwind_effect then
        LordMarrowgar.whirlwind_effect = false
    end
    DestroyTimer(GetExpiredTimer())
end

function LordMarrowgar.Whirlwind()
    local whirlwind_timer = CreateTimer()

    local function action()
        local timer_reset = CreateTimer()
        IssueImmediateOrder(LordMarrowgar.unit, "whirlwind")
        TimerStart(timer_reset, 5., false, LordMarrowgar.ResetAnimation)
        DestroyTimer(whirlwind_timer)
    end

    if LordMarrowgar.whirlwind_effect then
        TimerStart(whirlwind_timer, GetRandomReal(20., 30.), false, action)
    end
end

function LordMarrowgar.StartWhirlwind()
    if not LordMarrowgar.whirlwind_effect then
        LordMarrowgar.whirlwind_effect = true
        return true
    end
    return false
end

function LordMarrowgar.InitWhirlwind()
    local event = EventsUnit(LordMarrowgar.unit)
    event:RegisterAttacked()
    event:AddCondition(LordMarrowgar.StartWhirlwind)
    event:AddAction(LordMarrowgar.Whirlwind)
end
