---@author meiso

--- Добавляет нового юнита игроку
---@return nil
function SaveSystem.AddNewHero()
    local text = GetEventPlayerChatString()
    local unit
    local playerid = GetConvertedPlayerId(GetTriggerPlayer())
    if text:find("paladin") then
        unit = Unit(GetTriggerPlayer(), PALADIN, GetRectCenter(gg_rct_RespawZone))
        SaveSystem.hero[playerid] = unit:GetId()
        SaveSystem.InitHero("paladin")
    elseif text:find("priest") then
        unit = Unit(GetTriggerPlayer(), PRIEST, GetRectCenter(gg_rct_RespawZone))
        SaveSystem.hero[playerid] = unit:GetId()
        SaveSystem.InitHero("priest")
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
