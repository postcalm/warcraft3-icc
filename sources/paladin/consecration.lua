
function Consecration()
    IssuePointOrderLoc(GetTriggerUnit(), "flamestrike", GetUnitLoc(GetTriggerUnit()))
end

function IsConsecration()
    return GetSpellAbilityId() == CONSECRATION_TR
end

function Init_Consecration()
    local event = EventsPlayer(Player(0))
    event:RegisterUnitSpellCast()
    event:AddCondition(IsConsecration)
    event:AddAction(Consecration)
end
