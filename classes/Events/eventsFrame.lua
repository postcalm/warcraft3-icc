
---@param frame framehandle Хэндл фрейма
EventsFrame = {}
EventsFrame.__index = EventsFrame

--Обёртка над конструктором класса
setmetatable(EventsFrame, {
    __index = Events,
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
    end,
})

function EventsFrame:_init(frame)
    Events._init(self)
    self.frame = frame
    self.dialog_status = false
end

function EventsFrame:RegisterControlClick()
    BlzTriggerRegisterFrameEvent(self.trigger, self.frame, FRAMEEVENT_CONTROL_CLICK)
end

function EventsFrame:RegisterDialog()
    self:RegisterControlClick()
    self:AddAction(function()
        local confirm = Frame("ConfirmCharacter")
        local trig = CreateTrigger()
        TriggerAddAction(trig, function()
            if self:GetEvent() == FRAMEEVENT_DIALOG_ACCEPT then
                self.dialog_status = true
                self:Destroy()
            end
            confirm:Destroy()
        end)
        BlzTriggerRegisterFrameEvent(trig, confirm:GetHandle(), FRAMEEVENT_DIALOG_ACCEPT)
        BlzTriggerRegisterFrameEvent(trig, confirm:GetHandle(), FRAMEEVENT_DIALOG_CANCEL)
    end)
end

--- Регистрирует событие входа курсора мыши во фрейм
---@return nil
function EventsFrame:RegisterMouseEnter()
    BlzTriggerRegisterFrameEvent(self.trigger, self.frame, FRAMEEVENT_MOUSE_ENTER)
end

--- Регистрирует событие выхода курсора мыши из фрейма
---@return nil
function EventsFrame:RegisterMouseLeave()
    BlzTriggerRegisterFrameEvent(self.trigger, self.frame, FRAMEEVENT_MOUSE_LEAVE)
end

--- Получить фрейм
---@return framehandle
function EventsFrame:GetFrame()
    return BlzGetTriggerFrame()
end

--- Получить событие
---@return frameeventtype
function EventsFrame:GetEvent()
    return BlzGetTriggerFrameEvent()
end

function EventsFrame:DialogIsAccepted()
    return self.dialog_status
end

-- далее идут бессмысленные обёртки над методами родителя
-- и нужны только для того, чтобы методы показывались в IDE

--- Добавляет условие для выполнения события
---@param func function Функция, возвращающая bool или boolexpr
---@return nil
function EventsFrame:AddCondition(func)
    Events.AddCondition(self, func)
end

--- Добавляет действие для события
---@param func function Функция, запускающаяся после срабатывания события
---@return nil
function EventsFrame:AddAction(func)
    Events.AddAction(self, func)
end

--- Отключает триггер
---@return nil
function EventsFrame:DisableTrigger()
    Events.DisableTrigger(self)
end

--- Включает триггер
---@return nil
function EventsFrame:EnableTrigger()
    Events.EnableTrigger(self)
end

--- Уничтожает триггер
---@return nil
function EventsFrame:Destroy()
    Events.Destroy(self)
end