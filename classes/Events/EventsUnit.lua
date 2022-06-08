
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

function EventsUnit:_init(unit)
    Events._init(self)
    self.unit = unit
    if type(unit) == "table" then self.unit = unit:GetId() end
end

--- Регистриует событие получения урона юнитом
function EventsUnit:RegisterDamaged()
    TriggerRegisterUnitEvent(self.trigger, self.unit, EVENT_UNIT_DAMAGED)
end

--- Регистриует событие нанесения урона юнитом
function EventsUnit:RegisterDamaging()
    TriggerRegisterUnitEvent(self.trigger, self.unit, EVENT_UNIT_DAMAGING)
end

--- Регистриует событие, когда юнита атакуют или он атакует
function EventsUnit:RegisterAttacked()
    TriggerRegisterUnitEvent(self.trigger, self.unit, EVENT_UNIT_ATTACKED)
end

-- далее идут бессмысленные обёртки над методами родителя
-- и нужны только для того, чтобы методы показывались в IDE

--- Добавляет условие для события
---@param func function Функция, возвращающая bool или boolexpr
function EventsUnit:AddCondition(func)
    Events.AddCondition(self, func)
end

--- Добавляет действие для события
---@param func function Функция, запускающаяся после срабатывания события
function EventsUnit:AddAction(func)
    Events.AddAction(self, func)
end

--- Отключает триггер
function EventsUnit:DisableTrigger()
    Events.DisableTrigger(self)
end

--- Включает триггер
function EventsUnit:EnableTrigger()
    Events.EnableTrigger(self)
end

--- Уничтожает триггер
function EventsUnit:Destroy()
    Events.Destroy(self)
end