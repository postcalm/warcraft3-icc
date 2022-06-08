
---@param unit unitid
---@param model string
---@param scale real
Effect = {}
Effect.__index = Effect

setmetatable(Effect, {
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
    end,
})

---@param unit unitid
---@param model string
---@param scale real
function Effect:_init(unit, model, scale)
    local u = unit
    if type(unit) == "table" then u = unit:GetId() end
    self.effect = AddSpecialEffectTarget(model, u, "overhead")
    if scale then BlzSetSpecialEffectScale(self.effect, scale) end
end

function Effect:SetTimedLife(time)
    TriggerSleepAction(time)
    self:Destroy()
end

function Effect:Destroy()
    DestroyEffect(self.effect)
end
