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
    trigger trigger_ability = new trigger

    TriggerRegisterPlayerUnitEvent( trigger_ability, Player(0), EVENT_PLAYER_UNIT_SPELL_CAST, null )
    TriggerAddCondition( trigger_ability, function IsConsecration )
    TriggerAddAction( trigger_ability, function Consecration )
}

