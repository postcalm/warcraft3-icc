---@author meiso

--- Базовый класс событий
---@class Events
Events = {}
Events.__index = Events

--Обёртка над конструктором класса
setmetatable(Events, {
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
    end,
})

--- Конструктор класса
function Events:_init()
    self.trigger = CreateTrigger()
end

--- Добавляет условие для выполнения события
---@param func function Функция, возвращающая bool или boolexpr
---@return nil
function Events:AddCondition(func)
    TriggerAddCondition(self.trigger, Condition(func))
end

--- Добавляет действие для события
---@param func function Функция, запускающаяся после срабатывания события
---@return nil
function Events:AddAction(func)
    TriggerAddAction(self.trigger, func)
end

--- Отключает триггер
---@return nil
function Events:DisableTrigger()
    DisableTrigger(self.trigger)
end

--- Включает триггер
---@return nil
function Events:EnableTrigger()
    EnableTrigger(self.trigger)
end

--- Уничтожает триггер
---@return nil
function Events:Destroy()
    DestroyTrigger(self.trigger)
end
