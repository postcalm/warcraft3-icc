-- Copyright (c) 2022 meiso

--- Сохраняет юнита игрока
---@return nil
function SaveSystem.SaveHero()
    SaveSystem.unit = SaveSystem.hero[GetConvertedPlayerId(GetTriggerPlayer())]
    SaveSystem.user_data[1] = 1
    SaveSystem.Save()
end

--- Инициализирует событие сохранения юнита
---@return nil
function SaveSystem.InitSaveEvent()
    local event = EventsPlayer()
    event:RegisterChatEvent("-save")
    event:AddAction(SaveSystem.SaveHero)
end