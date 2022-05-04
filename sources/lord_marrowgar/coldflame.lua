
function LordMarrowgar.Coldflame()
    TriggerSleepAction(GetRandomReal(2., 3.))

    local target = GetUnitInArea(GroupHeroesInArea(gg_rct_areaLM, GetOwningPlayer(GetAttacker())))

    local lord_location = GetUnitLoc(LordMarrowgar.unit:GetUnit())
    local target_location = GetUnitLoc(target)

    if LordMarrowgar.coldflame_effect then
        -- призываем дамми-юнита и направляем его в сторону игрока
        local coldflame_obj = Unit(GetTriggerPlayer(), DUMMY, lord_location):GetUnit()

        SetUnitMoveSpeed(coldflame_obj, 0.6)
        SetUnitPathing(coldflame_obj, false)
        IssuePointOrderLoc(coldflame_obj, "move", target_location)

        -- через 9 сек дамми-юнит должен умереть
        UnitApplyTimedLife(coldflame_obj, COMMON_TIMER, 9.)

        while true do
            -- другим дамми-юнитом кастуем flame strike, иммитируя coldflame
            IssueTargetOrder(LordMarrowgar.coldflame, "flamestrike", coldflame_obj)
            TriggerSleepAction(0.03)
            if GetUnitState(coldflame_obj, UNIT_STATE_LIFE) <= 0 then break end
        end

        LordMarrowgar.coldflame_effect = false
    end
end

function LordMarrowgar.StartColdflame()
    if not LordMarrowgar.coldflame_effect then
        LordMarrowgar.coldflame_effect = true
        return true
    end
    return false
end

function LordMarrowgar.InitColdflame()
    local event = EventsUnit(LordMarrowgar.unit:GetUnit())
    event:RegisterAttacked()
    event:AddCondition(LordMarrowgar.StartColdflame)
    event:AddAction(LordMarrowgar.Coldflame)
end
