---@author Vlod www.xgm.ru
---@author meiso

--- Возрождает юнита
---@return nil
function SaveSystem.UnitsRespawn()
    local unit = Unit(GetTriggerUnit())
    if unit:IsHero() then
        TriggerSleepAction(5)
        unit:Revive()
    end
end

--- Инициализирует выбранного героя
---@return nil
function SaveSystem.InitHero(class)
    SaveSystem.classid = CLASSES[class]
    local playerid = GetConvertedPlayerId(GetTriggerPlayer())
    local loc = Location(-60., -750.)
    if SaveSystem.classid == CLASSES["paladin"] then
        Paladin.Init(loc)
        SaveSystem.hero[playerid] = Paladin.hero:GetId()
        SaveSystem.abilities = {}
    elseif SaveSystem.classid == CLASSES["priest"] then
        Priest.Init(loc)
        SaveSystem.hero[playerid] = Priest.hero:GetId()
        SaveSystem.abilities = {}
    end
end
