---@author meiso

---@class EventsPlayer Класс регистрации событий игрока
---@param player playerid Id игрока. По умолчанию - локальный игрок
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

--- Конструктор класса
function EventsPlayer:_init(player)
    Events._init(self)
    self.player = player or GetTriggerPlayer()
end

--- Регистрирует нажатие клавиши
---@param key oskeytype Регистрируемая клавиша
---@return nil
function EventsPlayer:RegisterKeyPressed(key)
    BlzTriggerRegisterPlayerKeyEvent(self.trigger, self.player, key, 0, true)
    BlzTriggerRegisterPlayerKeyEvent(self.trigger, self.player, key, 0, false)
end

--- Регистрирует событие нажатия кнопки мыши
---@return nil
function EventsPlayer:RegisterPlayerMouseDown()
    TriggerRegisterPlayerEvent(self.trigger, self.player, EVENT_PLAYER_MOUSE_DOWN)
end

--- Регистрирует событие, написания в чат
---@param text string Сообщение, которое необходимо отследить
---@param exact boolean Проверять как точное вхождение
---@return nil
function EventsPlayer:RegisterChatEvent(text, exact)
    local e = exact or false
    TriggerRegisterPlayerChatEvent(self.trigger, self.player, text, e)
end

--- Регистрирует событие атаки по юниту игрока
---@return nil
function EventsPlayer:RegisterUnitAttacked()
    TriggerRegisterPlayerUnitEvent(self.trigger, self.player, EVENT_PLAYER_UNIT_ATTACKED, nil)
end

--- Регистрирует событие каста способности юнитом игрока
---@return nil
function EventsPlayer:RegisterUnitSpellCast()
    TriggerRegisterPlayerUnitEvent(self.trigger, self.player, EVENT_PLAYER_UNIT_SPELL_CAST, nil)
end

--- Регистрирует событие прекращения каста способности
---@return nil
function EventsPlayer:RegisterUnitSpellEndcast()
    TriggerRegisterPlayerUnitEvent(self.trigger, self.player, EVENT_PLAYER_UNIT_SPELL_ENDCAST, nil)
end

--- Регистрирует событие завершения каста способности
---@return nil
function EventsPlayer:RegisterUnitSpellFinish()
    TriggerRegisterPlayerUnitEvent(self.trigger, self.player, EVENT_PLAYER_UNIT_SPELL_FINISH, nil)
end

--- Регистрирует событие получения урона юнитом (до вычета брони)
---@return nil
function EventsPlayer:RegisterUnitDamaging()
    TriggerRegisterPlayerUnitEvent(self.trigger, self.player, EVENT_PLAYER_UNIT_DAMAGING, nil)
end

--- Регистрирует событие получения урона юнитом (после вычета брони)
---@return nil
function EventsPlayer:RegisterUnitDamaged()
    TriggerRegisterPlayerUnitEvent(self.trigger, self.player, EVENT_PLAYER_UNIT_DAMAGED, nil)
end

--- Регистрирует событие смерти юнита игрока
---@return nil
function EventsPlayer:RegisterUnitDeath()
    TriggerRegisterPlayerUnitEvent(self.trigger, self.player, EVENT_PLAYER_UNIT_DEATH, nil)
end

--- Регистрирует событие призыва юнита игрока
---@return nil
function EventsPlayer:RegisterUnitSummon()
    TriggerRegisterPlayerUnitEvent(self.trigger, self.player, EVENT_PLAYER_UNIT_SUMMON, nil)
end

-- далее идут бессмысленные обёртки над методами родителя
-- и нужны только для того, чтобы методы показывались в IDE

--- Добавляет условие для выполнения события
---@param func function Функция, возвращающая bool или boolexpr
---@return nil
function EventsPlayer:AddCondition(func)
    Events.AddCondition(self, func)
end

--- Добавляет действие для события
---@param func function Функция, запускающаяся после срабатывания события
---@return nil
function EventsPlayer:AddAction(func)
    Events.AddAction(self, func)
end

--- Отключает триггер
---@return nil
function EventsPlayer:DisableTrigger()
    Events.DisableTrigger(self)
end

--- Включает триггер
---@return nil
function EventsPlayer:EnableTrigger()
    Events.EnableTrigger(self)
end

--- Уничтожает триггер
---@return nil
function EventsPlayer:Destroy()
    Events.Destroy(self)
end
