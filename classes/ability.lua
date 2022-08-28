-- Copyright (c) meiso

--- Класс конфигурирования способностей
---@param ability ability Способность
---@param tooltip string Название способности
---@param text string Описание способности
Ability = {}
Ability.__index = Ability

setmetatable(Ability, {
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
    end,
})


function Ability:_init(ability, tooltip, text)
    self.ability = ability
    self.tooltip = tooltip
    self.text = text
    self:SetTooltip()
    self:SetText()
end

--- Установить название для способности
---@param tooltip string
---@return nil
function Ability:SetTooltip(tooltip)
    local t = tooltip or self.tooltip
    BlzSetAbilityTooltip(self.ability, t, 0)
end

--- Установить описание для способности
---@param text string
---@return nil
function Ability:SetText(text)
    local t = text or self.text
    BlzSetAbilityExtendedTooltip(self.ability, t, 0)
end

--- Вернуть идентификатор способности
---@return ability
function Ability:GetId()
    return self.ability
end
