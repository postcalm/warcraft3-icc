---@author meiso

---@class Key Структура, представляющая клавишу
---@param key oskeytype Клавиша
Key = {}
Key.__index = Key

setmetatable(Key, {
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
    end,
})

---@private
function Key:_init(key)
    ---@type oskeytype
    self.key = key
    ---@type boolean
    self.pressed = false
end

---@class KeyboardController
KeyboardController = {
    ---@type Pool
    keys = Pool(),
    ---@private
    _event = nil,
    ---@type Logger
    logger = Logger("keyboard"),
}

--- Регистрирует события нажатия клавиш
---@param keys oskeytype Список клавиш
---@return nil
function KeyboardController.Register(...)
    local keys = ...
    if type(...) ~= "table" then
        keys = table.pack(...)
    end
    if KeyboardController._event == nil then
        KeyboardController._event = EventsPlayer()
        KeyboardController._event:AddAction(KeyboardController._process)
    end
    for _, key in ipairs(keys) do
        KeyboardController.keys:Add(Key(key))
        KeyboardController._event:RegisterKeyPressed(key)
    end
end

---@private
function KeyboardController._process()
    local key = BlzGetTriggerPlayerKey()
    local pressed = BlzGetTriggerPlayerIsKeyDown()
    KeyboardController.logger:Info("pressed key", GetHandleId(key))
    for _, k in pairs(KeyboardController.keys:All()) do
        if k.key == key then
            local new = k
            new.pressed = pressed
            KeyboardController.keys:Update(new)
        end
    end
end
