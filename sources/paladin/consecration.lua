
function Paladin.InitConsecration()
    local event = EventsPlayer(PLAYER_1)
    event:RegisterUnitSpellCast()

    local function Consecration()
        IssuePointOrderLoc(GetTriggerUnit(), "flamestrike", GetUnitLoc(GetTriggerUnit()))
    end

    local function IsConsecration()
        return GetSpellAbilityId() == CONSECRATION_TR
    end

    event:AddCondition(IsConsecration)
    event:AddAction(Consecration)
end
