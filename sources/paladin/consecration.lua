
function Consecration()
    IssuePointOrderLoc(GetTriggerUnit(), "flamestrike", GetUnitLoc(GetTriggerUnit()))
end

function IsConsecration()
    return GetSpellAbilityId() == CONSECRATION_TR
end

function Init_Consecration()
    local trigger_ability = CreateTrigger()
    TriggerRegisterPlayerUnitEvent(trigger_ability, Player(0), EVENT_PLAYER_UNIT_SPELL_CAST, nil)
    TriggerAddCondition(trigger_ability, Condition(IsConsecration))
    TriggerAddAction(trigger_ability, Consecration)
end
