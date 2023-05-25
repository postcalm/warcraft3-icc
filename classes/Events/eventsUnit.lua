-- Copyright (c) meiso

--- Класс регистрации событий юнита
---@param unit unit Id юнита или юнит от класса Unit
EventsUnit = {}
EventsUnit.__index = EventsUnit

setmetatable(EventsUnit, {
    __index = Events,
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
    end,
})

--- Конструктор класса
function EventsUnit:_init(unit)
    Events._init(self)
    self.unit = unit
    if isTable(unit) then
        self.unit = unit:GetId()
    end
end

--- Регистриует событие получения урона юнитом (после вычета брони)
---@return nil
function EventsUnit:RegisterDamaged()
    TriggerRegisterUnitEvent(self.trigger, self.unit, EVENT_UNIT_DAMAGED)
end

--- Регистриует событие получения урона юнитом (до вычета брони)
---@return nil
function EventsUnit:RegisterDamaging()
    TriggerRegisterUnitEvent(self.trigger, self.unit, EVENT_UNIT_DAMAGING)
end

--- Регистриует событие, когда юнит в бою
---@return nil
function EventsUnit:RegisterAttacked()
    TriggerRegisterUnitEvent(self.trigger, self.unit, EVENT_UNIT_ATTACKED)
end

--- Регистриует событие, когда юнит входит в область юнита
---@param range integer Дистанция
---@return nil
function EventsUnit:RegisterWithinRange(range)
    TriggerRegisterUnitInRange(self.trigger, self.unit, range * METER, nil)
end

-- далее идут бессмысленные обёртки над методами родителя
-- и нужны только для того, чтобы методы показывались в IDE

--- Добавляет условие для выполнения события
---@param func function Функция, возвращающая bool или boolexpr
---@return nil
function EventsUnit:AddCondition(func)
    Events.AddCondition(self, func)
end

--- Добавляет действие для события
---@param func function Функция, запускающаяся после срабатывания события
---@return nil
function EventsUnit:AddAction(func)
    Events.AddAction(self, func)
end

--- Отключает триггер
---@return nil
function EventsUnit:DisableTrigger()
    Events.DisableTrigger(self)
end

--- Включает триггер
---@return nil
function EventsUnit:EnableTrigger()
    Events.EnableTrigger(self)
end

--- Уничтожает триггер
---@return nil
function EventsUnit:Destroy()
    Events.Destroy(self)
end
