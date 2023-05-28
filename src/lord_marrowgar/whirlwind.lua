-- Copyright (c) meiso

function LordMarrowgar.Whirlwind()
    local whirlwind_timer = Timer(GetRandomReal(20., 30.))
    local timer_reset = Timer(5.)

    local function reset_anim()
        if LordMarrowgar.whirlwind_effect then
            LordMarrowgar.whirlwind_effect = false
        end
        timer_reset:Destroy()
    end

    local function action()
        IssueImmediateOrder(LordMarrowgar.unit:GetId(), "whirlwind")
        timer_reset:SetFunc(reset_anim)
        timer_reset:Start()
        whirlwind_timer:Destroy()
    end

    if LordMarrowgar.whirlwind_effect then
        whirlwind_timer:SetFunc(action)
        whirlwind_timer:Start()
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
