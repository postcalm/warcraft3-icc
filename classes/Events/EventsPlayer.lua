--- Created by meiso.

EventsPlayer = {}
EventsPlayer.__index = EventsPlayer

setmetatable(EventsPlayer, {
    __index = Events,
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
    end,
})

function EventsPlayer:_init(player)
    Events._init(self)
    self.player = player or 0
end

--- Регистриует событие каста способности юнитом игрока
function EventsPlayer:RegisterUnitSpellCast()
    TriggerRegisterPlayerUnitEvent(self.trigger, self.player, EVENT_PLAYER_UNIT_SPELL_CAST, nil)
end

--- Регистриует событие нанесения урона юнитом игрока
function EventsPlayer:RegisterUnitDamaging()
    TriggerRegisterPlayerUnitEvent(self.trigger, self.unit, EVENT_PLAYER_UNIT_DAMAGING)
end

--- Регистриует событие смерти юнита игрока
function EventsPlayer:RegisterUnitDeath()
    TriggerRegisterPlayerUnitEvent(self.trigger, self.unit, EVENT_PLAYER_UNIT_DEATH)
end

-- абсолютно две бессмысленные обёртки над методами родителя
-- и нужны только для того, чтобы методы показывались в IDE

--- Добавляет условие для события
---@param func function Функция, возвращающая bool или boolexpr
function EventsPlayer:AddCondition(func)
    Events.AddCondition(self, func)
end

--- Добавляет действие для события
---@param func function Функция, запускающаяся после срабатывания события
function EventsPlayer:AddAction(func)
    Events.AddAction(self, func)
end
