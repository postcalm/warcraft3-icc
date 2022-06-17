
UnitSpell = {}
UnitSpell.__index = UnitSpell

setmetatable(UnitSpell, {
    __index = Unit,
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
    end,
})

function UnitSpell:_init(owner, location)
    local loc = location or GetUnitLoc(owner)
    local face = GetUnitFacing(owner)
    self.unit = Unit(GetOwningPlayer(owner), SPELL_DUMMY, loc, face):GetId()
    SetUnitMoveSpeed(self.unit, 512.)
end

function UnitSpell:MoveToUnit(unit)
    local loc
    if type(unit) == "table" then loc = unit:GetLoc()
    else loc = GetUnitLoc(unit) end
    IssuePointOrderLoc(self.unit, "move", loc)
end

function UnitSpell:NearTarget(target)
    local loc
    if type(target) == "table" then loc = target:GetLoc()
    else loc = GetUnitLoc(target) end
    local target_point = Point(GetLocationX(loc), GetLocationY(loc))
    local unit_loc = self:GetLoc()
    local unit_point = Point(GetLocationX(unit_loc), GetLocationY(unit_loc))
    return target_point:atPoint(unit_point)
end
