--- Created by meiso.

Point = {}

function Point:new(X, Y, Z)
    local obj = {}
    obj.X = X or 0
    obj.Y = Y or 0
    obj.Z = Z or 0
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function Point:get2DPoint()
    return { self.X, self.Y }
end

function Point:get3DPoint()
    return { self.X, self.Y, self.Z }
end
