
--- Класс для создания "плавающего" текста
---@param text string Текст
---@param unit unitid Id юнита, относительно которого крепится текст
---@param zoffset real Расположение относительно оси Z
---@param size real Размер текста
---@param red integer Интенсивность красного цвета
---@param green integer Интенсивность зеленого цвета
---@param blue integer Интенсивность синего цвета
---@param transparency integer Прозрачность
TextTag = {}
TextTag.__index = TextTag

setmetatable(TextTag, {
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
    end
})

function TextTag:_init(text, unit, zoffset, size, red, green, blue, transparency)
    self.texttag = CreateTextTag()
    self.text_height = 0
    self.zoffset = 0
    self.text = text
    self.unit = unit
    if type(unit) == "table" then self.unit = unit:GetId() end

    if size then
        self:SetSize(size)
    end

    if zoffset then
        self:SetPosition(zoffset)
    end

    if red and green and blue and transparency then
        self:SetColor(red, green, blue, transparency)
    end
end

--- Установить предопределенные настройки для текста
---@param preset string Варианты: "damage", "heal", "spell", "mana"
function TextTag:Preset(preset)
    if preset == "damage" then
        self:SetColor(255, 0, 0, 20)
    elseif preset == "heal" then
        self:SetColor(0, 255, 0, 20)
    elseif preset == "spell" then
        self:SetColor(255, 180, 0, 20)
    elseif preset == "mana" then
        self:SetColor(0, 100, 255, 20)
    end
    self:SetPosition(GetRandomInt(20, 40))
    self:SetSize(10)
    self:Permanent(false)
    self:SetVelocity(50, GetRandomInt(50, 130))
    self:SetLifespan(3.)
end

--- Установить время жизни текста
---@param lifespan real
function TextTag:SetLifespan(lifespan)
    SetTextTagLifespan(self.texttag, lifespan)
end

--- Установить направление перемещения текста
---@param speed real Скорость перемещения
---@param angle real Угол направления
function TextTag:SetVelocity(speed, angle)
    SetTextTagVelocityBJ(self.texttag, speed, angle)
end

function TextTag:SetColor(red, green, blue, transparency)
    SetTextTagColor(self.texttag, red, green, blue, PercentTo255(100.0 - transparency))
end

function TextTag:SetSize(size)
    self.text_height = TextTagSize2Height(size)
    SetTextTagText(self.texttag, self.text, self.text_height)
end

function TextTag:SetPosition(zoffset)
    SetTextTagPosUnit(self.texttag, self.unit, zoffset)
end

--- Установить или снять перманентность
---@param flag boolean
function TextTag:Permanent(flag)
    SetTextTagPermanent(self.texttag, flag)
end

--- Уничтожить текст
function TextTag:Destroy()
    DestroyTextTag(self.texttag)
end