---@author meiso

---@class UnorderedList Неупорядоченный список с элементами одного типа.
UnorderedList = {}
UnorderedList.__index = UnorderedList

setmetatable(UnorderedList, {
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
    end,
})

---@private
function UnorderedList:_init()
    ---@private
    self._list = {}
end

--- Возвращает все элементы
---@return table
function UnorderedList:All()
    return self._list
end

--- Возвращает пару: индекс и элемент
---@return (number, any)
function UnorderedList:Pairs()
    return pairs(self._list)
end

--- Проверят не пуст ли список
---@return boolean
function UnorderedList:IsEmpty()
    return next(self._list) == nil
end

--- Добавить элемент
---@param value any
---@return nil
function UnorderedList:Add(value)
    if not self:Contain(value) then
        table.insert(self._list, value)
    end
end

--- Обновить существующий элемент
---@param value any
---@return nil
function UnorderedList:Update(value)
    local index = self:Find(value)
    if self:Contain(value) then
        table.remove(self._list, index)
        table.insert(self._list, value)
    end
end

--- Получить элемент по индексу
---@param index number
---@return any
function UnorderedList:Get(index)
    return self._list[index]
end

--- Удалить элемент
---@param value any
---@return nil
function UnorderedList:Remove(value)
    if self:Contain(value) then
        table.remove(self._list, self:Find(value))
    end
end

--- Входит ли элемент в список
---@param value any
---@return boolean
function UnorderedList:Contain(value)
    for _, v in pairs(self._list) do
        if v == value then
            return true
        end
    end
    return false
end

--- Найти элемент. Возвращает индекс
---@param value any
---@return number
function UnorderedList:Find(value)
    for i, v in pairs(self._list) do
        if v == value then
            return i
        end
    end
    return nil
end

--- Очистить пул
---@return nil
function UnorderedList:Clear()
    self._list = {}
end
