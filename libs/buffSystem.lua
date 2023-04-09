-- Copyright (c)  meiso

BuffSystem = {
    --- Таблица содержащая всех героев с бафами
    ---Формат:
    ---{ unit = { buff, func } }
    buffs = {}
}

--- Регистрирует героя в системе бафов
---@param hero unit Id героя
---@return nil
function BuffSystem.RegisterHero(hero)
    if BuffSystem.IsHeroInSystem(hero) then
        return
    end
    local u = I2S(GetHandleId(hero))
    BuffSystem.buffs[u] = {}
end

--- Добавляет герою баф
---@param hero unit Id героя
---@param buff ability Название бафа
---@param func function Функция, снимающая баф
---@return nil
function BuffSystem.AddBuffToHero(hero, buff, func)
    if BuffSystem.IsBuffOnHero(hero, buff) then
        return
    end
    local u = I2S(GetHandleId(hero))
    table.insert(BuffSystem.buffs[u], { buff_ = buff, func_ = func })
    BuffSystem.CheckingBuffsExceptions(hero, buff)
end

--- Проверяет есть ли герой в системе бафов
---@param hero unit Id героя
---@return boolean
function BuffSystem.IsHeroInSystem(hero)
    local u = I2S(GetHandleId(hero))
    for name, _ in pairs(BuffSystem.buffs) do
        if name == u then
            return true
        end
    end
    return false
end

--- Проверяет есть ли на герое баф
---@param hero unit Id героя
---@param buff ability Название бафа
---@return boolean
function BuffSystem.IsBuffOnHero(hero, buff)
    local u = I2S(GetHandleId(hero))
    if not BuffSystem.IsHeroInSystem(hero) then
        return false
    end
    if #BuffSystem.buffs[u] == 0 then
        return false
    end
    BuffSystem.CheckingBuffsExceptions(hero, buff)
    for i = 1, #BuffSystem.buffs[u] do
        if BuffSystem.buffs[u][i] == nil then
            return false
        end
        if BuffSystem.buffs[u][i].buff_ == buff then
            return true
        end
    end
    return false
end

--- Удаляет у героя баф
---@param hero unit Id героя
---@param buff ability Название бафа
---@return nil
function BuffSystem.RemoveBuffToHero(hero, buff)
    local u = I2S(GetHandleId(hero))
    for i = 1, #BuffSystem.buffs[u] do
        if BuffSystem.buffs[u][i].buff_ == buff then
            BuffSystem.buffs[u][i] = nil
        end
    end
end

--- Использует лямбда-функцию для удаления бафа
---@param hero unit Id героя
---@param buff ability Название бафа
---@return nil
function BuffSystem.RemoveBuffToHeroByFunc(hero, buff)
    local u = I2S(GetHandleId(hero))
    for i = 1, #BuffSystem.buffs[u] do
        if BuffSystem.buffs[u][i] == nil then
            return
        end
        if BuffSystem.buffs[u][i].buff_ == buff then
            BuffSystem.buffs[u][i].func_()
        end
    end
end

--- Проверят относится ли баф к группе однотипных бафов
---@param hero unit
---@param buff ability Название бафа
---@return nil
function BuffSystem.CheckingBuffsExceptions(hero, buff)
    local buffs_exceptions = {
        paladin = { BLESSING_OF_KINGS, BLESSING_OF_WISDOM, BLESSING_OF_SANCTUARY, BLESSING_OF_MIGHT },
        priest = {},
        shaman = {},
        druid = {},
    }

    local debuffs_exceptions = {
        paladin = { JUDGEMENT_OF_WISDOM, JUDGEMENT_OF_LIGHT },
    }

    local function getBuffsByClass()
        for class, buffs in pairs(buffs_exceptions) do
            for i in pairs(buffs) do
                if buffs[i] == buff then
                    return buffs_exceptions[class]
                end
            end
        end
        for class, buffs in pairs(debuffs_exceptions) do
            for i in pairs(buffs) do
                if buffs[i] == buff then
                    return debuffs_exceptions[class]
                end
            end
        end
        return {}
    end

    for _, buff_ in pairs(getBuffsByClass()) do
        if buff_ ~= buff then
            BuffSystem.RemoveBuffToHeroByFunc(hero, buff_)
        end
    end
end

--- Удалить все бафы с юнита
---@param hero unit
---@return nil
function BuffSystem.RemoveAllBuffs(hero)
    local u = I2S(GetHandleId(hero))
    for i = 1, #BuffSystem.buffs[u] do
        BuffSystem.RemoveBuffToHeroByFunc(hero, BuffSystem.buffs[u][i].buff_)
    end
end

--- Удалить баф со всех юнитов
---@param buff ability Название бафа
---@return nil
function BuffSystem.RemoveBuffFromUnits(buff)
    for unit, _ in pairs(BuffSystem.buffs) do
        for i = 1, #BuffSystem.buffs[unit] do
            if BuffSystem.buffs[unit][i] == nil then
                return
            end
            if BuffSystem.buffs[unit][i].buff_ == buff then
                BuffSystem.buffs[unit][i] = nil
            end
        end
    end
end

--- Удаляет героя из системы бафов
---@param hero unit Id героя
---@return nil
function BuffSystem.RemoveHero(hero)
    local u = I2S(GetHandleId(hero))
    BuffSystem.buffs[u] = nil
end
