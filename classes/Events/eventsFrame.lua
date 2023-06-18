---@author meiso

---@class EventsFrame Класс регистрации событий фрейма
---@param frame framehandle Хэндл фрейма
EventsFrame = {}
EventsFrame.__index = EventsFrame

setmetatable(EventsFrame, {
    __index = Events,
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
    end,
})

--- Конструктор класса
function EventsFrame:_init(frame)
    Events._init(self)
    self.frame = frame
end

--- Регистрирует событие клика по фрейму
---@return nil
function EventsFrame:RegisterControlClick()
    BlzTriggerRegisterFrameEvent(self.trigger, self.frame, FRAMEEVENT_CONTROL_CLICK)
end

--- Регистрирует событие принятия диалогового окна
---@return nil
function EventsFrame:RegisterDialogAccept()
    BlzTriggerRegisterFrameEvent(self.trigger, self.frame, FRAMEEVENT_DIALOG_ACCEPT)
end

--- Регистрирует событие отмены диалогового окна
---@return nil
function EventsFrame:RegisterDialogCancel()
    BlzTriggerRegisterFrameEvent(self.trigger, self.frame, FRAMEEVENT_DIALOG_CANCEL)
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

--- Регистрирует событие нажатия Enter в поле edit box
---@return nil
function EventsFrame:RegisterEditBoxEnter()
    BlzTriggerRegisterFrameEvent(self.trigger, self.frame, FRAMEEVENT_EDITBOX_ENTER)
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
