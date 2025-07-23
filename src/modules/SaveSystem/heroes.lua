---@author Vlod www.xgm.ru
---@author meiso

--- Инициализирует выбранного героя
---@return nil
function SaveSystem.InitHero(class, name, player)
    SaveSystem.classid = CLASSES[class]
    local playerid = GetConvertedPlayerId(player)
    if SaveSystem.classid == CLASSES["paladin"] then
        Paladin.Init(nil, nil, name, player)
        SaveSystem.player_unit = Paladin.hero
        SaveSystem.hero[playerid] = Paladin.hero:GetId()
        SaveSystem.abilities = {}
    elseif SaveSystem.classid == CLASSES["priest"] then
        Priest.Init(nil, nil, name, player)
        SaveSystem.player_unit = Priest.hero
        SaveSystem.hero[playerid] = Priest.hero:GetId()
        SaveSystem.abilities = {}
    end
end
