---@author meiso

--- Возрождает юнита
---@return nil
function UnitsRespawn()
    local unit = Unit(GetTriggerUnit())
    if unit:IsHero() and unit:GetOwner() ~= LICH_KING then
        -- откладываем воскрешение, если активен бой
        while GlobalCombatSystem.active do
            TriggerSleepAction(2.5)
        end
        unit:Revive(GetRandomLocInRect(gg_rct_StartSpawn))
    end
end
