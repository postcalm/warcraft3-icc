
include "libraries/UnitLocation.j"
include "libraries/Hero.j"

setdef SUFFIX_NAME = GBS
setdef COUNT = 1
INIT_STRUCT_ITEMS()

struct HeroesWithGBS extends array
{
    // NOTE: здесь может быть утечка памяти!
    unit hero
    bool onBuff
}

void GBS()
{
    TriggerSleepAction( 0.5 )
    
    bj_groupCountUnits = 0
    int i = -1
    unit temp = null
    group heroes = GroupHeroesInRangeOnSpell( GetUnitLoc( GetTriggerUnit() ), 900., null )
    RemoveEnemies(heroes)
    int countHeroes = CountUnitsInGroup(heroes)
    
    String items_id = String.create("DEC_DMG_ITEM")
    String items_spells_id = String.create("DECREASE_DMG")
    FILL_STRUCT_ITEMS(items_id, items_spells_id)
    REGISTRATION_ITEMS()
    
    whilenot( i++ >= countHeroes - 1  )
    {
        temp = FirstOfGroup(heroes)

        if( !HeroesWithGBS[i].onBuff and !BuffOnHero( temp, countHeroes) )
        {
            HeroesWithGBS[i].hero = temp

            ADD_ITEMS_TO_UNIT(HeroesWithGBS[i].hero)
            SetHeroStr( HeroesWithGBS[i].hero, \
                        GetHeroStr( HeroesWithGBS[i].hero, false ) + \
                        R2I( GetHeroStr( HeroesWithGBS[i].hero, false ) * 0.1 ), false )
            
            HeroesWithGBS[i].onBuff = true
            GroupRemoveUnit( heroes, HeroesWithGBS[i].hero )
        }
        temp = null
    }
    GroupClear(heroes)  
}

bool IsGreaterBlessingOfSanctuary()
{
    return GetSpellAbilityId() == GREATER_BLESSING_SANCTUARY 
}

void Init_GreaterBlessingOfSanctuary()
{
    trigger triggerGBSanctuary = new trigger

    TriggerRegisterPlayerUnitEvent( triggerGBSanctuary, Player(0), EVENT_PLAYER_UNIT_SPELL_CAST, null )
    TriggerAddCondition( triggerGBSanctuary, function IsGreaterBlessingOfSanctuary )
    TriggerAddAction( triggerGBSanctuary, function GBS )

    triggerGBSanctuary = null
}
    
    