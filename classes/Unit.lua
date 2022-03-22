--- Created by meiso.

Unit = {}

function Unit:new(player, unit_id, location, face)
    local obj = {}
    local x = GetLocationX(location)
    local y = GetLocationY(location)
    obj.face = face or 0
    obj.unit = CreateUnit(player, unit_id, x, y, obj.face)
    setmetatable(obj, self)
    self.__index = self
    return obj.unit
end
