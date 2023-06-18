---@author meiso

--- Загружает юнита
---@return nil
function SaveSystem.LoadHero()
    local i = GetConvertedPlayerId(GetTriggerPlayer())
    HeroSelector.Close()
    SaveSystem.Load()
    SaveSystem.hero[i] = SaveSystem.unit
    local class = GetUnitName(SaveSystem.unit):lower()
    if class == "priest" then
        Priest.Init(nil, SaveSystem.unit)
    elseif class == "paladin" then
        Paladin.Init(nil, SaveSystem.unit)
    end
end

--- Инициализация события по загрузке юнита
---@return nil
function SaveSystem.InitLoadEvent()
    local event = EventsPlayer()
    event:RegisterChatEvent("-load")
    event:AddCondition(SaveSystem.IsHeroNotCreated)
    event:AddAction(SaveSystem.LoadHero)
end
