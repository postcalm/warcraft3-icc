

void Action()
{
    IssuePointOrderLoc( GetTriggerUnit(), "flamestrike", GetUnitLoc(GetTriggerUnit()) )
}

bool IsConsecration()
{
    return GetSpellAbilityId() == CONSECRATION_TR
}

void Init_Consecration()
{
    trigger triggerConsecration = new trigger

    TriggerRegisterPlayerUnitEvent( triggerConsecration, Player(0), EVENT_PLAYER_UNIT_SPELL_CAST, null )
    TriggerAddCondition( triggerConsecration, function IsConsecration )
    TriggerAddAction( triggerConsecration, function Action )

    triggerConsecration = null
}

