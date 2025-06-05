---@author meiso

---@class GameCache Игровой кэш
---@param filename string Название кэша
GameCache = {}
GameCache.__index = GameCache

setmetatable(GameCache, {
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
    end,
})

---@private
function GameCache:_init(filename)
    self._cache = InitGameCache(filename .. ".w3v")
end

--- Сохранить целочисленное значение
---@param value integer Значение
---@param key string Ключ/метка для сохранения
---@param category string Категория ключа/метки (по сути тоже самое, что и `key`)
---@param sync boolean Синхронизировать ли значение
---@return nil
function GameCache:StoreInt(value, key, category, sync)
    GameCache:_store(value, key, category, "int", sync)
end

--- Сохранить строковое значение
---@param value string Значение
---@param key string Ключ/метка для сохранения
---@param category string Категория ключа/метки (по сути тоже самое, что и `key`)
---@param sync boolean Синхронизировать ли значение
---@return nil
function GameCache:StoreStr(value, key, category, sync)
    GameCache:_store(value, key, category, "str", sync)
end

--- Сохранить вещественное значение
---@param value real Значение
---@param key string Ключ/метка для сохранения
---@param category string Категория ключа/метки (по сути тоже самое, что и `key`)
---@param sync boolean Синхронизировать ли значение
---@return nil
function GameCache:StoreReal(value, key, category, sync)
    GameCache:_store(value, key, category, "real", sync)
end

--- Сохранить ID юнита
---@param value unit Значение
---@param key string Ключ/метка для сохранения
---@param category string Категория ключа/метки (по сути тоже самое, что и `key`)
---@param sync boolean Синхронизировать ли значение
---@return nil
function GameCache:StoreUnit(value, key, category, sync)
    GameCache:_store(value, key, category, "unit", sync)
end

--- Сохранить булевое значение
---@param value boolean Значение
---@param key string Ключ/метка для сохранения
---@param category string Категория ключа/метки (по сути тоже самое, что и `key`)
---@param sync boolean Синхронизировать ли значение
---@return nil
function GameCache:StoreBool(value, key, category, sync)
    GameCache:_store(value, key, category, "bool", sync)
end

--- Получить целочисленное значение
---@param key string Ключ/метка значения
---@param category string Категория ключа/метки (по сути тоже самое, что и `key`)
---@return integer
function GameCache:GetInt(key, category)
    return GetStoredInteger(self._cache, key, category)
end

--- Получить строковое значение
---@param key string Ключ/метка значения
---@param category string Категория ключа/метки (по сути тоже самое, что и `key`)
---@return string
function GameCache:GetStr(key, category)
    return GetStoredString(self._cache, key, category)
end

--- Получить вещественное значение
---@param key string Ключ/метка значения
---@param category string Категория ключа/метки (по сути тоже самое, что и `key`)
---@return real
function GameCache:GetReal(key, category)
    return GetStoredReal(self._cache, key, category)
end

--- Получить булевое значение
---@param key string Ключ/метка значения
---@param category string Категория ключа/метки (по сути тоже самое, что и `key`)
---@return boolean
function GameCache:GetBool(key, category)
    return GetStoredBoolean(self._cache, key, category)
end

---@private
function GameCache:_store(value, key, category, value_type, sync)
    sync = sync or false
    if value_type == "int" then
        StoreInteger(self._cache, category, key, value)
    elseif value_type == "str" then
        StoreString(self._cache, category, key, value)
    elseif value_type == "real" then
        StoreReal(self._cache, category, key, value)
    elseif value_type == "unit" then
        StoreUnit(self._cache, category, key, value)
    elseif value_type == "bool" then
        StoreBoolean(self._cache, category, key, value)
    end
    if sync then
        self:_sync(key, category, value_type)
    end
end

---@private
function GameCache:_sync(key, category, value_type)
    if value_type == "int" then
        SyncStoredInteger(self._cache, key, category)
    elseif value_type == "str" then
        SyncStoredString(self._cache, key, category)
    elseif value_type == "real" then
        SyncStoredReal(self._cache, key, category)
    elseif value_type == "unit" then
        SyncStoredUnit(self._cache, key, category)
    elseif value_type == "bool" then
        SyncStoredBoolean(self._cache, key, category)
    end
end
