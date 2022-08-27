
--- Класс для создания фреймов
---@param name string Название fdf-шаблона
---@param owner framehandle Хэндл родителя
---@param simple boolean Создать простой фрейм
Frame = {}
Frame.__index = Frame

setmetatable(Frame, {
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        if #table.pack(...) == 1 and
                type(table.pack(...)[1]) == "userdata" then
            self.frame = ...
        else
            self:_init(...)
        end
        return self
    end,
})

function Frame:_init(name, owner, simple)
    owner = owner or self:GetOriginFrame()
    if simple then
        self.frame = BlzCreateSimpleFrame(name, owner, 0, 0)
    else
        self.frame = BlzCreateFrame(name, owner, 0, 0)
    end
    self.drop = false
end

-- Presets

--- Создать каст-бар
---@param cd real Время каста
---@param spell string Название способности
---@param unit Unit Юнит, кастующий способность
---@return nil
function Frame:CastBar(cd, spell, unit)
    local period = 0.05
    self.drop = false
    self.frame = BlzCreateFrame("Castbar", self:GetOriginFrame(), 0, 0)
    local castbar_label = BlzGetFrameByName("CastbarLabel", 0)
    BlzFrameSetText(castbar_label, spell)
    self:SetAbsPoint(FRAMEPOINT_CENTER, 0.3, 0.15)

    self:SetScale(1)
    self:SetModel("ui/feedback/progressbar/timerbar.mdx")

    local amount = period * 100 / cd
    local full = 0

    -- местоположение юнита
    local point = Point(GetLocationX(unit:GetLoc()), GetLocationY(unit:GetLoc()))
    local new_point

    -- хак, чтобы каст бар отображался корректно
    self:SetValue(0)
    TimerStart(CreateTimer(), period, true, function()
        full = full + amount
        -- новое местоположение
        new_point = Point(GetLocationX(unit:GetLoc()), GetLocationY(unit:GetLoc()))
        self:SetValue(full)
        if not point:atPoint(new_point, false) then
            self.drop = true
        end
        if full >= 100 or self.drop then
            DestroyTimer(GetExpiredTimer())
            self:Destroy()
            full = 0
        end
    end)
end

-- Setters

--- Установить уровень приоритетности
---@param level integer
---@return nil
function Frame:SetLevelPriority(level)
    BlzFrameSetLevel(self.frame, level)
end

--- Привязать фрейм по абсолютным координатам
---@param point framepointtype
---@param x real
---@param y real
---@return nil
function Frame:SetAbsPoint(point, x, y)
    BlzFrameSetAbsPoint(self.frame, point, x, y)
end

--- Установить размер границ фрейма
---@param width real Ширина
---@param height real Высота
---@return nil
function Frame:SetSize(width, height)
    BlzFrameSetSize(self.frame, width, height)
end

--- Установить размер фрейма
---@param scale real
---@return nil
function Frame:SetScale(scale)
    BlzFrameSetScale(self.frame, scale)
end

--- Установить модель
---@param model string
---@return nil
function Frame:SetModel(model)
    BlzFrameSetModel(self.frame, model, 0)
end

--- Установить текстуру
---@param texture string Путь до текстуры
---@return nil
function Frame:SetTexture(texture)
    BlzFrameSetTexture(self.frame, texture, 0, true)
end

--- Установить значение фрейму
---@param value real
---@return nil
function Frame:SetValue(value)
    BlzFrameSetValue(self.frame, value)
end

--- Установить текст фрейму
---@param text string
---@return nil
function Frame:SetText(text)
    BlzFrameSetText(self.frame, text)
end

--- Установить тултип на фрейм
---@param tooltip framehandle
---@return nil
function Frame:SetTooltip(tooltip)
    BlzFrameSetTooltip(self.frame, tooltip:GetHandle())
end

-- Getters

--- Получить главный фрейм
---@return framehandle
function Frame:GetOriginFrame()
    return BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)
end

--- Получить хэндл фрейма по имени
---@param name string
---@return framehandle
function Frame:GetFrameByName(name)
    return BlzGetFrameByName(name, 0)
end

--- Возвращает значение фрейма. Возможна десинхронизация!
---@return real
function Frame:GetValue()
    return BlzFrameGetValue(self.frame)
end

--- Получить текст фрейма. Возможна десинхронизация!
---@return string
function Frame:GetText()
    return BlzFrameGetText(self.text)
end

--- Получить хэндл фрейма
---@return framehandle
function Frame:GetHandle()
    return self.frame
end

-- Removers

--- Сброс анимации фрейма
---@return nil
function Frame:Drop()
    self.drop = true
end

--- Проверить сброшена ли анимация фрейма
---@return boolean
function Frame:IsDrop()
    return self.drop
end

--- Удалить фрейм
---@return nil
function Frame:Destroy()
    BlzDestroyFrame(self.frame)
end
