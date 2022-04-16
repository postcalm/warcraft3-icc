--- Created by meiso.

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

--- Базовый класс событий
function Events:_init()
    self.trigger = CreateTrigger()
end

--- Добавляет условие для события
---@param func function Функция, возвращающая bool или boolexpr
function Events:AddCondition(func)
    TriggerAddCondition(self.trigger, Condition(func))
end

--- Добавляет действие для события
---@param func function Функция, запускающаяся после срабатывания события
function Events:AddAction(func)
    TriggerAddAction(self.trigger, func)
end

function Events:DisableTrigger()
    DisableTrigger(self.trigger)
end

function Events:EnableTrigger()
    EnableTrigger(self.trigger)
end

function Events:DestroyTrigger()
    DestroyTrigger(self.trigger)
end
