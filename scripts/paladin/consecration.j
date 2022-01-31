include "common/spells.j"

void Consecration()
{
    IssuePointOrderLoc( GetTriggerUnit(), "flamestrike", GetUnitLoc(GetTriggerUnit()) )
}

bool IsConsecration()
{
    return GetSpellAbilityId() == CONSECRATION_TR
}

void Init_Consecration()
{
    trigger triggerAbility = new trigger

    TriggerRegisterPlayerUnitEvent( triggerAbility, Player(0), EVENT_PLAYER_UNIT_SPELL_CAST, null )
    TriggerAddCondition( triggerAbility, function IsConsecration )
    TriggerAddAction( triggerAbility, function Consecration )

    triggerAbility = null
}

