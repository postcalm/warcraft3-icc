-- Copyright (c) 2022 meiso

--- Загружает юнита
---@return nil
function SaveSystem.LoadHero()
    local i = GetConvertedPlayerId(GetTriggerPlayer())
    SaveSystem.Load()
    udg_My_hero[i] = SaveSystem.unit
end

--- Инициализация события по загрузке юнита
---@return nil
function SaveSystem.InitLoadEvent()
    local event = EventsPlayer()
    event:RegisterChatEvent("-load")
    event:AddCondition(SaveSystem.IsHeroNotCreated)
    event:AddAction(SaveSystem.LoadHero)
end
