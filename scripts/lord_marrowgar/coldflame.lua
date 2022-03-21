
COLDFLAME_EXIST = false

function Coldflame()
    TriggerSleepAction(GetRandomReal(2., 3.))

    local which_player = GetOwningPlayer(GetAttacker())
    local randUnit = GetUnitInArea(GroupHeroesInArea(gg_rct_areaLM, which_player))

    local MarrowgarLocX = GetLocationX(GetUnitLoc(LORD_MARROWGAR))
    local MarrowgarLocY = GetLocationY(GetUnitLoc(LORD_MARROWGAR))

    if COLDFLAME_EXIST then
        -- призываем дамми-юнита и направляем его в сторону игрока
        local coldflameObj = CreateUnit(GetTriggerPlayer(), DYNAMIC_DUMMY, MarrowgarLocX, MarrowgarLocY, 0.)

        SetUnitMoveSpeed(coldflameObj, 0.6)
        SetUnitPathing(coldflameObj, false)
        IssueTargetOrder(coldflameObj, "move", randUnit)

        -- через 9 сек дамми-юнит должен умереть
        UnitApplyTimedLife(coldflameObj, COMMON_TIMER, 9.)

        while true do
            -- другим дамми-юнитом кастуем flame strike, иммитируя coldflame
            IssueTargetOrder(DUMMY_LM, "flamestrike", coldflameObj)
            TriggerSleepAction(0.03)
            if GetUnitState(coldflameObj, UNIT_STATE_LIFE) <= 0 then break end
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
    local triggerAbility = CreateTrigger()
    TriggerRegisterUnitEvent(triggerAbility, LORD_MARROWGAR, EVENT_UNIT_ATTACKED)
    TriggerAddCondition(triggerAbility, Condition(StartColdflame))
    TriggerAddAction(triggerAbility, Coldflame)
end
