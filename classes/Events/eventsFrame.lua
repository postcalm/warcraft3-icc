
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
end

function EventsFrame:RegisterControlClick()
    BlzTriggerRegisterFrameEvent(self.trigger, self.frame, FRAMEEVENT_CONTROL_CLICK)
end

function EventsFrame:RegisterMouseEnter()
    BlzTriggerRegisterFrameEvent(self.trigger, self.frame, FRAMEEVENT_MOUSE_ENTER)
end

function EventsFrame:RegisterMouseLeave()
    BlzTriggerRegisterFrameEvent(self.trigger, self.frame, FRAMEEVENT_MOUSE_LEAVE)
end

function EventsFrame:GetFrame()
    return BlzGetTriggerFrame()
end

function EventsFrame:GetEvent()
    return BlzGetTriggerFrameEvent()
end