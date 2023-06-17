---@author meiso

---@class Effect Класс создания эффектов на юнитах
---@param unit unitid Id юнита
---@param model string Название модели
---@param attach_point string Точка к которой крепится эффект
---@param scale real Размер эффекта
Effect = {}
Effect.__index = Effect

setmetatable(Effect, {
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
    end,
})

--- Конструктор класса
function Effect:_init(unit, model, attach_point, scale)
    local u = unit
    local point = attach_point or "overhead"
    if isTable(unit) then
        u = unit:GetId()
    end
    self.effect = AddSpecialEffectTarget(model, u, point)
    if scale then
        BlzSetSpecialEffectScale(self.effect, scale)
    end
end

--- Уничтожить эффект
---@return nil
function Effect:Destroy()
    DestroyEffect(self.effect)
end
