---@author meiso

---@class Counter Простой счётчик
Counter = {}
Counter.__index = Counter


setmetatable(Counter, {
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
    end,
})

---@private
function Counter:_init(start, step)
    self.start = start or 0
    self.step = step or 1
end

--- Возвращает следующее число
---@return number
function Counter:next()
    self.start = self.start + self.step
    return self.start
end
