--- Created by meiso.

Point = {}
Point.__index = Point

setmetatable(Point, {
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
    end,
})

function Point:_init(X, Y, Z)
    self.X = X or 0
    self.Y = Y or 0
    self.Z = Z or 0
end

function Point:get2DPoint()
    return { self.X, self.Y }
end

function Point:get3DPoint()
    return { self.X, self.Y, self.Z }
end

--- Проверяет равны ли указанные точки
---@param point Point
---@param inaccuracy boolean Учитывать ли погрешность
---@return boolean
function Point:atPoint(point, inaccuracy)
    if not inaccuracy then inaccuracy = 0
    else inaccuracy = 30. end
    if math.abs(self.X - point.X) <= inaccuracy and
            math.abs(self.Y - point.Y) <= inaccuracy then
        return true
    end
    return false
end
