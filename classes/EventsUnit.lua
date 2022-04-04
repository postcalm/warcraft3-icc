--- Created by meiso.

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
    self.unit = unit or 0
end

--- Регистриует событие получения урона юнитом
function EventsUnit:RegisterDamaged()
    TriggerRegisterUnitEvent(self.trigger, self.unit, EVENT_UNIT_DAMAGED)
end