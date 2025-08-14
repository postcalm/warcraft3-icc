---@author meiso

---@class Vector
Vector = {}
Vector.__index = Vector

setmetatable(Vector, {
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
    end,
})

---@private
function Vector:_init(x, y)
    self.x = x
    self.y = y
end

--- Прибавляет вектор
---@param vector Vector
---@return Vector
function Vector:__add(vector)
    self.x = self.x + vector.x
    self.y = self.y + vector.y
    return self
end

--- Вычитает вектор
---@param vector Vector
---@return Vector
function Vector:__sub(vector)
    self.x = self.x - vector.x
    self.y = self.y - vector.y
    return self
end

--- Умножение вектора на скаляр
---@param vector number
---@return Vector
function Vector:__mul(scalar)
    self.x = self.x * scalar
    self.y = self.y * scalar
    return self
end

--- Деление вектора на скаляр
---@param vector number
---@return Vector
function Vector:__div(scalar)
    self.x = self.x / scalar
    self.y = self.y / scalar
    return self
end

---@private
function Vector:__tostring()
    return "Vector(" .. self.x .. ", " .. self.y .. ")"
end
