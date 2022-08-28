-- Copyright (c) meiso

--- Проверяет создан ли герой для игрока
---@return boolean
function SaveSystem.IsHeroNotCreated()
    if not udg_My_hero[GetConvertedPlayerId(GetTriggerPlayer())] then
        return true
    end
    return false
end
