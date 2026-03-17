---@author meiso

---@class Player Класс игрока
---@param playerid player Id игрока
CPlayer = {}
CPlayer.__index = CPlayer

setmetatable(CPlayer, {
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
    end,
})

---@private
function CPlayer:_init(playerid)
    self.player = playerid
end

--- Установить уровень для технологии
---@param tech integer Id технологии
---@param level integer Уровень технологии
function CPlayer:SetTechResearched(tech, level)
    SetPlayerTechResearched(self.player, tech, level)
end

--- Получить текущий уровень технологии
---@param tech integer Id технологии
---@return integer
function CPlayer:GetTechCount(tech)
    return GetPlayerTechCountSimple(tech, self.player)
end

--- Получить id игрока
---@return player
function CPlayer:GetId()
    return self.player
end
