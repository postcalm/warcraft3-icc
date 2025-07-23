---@author meiso

--- Возрождает юнита
---@return nil
function UnitsRespawn()
    local unit = Unit(GetTriggerUnit())
    if unit:IsHero() and unit:GetOwner() ~= LICH_KING then
        TriggerSleepAction(5.)
        unit:Revive(GetRandomLocInRect(gg_rct_StartSpawn))
    end
end

function EnemiesReset()

end
