---@author meiso

--- Класс создания таймера
---@param timeout real Время действия
---@param func function Функция
Timer = {}
Timer.__index = Timer

setmetatable(Timer, {
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
    end,
})

function Timer:_init(timeout, func)
    self.timer = CreateTimer()
    self.timeout = timeout
    self.func = func
end

--- Запустить таймер
---@return nil
function Timer:Start()
    TimerStart(self.timer, self.timeout, false, self.func)
end

--- Задать время действия
---@param timeout real Время действия
---@return nil
function Timer:SetTimeout(timeout)
    self.timeout = timeout
end

--- Задать функцию
---@param func function Функция
---@return nil
function Timer:SetFunc(func)
    self.func = func
end

--- Уничтожить таймер
---@return nil
function Timer:Destroy()
    DestroyTimer(self.timer)
end

--- Уничтожить первый истёкший таймер
---@return nil
function Timer:DestroyExpired()
    DestroyTimer(GetExpiredTimer())
end
