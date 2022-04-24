--- Created by meiso.

Unit = {}
Unit.__index = Unit

setmetatable(Unit, {
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self.unit
    end,
})

---@param player player
---@param unit_id unit
---@param location location
---@param face real
function Unit:_init(player, unit_id, location, face)
    local x = GetLocationX(location)
    local y = GetLocationY(location)
    self.face = face or 0
    self.unit = CreateUnit(player, unit_id, x, y, self.face)
end
