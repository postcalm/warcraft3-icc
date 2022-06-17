
Timer = {}
Timer.__index = Timer

setmetatable(Timer, {
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
    end,
})

---@param timeout real
---@param func function
function Timer:_init(timeout, func)
    self.timer = CreateTimer()
    self.timeout = timeout
    self.func = function() func() end
end

--- Запустить таймер
function Timer:Start()
    TimerStart(self.timer, self.timeout, false, self.func())
end

--- Уничтожить таймер
function Timer:Destroy()
    DestroyTimer(self.timer)
end
