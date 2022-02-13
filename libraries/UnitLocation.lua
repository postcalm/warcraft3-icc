
--Библиотека для работы с расположением юнитов

local function abs(number)
    if number >= 0 then
        return number
    end
    return number * -1
end

function GroupHeroesInArea(area, which_player)
    local group_heroes = CreateGroup()
    bj_groupEnumOwningPlayer = which_player
    GroupEnumUnitsInRect( group_heroes, area, filterGetUnitsInRectOfPlayer )
    return group_heroes
end

function GroupHeroesInRangeOnSpell(loc, radius, expr, which_player)
    local group_heroes = CreateGroup()
    bj_groupEnumOwningPlayer = which_player
    GroupEnumUnitsInRangeOfLoc( group_heroes, loc, radius, expr )
    return group_heroes
end

function GroupUnitsInRangeOfLocUnit(radius, which_location)
    local group_heroes = CreateGroup()
    GroupEnumUnitsInRangeOfLoc(group_heroes, which_location, radius, nil)
    return group_heroes
end

function RandomUnitEnum()
    bj_groupRandomConsidered = bj_groupRandomConsidered + 1
    if GetRandomInt( 1, bj_groupRandomConsidered ) == 1 then
        bj_groupRandomCurrentPick = GetEnumUnit()
    end
end

function GetUnitInArea(group_heroes)
    bj_groupRandomConsidered = 0
    bj_groupRandomCurrentPick = nil

    ForGroup( group_heroes, RandomUnitEnum() )
    DestroyGroup( group_heroes )

    return bj_groupRandomCurrentPick
end

--возвращает вектор между двумя юнитами
function GetVectorBetweenUnits(first_unit, second_unit, process)
    local vector_x = GetLocationX(second_unit) - GetLocationX(first_unit)
    local vector_y = GetLocationY(second_unit) - GetLocationY(first_unit)

    if process then
        if abs(vector_x) > 50 and abs(vector_x) < 150 then
            vector_x = vector_x * GetRandomReal( 5, 7 )
        end
        if abs(vector_y) > 50 and abs(vector_y) < 150 then
            vector_y = vector_x * GetRandomReal( 5, 7 )
        end
    end
    return Location( vector_x, vector_y )
end