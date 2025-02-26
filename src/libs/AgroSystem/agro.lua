---@author meiso

---@class AgroSystem
AgroSystem = {}
AgroSystem.__index = AgroSystem

setmetatable(AgroSystem, {
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
    end,
})

---@private
function AgroSystem:_init(unit)
    ---@type Unit
    self.unit = unit
    self._pull_attacked = {}
end

function AgroSystem:Register()
    self:_detectedCombat()
end

function AgroSystem:Reset()
    self._pull_attacked = {}
end

---@private
function AgroSystem:_detectedCombat()
    local tr_attacked = EventsUnit(self.unit)
    local tr_damaged = EventsUnit(self.unit)
    tr_attacked:RegisterAttacked()
    tr_damaged:RegisterDamaged()
    tr_attacked:AddAction(function() self:_detectedAttackedUnit() end)
    tr_damaged:AddAction(function() self:_detectedDamagedUnit() end)
end

---@private
function AgroSystem:_detectedAttackedUnit()
    local attacker = Unit(GetAttacker())
    --local attacked = Unit(GetAttackedUnitBJ())
    if attacker:IsControlled() then
        attacker:AddAgro(self:_getAgro(attacker))
    end
end

---@private
function AgroSystem:_detectedDamagedUnit()
    local unit = Unit(GetEventDamageSource())
    if not self.unit:IsControlled() then
        self:_add(unit)
        local t = self:_findHighAgroUnit()
        self.unit:Attack(t)
    end
end

---@private
function AgroSystem:_getAgro(unit)
    local high_agro = {
        Paladin.hero,
        DEATH_KNIGHT,
        WARRIOR,
    }
    local medium_agro = {
        WARLOCK,
        HUNTER,
        ROGUE,
        MAGE,
        DRUID,
        SHAMAN,
        Priest.hero,
    }
    for _, u in pairs(high_agro) do
        if u == unit then
            return GetRandomReal(1, 3)
        end
    end
    for _, u in pairs(medium_agro) do
        if u == unit then
            return GetRandomReal(0, 2)
        end
    end
    return 0.
end

---@private
function AgroSystem:_add(unit)
    if not self:_contain(unit) then
        table.insert(self._pull_attacked, unit)
    end
end

---@private
function AgroSystem:_contain(unit)
    for _, u in pairs(self._pull_attacked) do
        if u == unit then
            return true
        end
    end
    return false
end

---@private
---@return Unit
function AgroSystem:_findHighAgroUnit()
    local target
    local agro = 0
    for _, unit in pairs(self._pull_attacked) do
        if unit:GetAgro() > agro then
            target = unit
            agro = unit:GetAgro()
        end
    end
    return target
end
