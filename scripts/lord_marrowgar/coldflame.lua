
COLDFLAME_EXIST = false

function Coldflame()
    TriggerSleepAction(GetRandomReal(2., 3.))
    
    local which_player = GetOwningPlayer(GetAttacker())
    local randUnit = GetUnitInArea(GroupHeroesInArea(AREA_LM, which_player))
    
    local MarrowgarLocX = GetLocationX(GetUnitLoc(LORD_MARROWGAR))
    local MarrowgarLocY = GetLocationY(GetUnitLoc(LORD_MARROWGAR))

    local randUnitLocX = GetLocationX(GetUnitLoc(randUnit))
    local randUnitLocY = GetLocationY(GetUnitLoc(randUnit))

    local vector = GetVectorBetweenUnits(GetUnitLoc(LORD_MARROWGAR), GetUnitLoc(randUnit), true)
    local position = Location(randUnitLocX + GetLocationX(vector),
                              randUnitLocY + GetLocationY(vector))
    
    if COLDFLAME_EXIST then
        print("ok")
        -- призываем дамми-юнита и направляем его в сторону игрока
        local coldflameObj = CreateUnit(GetTriggerPlayer(), DUMMY, MarrowgarLocX, MarrowgarLocY, 0.)
        
        SetUnitMoveSpeed(coldflameObj, 0.5)
        SetUnitPathing(coldflameObj, false)
        IssuePointOrderLoc(coldflameObj, "move", position)
        
        -- через 9 сек дамми-юнит должен умереть
        print(COMMON_TIMER)
        UnitApplyTimedLife(coldflameObj, COMMON_TIMER, 9.)
        
        while true do
            print("this")
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

