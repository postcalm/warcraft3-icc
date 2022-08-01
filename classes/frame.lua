
Frame = {}
Frame.__index = Frame

setmetatable(Frame, {
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
    end,
})

function Frame:_init()
    self.frame = BlzCreateFrameByType("STATUSBAR", "", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
end

function Frame:CastBar(cd)
    local period = 0.05
    self.frame = BlzCreateFrameByType("STATUSBAR", "", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    self:SetAbsPoint(FRAMEPOINT_CENTER, 0.3, 0.15)
    -- Screen Size does not matter but has to be there
    self:SetSize(0.00001, 0.00001)

    -- Models don't care about Frame Size, But world Object Models are huge . To use them in the UI one has to scale them down alot.
    self:SetScale(1)
    self:SetModel("ui/feedback/progressbar/timerbar.mdx")

    local amount = period * 100 / cd
    local full = 0

    -- хак, чтобы каст бар отображался корректно
    self:SetValue(0)
    TimerStart(CreateTimer(), period, true, function()
        full = full + amount
        self:SetValue(full)
        if full >= 100 then
            DestroyTimer(GetExpiredTimer())
            self:Destroy()
            full = 0
        end
    end)
end

function Frame:SetAbsPoint(point, x, y)
    BlzFrameSetAbsPoint(self.frame, point, x, y)
end

function Frame:SetSize(width, height)
    BlzFrameSetSize(self.frame, width, height)
end

function Frame:SetScale(scale)
    BlzFrameSetScale(self.frame, scale)
end

function Frame:SetModel(model)
    BlzFrameSetModel(self.frame, model, 0)
end

function Frame:SetValue(value)
    BlzFrameSetValue(self.frame, value)
end

function Frame:Destroy()
    BlzDestroyFrame(self.frame)
end
