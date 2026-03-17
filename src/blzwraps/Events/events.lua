---@author meiso

---@class Events Базовый класс событий
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

--- Регистрирует смерть любого юнита
---@return nil
function Events:RegisterAnyUnitDying()
    TriggerRegisterAnyUnitEventBJ(self.trigger, EVENT_PLAYER_UNIT_DEATH)
end

--- Регистрирует вхождение в область
---@return nil
function Events:RegisterEnterRect(rect)
    TriggerRegisterEnterRectSimple(self.trigger, rect)
end

--- Регистрирует выход из области
---@return nil
function Events:RegisterLeaveRect(rect)
    TriggerRegisterLeaveRectSimple(self.trigger, rect)
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
