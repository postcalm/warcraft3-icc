---@author meiso

UNITS_PULL = {
    ---@private
    _pull = {},
    ---@return Unit
    get = function(index)
        return UNITS_PULL._pull[index]
    end,
    ---@param unit Unit
    add = function(unit)
        if not UNITS_PULL.contain(unit) then
            table.insert(UNITS_PULL._pull, unit)
        end
    end,
    ---@param unit Unit
    remove = function(unit)
        if UNITS_PULL.contain(unit) then
            table.remove(UNITS_PULL._pull, UNITS_PULL.find(unit))
        end
    end,
    ---@param unit Unit
    contain = function(unit)
        unit = UNITS_PULL._unitId(unit)
        for _, u in pairs(UNITS_PULL._pull) do
            if UNITS_PULL._unitId(u) == unit then
                return true
            end
        end
        return false
    end,
    ---@param unit Unit
    find = function(unit)
        unit = UNITS_PULL._unitId(unit)
        for i, u in pairs(UNITS_PULL._pull) do
            if UNITS_PULL._unitId(u) == unit then
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
