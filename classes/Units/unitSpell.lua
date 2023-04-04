-- Copyright (c) meiso

--- Класс создания дамми-юнита.
--- Юнит используется для применения способностей
---@param owner unit
---@param location location
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

--- Конструктор класса
function UnitSpell:_init(owner, location)
    local loc = location or GetUnitLoc(owner)
    local face = GetUnitFacing(owner)
    self.unit = Unit(GetOwningPlayer(owner), SPELL_DUMMY, loc, face):GetId()
    self:SetMoveSpeed(512.)
end

--- Проверяет находится ли дамми-юнит возле таргета
---@param target unit Цель
---@return boolean
function UnitSpell:NearTarget(target)
    local loc
    if type(target) == "table" then
        loc = target:GetLoc()
    else
        loc = GetUnitLoc(target)
    end
    local target_point = Point(GetLocationX(loc), GetLocationY(loc))
    local unit_loc = self:GetLoc()
    local unit_point = Point(GetLocationX(unit_loc), GetLocationY(unit_loc))
    return target_point:atPoint(unit_point, true)
end
