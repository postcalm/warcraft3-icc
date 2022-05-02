
function Paladin.Consecration()
    IssuePointOrderLoc(GetTriggerUnit(), "flamestrike", GetUnitLoc(GetTriggerUnit()))
end

function Paladin.IsConsecration()
    return GetSpellAbilityId() == CONSECRATION_TR
end


function Paladin.InitConsecration()
    local event = EventsPlayer(PLAYER_1)
    event:RegisterUnitSpellCast()
    event:AddCondition(Paladin.IsConsecration)
    event:AddAction(Paladin.Consecration)
end
