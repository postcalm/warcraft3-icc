--- Created by meiso.

---@class Line Класс представляющий линию в пространстве
Line = {}
Line.__index = Line

setmetatable(Line, {
    __index = Point,
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
    end,
})

function Line:_init(point1, point2)
    self.point1 = point1 or 0
    self.point2 = point2 or 0
end

--- Возвращает количество точек на линии
---@param quantity integer
function Line:getPoints(quantity)
    local new_points = {}
    local points = {}
    quantity = quantity or 1
    local ydiff, xdiff = self.point2.y - self.point1.y,
                         self.point2.x - self.point1.x
    local slope = (ydiff) / (xdiff)
    local x, y

    for i = 1, quantity do
        if slope == 0 then
            y = 0
        else
            y = ydiff * (i / quantity)
        end

        if slope == 0 then
            x = xdiff * (i / quantity)
        else
            x = y / slope
        end

        points = Point(
                round(x) + self.point1.x,
                round(y) + self.point1.y
        )
        table.insert(new_points, i, points:Get2DPoint())
    end
    table.insert(new_points, 1, self.point1:Get2DPoint())
    return new_points
end

function Line:getLength()
    local x = (self.point2.x - self.point1.x) ^ 2
    local y = (self.point2.y - self.point1.y) ^ 2
    local len = math.sqrt(x + y)
    return len
end

