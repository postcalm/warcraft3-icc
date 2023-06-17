---@author meiso

--- Проверяет создан ли герой для игрока
---@return boolean
function SaveSystem.IsHeroNotCreated()
    if not SaveSystem.hero[GetConvertedPlayerId(GetTriggerPlayer())] then
        return true
    end
    return false
end
