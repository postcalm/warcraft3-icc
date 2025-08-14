---@author meiso

---@class Point Простой point-класс
---@param x real Координата X. По умолчанию 0
---@param y real Координата Y. По умолчанию 0
---@param z real Координата Z. По умолчанию 0
Point = {}
Point.__index = Point

setmetatable(Point, {
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
    end,
})

--- Конструктор класса
function Point:_init(x, y, z)
    self.x = x or 0.
    self.y = y or 0.
    self.z = z or 0.
end

function Point:Get2DPoint()
    return { self.x, self.y }
end

function Point:Get3DPoint()
    return { self.x, self.y, self.z }
end

--- Проверяет равны ли указанные точки
---@param point Point
---@param inaccuracy boolean Учитывать ли погрешность
---@return boolean
function Point:AtPoint(point, inaccuracy)
    if not inaccuracy then
        inaccuracy = 0
    else
        inaccuracy = 30.
    end
    if math.abs(self.x - point.x) <= inaccuracy and
            math.abs(self.y - point.y) <= inaccuracy then
        return true
    end
    return false
end
