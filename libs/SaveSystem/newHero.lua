-- Copyright (c) 2022 meiso

--- Добавляет нового юнита игроку
---@return nil
function SaveSystem.AddNewHero()
    local text = GetEventPlayerChatString()
    local unit
    local playerid = GetConvertedPlayerId(GetTriggerPlayer())
    if text:find("paladin") then
        unit = Unit(GetTriggerPlayer(), PALADIN, GetRectCenter(gg_rct_RespawZone), GetRandomDirectionDeg())
        udg_My_hero[playerid] = unit:GetId()
        SaveSystem.AddHeroAbilities("paladin")
    elseif text:find("priest") then
        unit = Unit(GetTriggerPlayer(), PRIEST, GetRectCenter(gg_rct_RespawZone), GetRandomDirectionDeg())
        udg_My_hero[playerid] = unit:GetId()
        SaveSystem.AddHeroAbilities("priest")
    end
end

--- Инициализирует событие выдачи юнита игроку
---@return nil
function SaveSystem.InitNewHeroEvent()
    local event = EventsPlayer()
    event:RegisterChatEvent("-new")
    event:AddCondition(SaveSystem.IsHeroNotCreated)
    event:AddAction(SaveSystem.AddNewHero)
end
