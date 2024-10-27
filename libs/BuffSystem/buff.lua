---@author meiso

---@class Buff Структура, представляющая положительный или отрицательный эффект
---@field buff Ability Налагаемый эффект
---@field func function Функция для снятия эффекта
---@field frame Frame Фрейм иконки
---@field is_debuff boolean Является ли эффект отрицательным
Buff = {}
Buff.__index = Buff

setmetatable(Buff, {
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
    end,
})

---@private
function Buff:_init(buff, func, frame, is_debuff)
    self.buff = buff
    self.func = func
    self.frame = frame
    self.is_debuff = is_debuff or false
end

--- Проверяет является ли эффект бафом
---@return boolean
function Buff:IsBuff(buff)
    return self.buff == buff
end

--- Проверяет является ли эффект дебафом
---@return boolean
function Buff:IsDebuff(buff)
    return self.buff == buff and self.is_debuff
end
