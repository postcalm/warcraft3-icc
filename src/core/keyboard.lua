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
    ---@type integer
    self.player_id = nil
end

---@class KeyboardController
KeyboardController = {
    ---@type UnorderedList
    keys = UnorderedList(),
    ---@private
    _events = {},
    ---@type Logger
    logger = Logger("keyboard"),
}

--- Регистрирует события нажатия клавиш
---@param player player Игрок
---@param ... oskeytype Список клавиш
---@return nil
function KeyboardController.Register(player_id, ...)
    local player = PLAYERS[player_id]
    local keys = ...
    if type(...) ~= "table" then
        keys = table.pack(...)
    end
    if KeyboardController._events[player_id] == nil then
        KeyboardController.logger:Info("Init event for player", player_id)
        KeyboardController._events[player_id] = EventsPlayer(player)
        KeyboardController._events[player_id]:AddAction(KeyboardController._process)
    end
    for _, key in ipairs(keys) do
        KeyboardController.keys:Add(Key(key))
        KeyboardController._events[player_id]:RegisterKeyPressed(key)
    end
    KeyboardController.logger:Info("Keyboard init success")
end

---@private
function KeyboardController._process()
    local key = BlzGetTriggerPlayerKey()
    local pressed = BlzGetTriggerPlayerIsKeyDown()
    KeyboardController.logger:Debug("pressed key", GetHandleId(key))
    for _, k in pairs(KeyboardController.keys:All()) do
        if k.key == key then
            local new = k
            new.pressed = pressed
            new.player_id = GetConvertedPlayerId(GetTriggerPlayer())
            KeyboardController.keys:Update(new)
        end
    end
end
