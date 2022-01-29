
#guard Hero

///
library Hero
{

    struct HeroWithBuffs extends array
    {
        unit hero
        string buffs
    }

    bool filter()
    {
        return IsUnitAlly(GetTriggerUnit(), Player(0)) == true
    }

    bool BuffOnHero(unit u, int count)
    {
        int i = -1
        whilenot( i++ >= count )
        {
            if( HeroesWithGBK[i].hero == u ) { return true }
        }
        return false
    }

    void RemoveEnemies(group heroes)
    {
        int i = -1
        unit temp = null
        int count = CountUnitsInGroup(heroes)
        whilenot(i++ == count - 1)
        {
            temp = FirstOfGroup(heroes)
            sBJDebugMsg("%h", temp)
            if( IsUnitEnemy( temp, Player(0) ) )
            {
                GroupRemoveUnit(heroes, temp)
            }
            else 
            {
                GroupRemoveUnit(heroes, temp)
                GroupAddUnit(heroes, temp)
            }
            temp = null
        }
    }
}
