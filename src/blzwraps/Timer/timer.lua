---@author meiso

---@class Timer Таймер
---@param timeout real Время действия
---@param func function Функция
---@param periodic boolean Повторное выполнение
Timer = {}
Timer.__index = Timer

setmetatable(Timer, {
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
    end,
})

---@private
function Timer:_init(timeout, func, periodic)
    self.timer = CreateTimer()
    self.timeout = timeout
    self.func = func
    self.periodic = periodic or false
end

--- Запустить таймер
---@return nil
function Timer:Start()
    TimerStart(self.timer, self.timeout, self.periodic, self.func)
end

--- Остановить таймер
---@return nil
function Timer:Pause()
    PauseTimer(self.timer)
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

--- Включить периодичность выполнения
---@return nil
function Timer:EnablePeriodic()
    self.periodic = true
end

--- Отключить периодичность выполнения
---@return nil
function Timer:DisablePeriodic()
    self.periodic = false
end

--- Уничтожить таймер
---@return nil
function Timer:Destroy()
    DestroyTimer(self.timer)
    self.timer = nil
end

--- Уничтожить первый истёкший таймер
---@return nil
function Timer:DestroyExpired()
    if self.periodic then
        PauseTimer(self.timer)
        DestroyTimer(self.timer)
    else
        DestroyTimer(GetExpiredTimer())
    end
end
