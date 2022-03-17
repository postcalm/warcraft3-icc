
COLDFLAME_EXIST = false

function Coldflame()
    TriggerSleepAction(GetRandomReal(2., 3.))
    
    local which_player = GetOwningPlayer(GetAttacker())
    local randUnit = GetUnitInArea(GroupHeroesInArea(gg_rct_areaLM, which_player))
    
    local marrowgarLocX = GetLocationX(GetUnitLoc(LORD_MARROWGAR))
    local marrowgarLocY = GetLocationY(GetUnitLoc(LORD_MARROWGAR))
    local marrowgarPoints = Point:new(marrowgarLocX, marrowgarLocY)

    local randUnitLocX = GetLocationX(GetUnitLoc(randUnit))
    local randUnitLocY = GetLocationY(GetUnitLoc(randUnit))
    local randUnitPoints = Point:new(randUnitLocX, randUnitLocY)

    local distance = Line:new(marrowgarPoints, randUnitPoints)
    local position = {}

    if COLDFLAME_EXIST then
        local points = distance:getPoints(50)
        for i = 1, #points do
            position = Location(points[i][1], points[i][2])
            IssuePointOrderLoc(DUMMY_LM, "flamestrike", position)
            TriggerSleepAction(0.03)
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

