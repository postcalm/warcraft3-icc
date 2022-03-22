
COLDFLAME_EXIST = false

function Coldflame()
    TriggerSleepAction(GetRandomReal(2., 3.))

    local which_player = GetOwningPlayer(GetAttacker())
    local target = GetUnitInArea(GroupHeroesInArea(gg_rct_areaLM, which_player))

    local lord_location = GetUnitLoc(LORD_MARROWGAR)
    local target_location = GetUnitLoc(target)

    if COLDFLAME_EXIST then
        -- призываем дамми-юнита и направляем его в сторону игрока
        local coldflame_obj = Unit:new(GetTriggerPlayer(), DYNAMIC_DUMMY, lord_location)

        SetUnitMoveSpeed(coldflame_obj, 0.6)
        SetUnitPathing(coldflame_obj, false)
        IssuePointOrderLoc(coldflame_obj, "move", target_location)

        -- через 9 сек дамми-юнит должен умереть
        UnitApplyTimedLife(coldflame_obj, COMMON_TIMER, 9.)

        while true do
            -- другим дамми-юнитом кастуем flame strike, иммитируя coldflame
            IssueTargetOrder(COLDFLAME_DUMMY, "flamestrike", coldflame_obj)
            TriggerSleepAction(0.03)
            if GetUnitState(coldflame_obj, UNIT_STATE_LIFE) <= 0 then break end
        end

        COLDFLAME_EXIST = false
    end
end

function StartColdflame()
    if not COLDFLAME_EXIST then
        COLDFLAME_EXIST = true
        return COLDFLAME_EXIST
    end
    return false
end

function Init_Coldflame()
    local trigger_ability = CreateTrigger()
    TriggerRegisterUnitEvent(trigger_ability, LORD_MARROWGAR, EVENT_UNIT_ATTACKED)
    TriggerAddCondition(trigger_ability, Condition(StartColdflame))
    TriggerAddAction(trigger_ability, Coldflame)
end
