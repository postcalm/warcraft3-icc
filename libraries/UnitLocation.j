
#guard UnitLocation

include "libraries/Maths.j"

// Библиотека для работы с расположением юнитов
library UnitLocation requires Maths
{
    group GroupHeroesInArea(rect area, player which_player)
    {
        group group_heroes = new group
        
        bj_groupEnumOwningPlayer = which_player
        GroupEnumUnitsInRect( group_heroes, area, filterGetUnitsInRectOfPlayer )
        
        return group_heroes
    }

    group GroupHeroesInRangeOnSpell(location loc, real radius, boolexpr expr, player which_player)
    {
        group group_heroes = new group
        
        bj_groupEnumOwningPlayer = which_player
        GroupEnumUnitsInRangeOfLoc( group_heroes, loc, radius, expr )
        
        return group_heroes
    }

    group GroupUnitsInRangeOfLocUnit(real radius, location which_location)
    {
        group g = new group
        GroupEnumUnitsInRangeOfLoc(g, which_location, radius, null)
        return g 
    }

    void RandomUnitEnum()
    {
        bj_groupRandomConsidered++
        if( GetRandomInt( 1, bj_groupRandomConsidered ) == 1 )
        {
            bj_groupRandomCurrentPick = GetEnumUnit()
        }
    }
    
    unit GetUnitInArea(group group_heroes)
    {
        bj_groupRandomConsidered = 0
        bj_groupRandomCurrentPick = null
        
        ForGroup( group_heroes, function RandomUnitEnum )
        
        DestroyGroup( group_heroes )
        group_heroes = null
        
        return bj_groupRandomCurrentPick
    }
    
    // возвращает вектор между двумя юнитами
    location GetVectorBetweenUnits(location first_unit, location second_unit, bool process)
    {
        float vector_x = GetLocationX(second_unit) - GetLocationX(first_unit)
        float vector_y = GetLocationY(second_unit) - GetLocationY(first_unit)

        if( process )
        {
            if( Abs(vector_x) > 50. and Abs(vector_x) < 150. )
            {
                vector_x *= GetRandomReal( 5., 7. )
            }
            if( Abs(vector_y) > 50. and Abs(vector_y) < 150. )
            {
                vector_y *= GetRandomReal( 5., 7. )
            }
        }
        return Location( vector_x, vector_y )
    }
}
