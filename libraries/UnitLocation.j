
#guard UnitLocation

include "libraries/Maths.j"

// Библиотека для работы с расположением юнитов
library UnitLocation requires Maths
{
    group GroupHeroesInArea(rect area)
    {
        group groupHeroes = new group
        
        bj_groupEnumOwningPlayer = Player(0)
        GroupEnumUnitsInRect( groupHeroes, area, filterGetUnitsInRectOfPlayer )
        
        return groupHeroes
    }
    
    group GroupHeroesInRangeOnSpell(location loc, real radius, boolexpr expr)
    {
        group groupHeroes = new group
        
        bj_groupEnumOwningPlayer = Player(0)
        GroupEnumUnitsInRangeOfLoc( groupHeroes, loc, radius, expr )
        
        return groupHeroes
    }

    void RandomUnitEnum()
    {
        bj_groupRandomConsidered++
        if( GetRandomInt( 1, bj_groupRandomConsidered ) == 1 )
        {
            bj_groupRandomCurrentPick = GetEnumUnit()
        }
    }
    
    unit GetUnitInArea(group groupHeroes)
    {
        bj_groupRandomConsidered = 0
        bj_groupRandomCurrentPick = null
        
        ForGroup( groupHeroes, function RandomUnitEnum )
        
        DestroyGroup( groupHeroes )
        groupHeroes = null
        
        return bj_groupRandomCurrentPick
    }
    
    // возвращает вектор между двумя юнитами
    // возвращает либо "as is"
    // либо обработанный: наименьшая координата обнуляется, наибольшая - увеличивается
    location GetVectorBetweenUnits(location firstUnit, location secondUnit, bool process)
    {
        float vectorX = GetLocationX(secondUnit) - GetLocationX(firstUnit)
        float vectorY = GetLocationY(secondUnit) - GetLocationY(firstUnit)
        
        if( process )
        {
            if( Abs(vectorX) > 50. and Abs(vectorX) < 150. )
            {
                vectorX *= GetRandomReal( 5., 7. )
            }
            
            if( Abs(vectorY) > 50. and Abs(vectorY) < 150. )
            {
                vectorY *= GetRandomReal( 5., 7. )
            }
        }
        
        return Location( vectorX, vectorY )
    }
}
