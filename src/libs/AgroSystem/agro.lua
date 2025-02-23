---@author meiso

AgroSystem = {
    ---@type table[integer]
    HIGH_AGRO_CHARS = {
        Paladin.hero,
        DEATH_KNIGHT,
        WARRIOR,
    },
    ---@type table[integer]
    MEDIUM_AGRO_CHARS = {
        WARLOCK,
        HUNTER,
        ROGUE,
        MAGE,
        DRUID,
        SHAMAN,
        Priest.hero,
    },
}

--- Инициализация системы агрессии
function AgroSystem.Init(unit)
    AgroSystem._detectedCombat(unit)
end

---@private
function AgroSystem._detectedCombat(unit)
    local tr_attacked = EventsUnit(unit)
    local tr_damaged = EventsUnit(unit)
    tr_attacked:RegisterAttacked()
    tr_damaged:RegisterDamaged()

    tr_attacked:AddAction(AgroSystem._detectedAttackedUnit)
    tr_damaged:AddAction(AgroSystem._detectedDamagedUnit)
end

---@private
function AgroSystem._detectedAttackedUnit()
    local unit = Unit(GetAttackedUnitBJ())
    print("attacked", unit:GetName(), unit:IsControlled())
end

---@private
function AgroSystem._detectedDamagedUnit()
    local unit = Unit(GetEventDamageSource())
    print("damaged", unit:GetName(), unit:IsControlled())
end

---@private
function AgroSystem._addUnit(unit)
    table.insert(AgroSystem.attacked_units, unit)
end

---@private
function AgroSystem._removeUnit(unit)
    for i in #AgroSystem.attacked_units do
        if AgroSystem.attacked_units[i] == unit then
            table.remove(AgroSystem.attacked_units, i)
            break
        end
    end
end
