---@author meiso

UNITS_POOL = {
    ---@private
    ---@type table[Unit]
    _pool = {},
    all = function()
        return UNITS_POOL._pool
    end,
    ---@return Unit
    get = function(index)
        return UNITS_POOL._pool[index]
    end,
    ---@param unit Unit
    add = function(unit)
        if not UNITS_POOL.contain(unit) then
            table.insert(UNITS_POOL._pool, unit)
        end
    end,
    ---@param unit Unit
    remove = function(unit)
        if UNITS_POOL.contain(unit) then
            table.remove(UNITS_POOL._pool, UNITS_POOL.find(unit))
        end
    end,
    ---@param unit Unit
    contain = function(unit)
        unit = UNITS_POOL._unitId(unit)
        for _, u in pairs(UNITS_POOL._pool) do
            if UNITS_POOL._unitId(u) == unit then
                return true
            end
        end
        return false
    end,
    ---@param unit Unit
    find = function(unit)
        unit = UNITS_POOL._unitId(unit)
        for i, u in pairs(UNITS_POOL._pool) do
            if UNITS_POOL._unitId(u) == unit then
                return i
            end
        end
        return nil
    end,
    ---@private
    _unitId = function(unit)
        if isTable(unit) then
            return unit:GetId()
        end
        return unit
    end
}
