-- Copyright (c) meiso

--- Класс конфигурирования способностей
---@param ability ability Способность
---@param tooltip string Название способности
---@param text string Описание способности
---@param icon string Иконка
---@param key string Кнопка использования
---@param buff_tooltip string Название бафа
---@param buff_desc string Описание бафа
Ability = {}
Ability.__index = Ability

setmetatable(Ability, {
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
    end,
})

--- Конструктор класса
function Ability:_init(args)
    print(args)
    self.ability = args.ability
    self.tooltip = args.tooltip
    self.text = args.text
    self.icon = args.icon
    self.key = args.key
    self.buff_tooltip = args.buff_tooltip or args.tooltip
    self.buff_desc = args.buff_desc or args.text
end

--- Проинициализировать способность.
---Задать тултип, описание и иконку
function Ability:Init()
    self:SetTooltip()
    self:SetText()
    self:SetIcon()
end

--- Установить название для способности
---@param tooltip string
---@return nil
function Ability:SetTooltip(tooltip)
    local t = tooltip or self.tooltip
    t = t .. " (" .. set_color(self.key, Color.ORANGE) .. ")"
    BlzSetAbilityTooltip(self.ability, t, 0)
end

--- Установить описание для способности
---@param text string
---@return nil
function Ability:SetText(text)
    local t = text or self.text
    BlzSetAbilityExtendedTooltip(self.ability, t, 0)
end

--- Установить иконку способности
---@param icon string Путь до текстуры
---@return nil
function Ability:SetIcon(icon)
    local i = icon or self.icon
    BlzSetAbilityIcon(self.ability, i)
end

function Ability:SpellCasted()
    return GetSpellAbilityId() == self.ability
end

--- Вернуть идентификатор способности
---@return ability
function Ability:GetId()
    return self.ability
end
