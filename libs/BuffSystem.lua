-- Copyright (c) 2022 meiso

BuffSystem = {}
--- Таблица содержащая всех героев с бафами
buffs = {}

--- Регистрирует героя в системе бафов
---@param hero unit Id героя
function BuffSystem.RegisterHero(hero)
    if BuffSystem.IsHeroInSystem(hero) then return end
    local u = ""..GetHandleId(hero)
    buffs[u] = {}
end

--- Добавляет герою баф
---@param hero unit Id героя
---@param buff buff Id бафа
---@param func function Функция, снимающая баф
function BuffSystem.AddBuffToHero(hero, buff, func)
    if BuffSystem.IsBuffOnHero(hero, buff) then return end
    local u = ""..GetHandleId(hero)
    table.insert(buffs[u], { buff_ = buff, func_ = func })
    BuffSystem.CheckingBuffsExceptions(hero, buff)
end

--- Проверяет есть ли герой в системе бафов
---@param hero unit Id героя
---@return boolean
function BuffSystem.IsHeroInSystem(hero)
    local u = ""..GetHandleId(hero)
    for name, _ in pairs(buffs) do
        if name == u then
            return true
        end
    end
    return false
end

--- Проверяет есть ли на герое баф
---@param hero unit Id героя
---@param buff buff Id бафа
---@return boolean
function BuffSystem.IsBuffOnHero(hero, buff)
    local u = ""..GetHandleId(hero)
    if #buffs[u] == 0 then return false end
    BuffSystem.CheckingBuffsExceptions(hero, buff)
    for i = 1, #buffs[u] do
        if buffs[u][i] == nil then return false end
        if buffs[u][i].buff_ == buff then
            return true
        end
    end
    return false
end

--- Удаляет у героя баф
---@param hero unit Id героя
---@param buff buff Id бафа
function BuffSystem.RemoveBuffToHero(hero, buff)
    local u = ""..GetHandleId(hero)
    for i = 1, #buffs[u] do
        if buffs[u][i].buff_ == buff then
            buffs[u][i] = nil
        end
    end
end

--- Использует лямбда-функцию для удаления бафа
---@param hero unit Id героя
---@param buff buff Id бафа
function BuffSystem.UseRemovingFunction(hero, buff)
    local u = ""..GetHandleId(hero)
    for i = 1, #buffs[u] do
        if buffs[u][i] == nil then return end
        if buffs[u][i].buff_ == buff then
            buffs[u][i].func_()
        end
    end
end

--- Удаляет героя из системы бафов
---@param hero unit Id героя
function BuffSystem.RemoveHero(hero)
    local u = ""..GetHandleId(hero)
    buffs[u] = nil
end

--- Проверят относится ли баф к
function BuffSystem.CheckingBuffsExceptions(hero, buff)
    local buffs_exceptions = {
        paladin = {"BlessingOfKings", "BlessingOfWisdom", "BlessingOfSanctuary", "BlessingOfMight"},
        priest = {},
        shaman = {},
        druid = {},
    }

    local function getBuffsByClass()
        for class, buffs in pairs(buffs_exceptions) do
            for i in pairs(buffs) do
                if buffs[i] == buff then return buffs_exceptions[class] end
            end
        end
    end

    for _, buff_ in pairs(getBuffsByClass()) do
        if buff_ ~= buff then
            BuffSystem.UseRemovingFunction(hero, buff_)
        end
    end
end

function BuffSystem.RemoveAllBuffs(hero)
    local u = ""..GetHandleId(hero)
    for i = 1, #buffs[u] do
        BuffSystem.UseRemovingFunction(hero, buffs[u][i].buff_)
    end
end

function BuffSystem.CheckingDebuffsExceptions()
    debuffs_exceptions = {
        paladin = {"JudgementOfWisdom", "JudgementOfLight"},
    }
end
