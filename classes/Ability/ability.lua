---@author meiso

--- Класс конфигурирования способностей
---@class Ability
---@param ability ability Способность
---@param tooltip string Название способности
---@param text string Описание способности
---@param icon string Иконка. По умолчанию дефолтная, выбранная в редакторе
---@param key string Кнопка использования
---@param buff_tooltip string Название бафа. По умолчанию название способности
---@param buff_desc string Описание бафа. По умолчанию описание способности
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
    self.ability = args.ability
    self.tooltip = args.tooltip
    self.text = args.text
    self.icon = args.icon or ""
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
    tooltip = tooltip or self.tooltip
    if self.key ~= nil then
        tooltip = tooltip .. " (" .. set_color(self.key, Color.ORANGE) .. ")"
    end
    BlzSetAbilityTooltip(self.ability, tooltip, 0)
end

--- Установить описание для способности
---@param text string
---@return nil
function Ability:SetText(text)
    text = text or self.text
    BlzSetAbilityExtendedTooltip(self.ability, text, 0)
end

--- Установить иконку способности
---@param icon string Путь до текстуры
---@return nil
function Ability:SetIcon(icon)
    icon = icon or self.icon
    if icon ~= "" then
        BlzSetAbilityIcon(self.ability, icon)
    end
end

--- Проверить, что спелл скастован
---@return boolean
function Ability:SpellCasted()
    return GetSpellAbilityId() == self.ability
end

--- Вернуть идентификатор способности
---@return ability
function Ability:GetId()
    return self.ability
end
