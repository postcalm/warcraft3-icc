--- Created by meiso.
--- DateTime: 06.03.2022

BuffSystem = {}
--- Таблица содержащая всех героев с бафами
buffs = {}

--- Регистрирует героя в системе бафов
---@param hero unit Id героя
function BuffSystem.RegisterHero(hero)
    if BuffSystem.IsHeroInSystem(hero) then
        return
    end
    local u = ""..GetHandleId(hero)
    buffs[u] = {}
end

--- Добавляет герою баф
---@param hero unit Id героя
---@param buff buff Id бафа
function BuffSystem.AddBuffToHero(hero, buff)
    if BuffSystem.IsBuffOnHero(hero, buff) then
        return
    end
    local u = ""..GetHandleId(hero)
    table.insert(buffs[u], buff)
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
    for i = 1, #buffs[u] do
        if buffs[u][i] == buff then
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
        if buffs[u][i] == buff then
            buffs[u][i] = nil
        end
    end
end

--- Удаляет героя из системы бафов
---@param hero unit Id героя
function BuffSystem.RemoveHero(hero)
    local u = ""..GetHandleId(hero)
    buffs[u] = nil
end
