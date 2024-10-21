---@author meiso

---@class LogLevel
LogLevel = {
    TRACE = { name = "TRACE", level = 1 },
    DEBUG = { name = "DEBUG", level = 2 },
    INFO = { name = "INFO", level = 3 },
    WARNING = { name = "WARNING", level = 4 },
    ERROR = { name = "ERROR", level = 5 },
}

---@class Logger
---@param log_file
Logger = {}
Logger.__index = Logger

setmetatable(Logger, {
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
    end,
})

function Logger:_init(log_file)
    local session_datetime = os.date("%d.%m.%Y_%H.%M.%S")
    self.log_dir = "logs"
    self.log_file = session_datetime .. "_" .. (log_file or "log.txt")
end

function Logger.GetLogger()

end

---
---@param args
---@param level LogLevel
---@return nil
function Logger:Log(level, ...)
    local args = table.pack(...)
    local log_datetime = "[" .. os.date("%d.%m.%Y %H:%M:%S") .. "]"
    local message = log_datetime .. " " .. level.name .. ":"
    for _, arg in ipairs(args) do
        message = message .. " " .. arg
    end
    self:_write(message)
end

---
---@param args
---@return nil
function Logger:Trace(...)
    self:Log(LogLevel.TRACE, ...)
end

---
---@param args
---@return nil
function Logger:Debug(...)
    self:Log(LogLevel.DEBUG, ...)
end

---
---@param args
---@return nil
function Logger:Info(...)
    self:Log(LogLevel.INFO, ...)
end

---
---@param args
---@return nil
function Logger:Warning(...)
    self:Log(LogLevel.WARNING, ...)
end

---
---@param args
---@return nil
function Logger:Error(...)
    self:Log(LogLevel.ERROR, ...)
end

---
---@param message
---@return nil
function Logger:_write(message)
    PreloadGenClear()
    Preload(message)
    local full_path = "save\\" .. self.log_dir .. "\\" .. self.log_file
    PreloadGenEnd(full_path)
end
