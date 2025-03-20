---@author meiso


---@class Pool Неупорядоченная коллекция, представляющая пул (список) элементов одного типа.
Pool = {}
Pool.__index = Pool

setmetatable(Pool, {
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
    end,
})

---@private
function Pool:_init()
    ---@private
    self._pool = {}
end

--- Возвращает все элементы
---@return table
function Pool:All()
    return self._pool
end

--- Проверят не пуст ли пул
---@return boolean
function Pool:IsEmpty()
    return next(self._pool) == nil
end

--- Добавить элемент
---@param value any
---@return nil
function Pool:Add(value)
    if not self:Contain(value) then
        table.insert(self._pool, value)
    end
end

--- Обновить существующий элемент
---@param value any
---@return nil
function Pool:Update(value)
    local index = self:Find(value)
    if self:Contain(value) then
        table.remove(self._pool, index)
        table.insert(self._pool, value)
    end
end

--- Получить элемент по индексу
---@param index number
---@return any
function Pool:Get(index)
    return self._pool[index]
end

--- Удалить элемент
---@param value any
---@return nil
function Pool:Remove(value)
    if self:Contain(value) then
        table.remove(self._pool, self:Find(value))
    end
end

--- Входит ли элемент в пул
---@param value any
---@return boolean
function Pool:Contain(value)
    for _, v in pairs(self._pool) do
        if v == value then
            return true
        end
    end
    return false
end

--- Найти элемент. Возвращает индекс
---@param value any
---@return number
function Pool:Find(value)
    for i, v in pairs(self._pool) do
        if v == value then
            return i
        end
    end
    return nil
end

--- Очистить пул
---@return nil
function Pool:Clear()
    self._pool = {}
end
