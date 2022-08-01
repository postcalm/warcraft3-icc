
Frame = {}
Frame.__index = Frame

setmetatable(Frame, {
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
    end,
})

---@param name string Название fdf-шаблона
---@param owner framehandle Хэндл родителя
---@param simple boolean Простой фрейм
function Frame:_init(name, owner, simple)
    if simple then
        self.frame = BlzCreateSimpleFrame(name, owner, 0)
    else
        self.frame = BlzCreateFrame(name, owner, 0)
    end
end

function Frame:CastBar(cd)
    local period = 0.05
    self.frame = BlzCreateFrameByType("STATUSBAR", "", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    self:SetAbsPoint(FRAMEPOINT_CENTER, 0.3, 0.15)
    -- размер экрана не имеет значения, но должен быть
    self:SetSize(0.00001, 0.00001)

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
