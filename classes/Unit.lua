--- Created by meiso.

Unit = {}
Unit.__index = Unit

setmetatable(Unit, {
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
    end,
})

---@param player player
---@param unit_id unit
---@param location location
---@param face real
function Unit:_init(player, unit_id, location, face)
    local x = GetLocationX(location)
    local y = GetLocationY(location)
    local face_ = face or 0
    self.unit = CreateUnit(player, unit_id, x, y, face_)
end

function Unit:PhysicalDamage(target, damage)
    UnitDamageTargetBJ(self.unit, target, damage, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL)
end

function Unit:SpendMana(mana)
    SetUnitState(self.unit, UNIT_STATE_MANA, GetUnitState(self.unit, UNIT_STATE_MANA) - mana)
end

function Unit:GetManaCost(percent)
    return GetUnitState(self.unit, UNIT_STATE_MAX_MANA) * percent
end

function Unit:GetUnit()
    return self.unit
end