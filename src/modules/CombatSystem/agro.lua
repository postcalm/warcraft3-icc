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
    self.combat = false
    self.value = 0
    self.pool_attacked = UnorderedList()
    self.logger = Logger("AgroSystem")
end

function AgroSystem:Register()
    self.logger:Info("Initialize Agro system")
    self:_detectedCombat()
end

function AgroSystem:Reset()
    self.unit:ResetAgro()
    self.combat = false
end

---@private
function AgroSystem:_detectedCombat()
    local tr_attacked = EventsUnit(self.unit)
    local tr_damaged = EventsUnit(self.unit)
    local tr_killed = Events()
    tr_attacked:RegisterAttacked()
    tr_damaged:RegisterDamaged()
    tr_killed:RegisterAnyUnitDying()
    tr_attacked:AddAction(function() self:_detectedAttackedUnit() end)
    tr_damaged:AddAction(function() self:_detectedDamagedUnit() end)
    tr_killed:AddAction(function() self:_remove() end)
end

---@private
function AgroSystem:_detectedAttackedUnit()
    local attacker = Unit(GetAttacker())
    self.combat = true
    if attacker:IsControlled() then
        attacker:AddAgro(self:_getAgro(attacker))
    end
end

---@private
function AgroSystem:_detectedDamagedUnit()
    local attacked = Unit(GetEventDamageSource())
    self.combat = true
    self.pool_attacked:Add(attacked)
    if not self.unit:IsControlled() then
        self.unit:Attack(self:_findHighAgroUnit())
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
function AgroSystem:_remove()
    local killed = Unit(GetTriggerUnit())
    self.pool_attacked:Remove(killed)

    if #self.pool_attacked:All() == 0 then
        self:Reset()
    end
end

---@private
---@return Unit
function AgroSystem:_findHighAgroUnit()
    local target
    local agro = 0
    for _, unit in pairs(self.pool_attacked:All()) do
        if unit:GetAgro() > agro then
            target = unit
            agro = unit:GetAgro()
        end
    end
    return target
end
