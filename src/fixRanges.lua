---@author meiso

function FixRangesHeroes()
    local event_enter = Events()
    local event_leave = Events()

    -- TODO: если на арене помимо босса есть другие мобы,
    --  тогда если хотя бы один игрок в бою с боссом, то выдавать улучшение всем

    local function set_range(range)
        local unit = Unit(GetTriggerUnit())
        local owner
        if unit:IsHero() then
            owner = CPlayer(unit:GetOwner())
            owner:SetTechResearched(UPGRADES.ADD_RANGE, range)
            print(owner:GetTechCount(UPGRADES.ADD_RANGE))
        end
    end

    event_enter:RegisterEnterRect(AREAS.LORD_MARROW_ARENA)
    event_enter:AddAction(function() set_range(2) end)

    event_leave:RegisterLeaveRect(AREAS.LORD_MARROW_ARENA)
    event_leave:AddAction(function() set_range(0) end)
end
