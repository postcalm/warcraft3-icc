---@author meiso

---@class LogLevel
LogLevel = {
    DEBUG = { name = "DEBUG", level = 1 },
    INFO = { name = "INFO", level = 2 },
    WARNING = { name = "WARNING", level = 3 },
    ERROR = { name = "ERROR", level = 4 },
}

--- Включить логгер
ENABLE_LOGGER = true
--- Включить запись в чат игры
ENABLE_LOGGER_STDOUT = false
--- Уровень логирования
LOGGER_LEVEL = LogLevel.INFO

---@class Logger
---@param log_name string Имя лог файла
Logger = {
    buffer = {},
    counter = Counter(),
}
Logger.__index = Logger

setmetatable(Logger, {
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
    end,
})

---@private
function Logger:_init(log_name)
    if not ENABLE_LOGGER then return end
    print("INFO: Init logger - " .. log_name)
    log_name = log_name or "log"
    self.current = self.counter:next()
    self.buffer[self.current] = {}
    self.log_dir = "logs"
end

--- Записать в лог файл
---@param level LogLevel Уровень логирования
---@param ... string Список аргументов
---@return nil
function Logger:Log(level, ...)
    if not ENABLE_LOGGER then return end
    if level.level < LOGGER_LEVEL.level then return end
    local args = table.pack(...)
    local message = ""
    if not ENABLE_LOGGER_STDOUT then
        --message = log_datetime .. " "
    end
    message = message .. level.name .. ":"
    for _, arg in ipairs(args) do
        message = message .. " " .. tostring(arg)
    end
    if ENABLE_LOGGER_STDOUT then
        print(message)
    else
        self:_write(message)
    end
end

--- Записать отладочное сообщение
---@param ... string Список аргументов
---@return nil
function Logger:Debug(...)
    self:Log(LogLevel.DEBUG, ...)
end

--- Записать информационное сообщение
---@param ... string Список аргументов
---@return nil
function Logger:Info(...)
    self:Log(LogLevel.INFO, ...)
end

--- Записать сообщение о предупреждении
---@param ... string Список аргументов
---@return nil
function Logger:Warning(...)
    self:Log(LogLevel.WARNING, ...)
end

--- Записать сообщение об ошибке
---@param ... string Список аргументов
---@return nil
function Logger:Error(...)
    self:Log(LogLevel.ERROR, ...)
end

--- Записать сообщение в файл
---@private
---@param message string Сообщение
---@return nil
function Logger:_write(message)
    local buf = self:_read()
    table.insert(buf, message)
    self.file_handle:write(buf)
end

---@private
function Logger:_read()
    return self.file_handle:readPreload()
end
