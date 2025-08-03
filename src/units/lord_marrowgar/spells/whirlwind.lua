---@author meiso

function LordMarrowgar.Whirlwind()
    local spell_anim = "Attack Walk Stand Spin" -- 16
    local start_time = GetRandomInt(20, 30)
    local duration = 5.
    -- физ. урон сильно режется бронёй, хотя у этой абилки такого не должно быть
    local damage = 6000
    -- время анимации см. в редакторе WE
    local animate = Timer(0.267)
    animate:EnablePeriodic()
    animate:SetFunc(function()
        LordMarrowgar.unit:SetAnimation { tag = spell_anim }
    end)

    if not LordMarrowgar.whirlwind_effect then
        return
    end

    LordMarrowgar.whirlwind_effect = true

    TriggerSleepAction(start_time)
    animate:Start()

    while duration > 0 do
        print(duration)
        TriggerSleepAction(1.)
        LordMarrowgar.unit:DealPhysicalDamageLoc {
            damage = damage,
            location = LordMarrowgar.unit:GetLoc(),
            radius = 15.
        }
        duration = duration - 1
    end

    LordMarrowgar.whirlwind_effect = false
    animate:Pause()

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
