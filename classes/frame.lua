
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

end

function StartFrameCD(cd)
    local period = 0.05
    local bar = BlzCreateFrameByType("STATUSBAR", "", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    BlzFrameSetAbsPoint(bar, FRAMEPOINT_CENTER, 0.3, 0.15)
    -- Screen Size does not matter but has to be there
    BlzFrameSetSize(bar, 0.00001, 0.00001)

    -- Models don't care about Frame Size, But world Object Models are huge . To use them in the UI one has to scale them down alot.
    BlzFrameSetScale(bar, 1)
    BlzFrameSetModel(bar, "ui/feedback/progressbar/timerbar.mdx", 0)

    local amount = period * 100 / cd
    local full = 0

    BlzFrameSetValue(bar, 0)
    TimerStart(CreateTimer(), period, true, function()
        full = full + amount
        BlzFrameSetValue(bar, full)
        if full >= 100 then
            DestroyTimer(GetExpiredTimer())
            BlzDestroyFrame(bar)
            full = 0
        end
    end)
end