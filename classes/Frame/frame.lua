-- Copyright (c) meiso

--- Класс создания фреймов
---@param name string Название фрейма из fdf-шаблона
---@param owner framehandle Хэндл родителя. По умолчанию главный фрейм
---@param simple boolean Создать простой фрейм. По умолчанию false
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

--- Конструктор класса
function Frame:_init(name, owner, simple)
    local own = owner or self:GetOriginFrame()
    if simple then
        self.frame = BlzCreateSimpleFrame(name, own, 0, 0)
    else
        self.frame = BlzCreateFrame(name, own, 0, 0)
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

    -- хак, чтобы кастбар отображался корректно
    self:SetValue(0)
    TimerStart(CreateTimer(), period, true, function()
        full = full + amount
        -- новое местоположение
        new_point = Point(GetLocationX(unit:GetLoc()), GetLocationY(unit:GetLoc()))
        self:SetValue(full)
        -- проверяем двинулся ли игрок, если да - дропаем кастбар
        if not point:atPoint(new_point, false) then
            self.drop = true
        end
        -- завершаем анимацию если кастбар завершился успешно или был сброшен
        if full >= 100 or self.drop then
            DestroyTimer(GetExpiredTimer())
            self:Destroy()
            full = 0
        end
    end)
end

-- Setters

--- Установить уровень приоритетности
---@param level integer Уровень от 0
---@return nil
function Frame:SetLevelPriority(level)
    BlzFrameSetLevel(self.frame, level)
end

--- Привязать фрейм по абсолютным координатам
---@param point framepointtype Точка, которой будет привязан фрейм
---@param x real Значение x-координаты
---@param y real Значение y-координаты
---@return nil
function Frame:SetAbsPoint(point, x, y)
    BlzFrameSetAbsPoint(self.frame, point, x, y)
end

--- Привязать фрейм относительно другого фрейма
---@param point framepointtype Точка фрейма, которой он будет привязан к другому фрейму
---@param relative framehandle Фрейм, к которому будет привязка
---@param relative_point framepointtype Точка, привязываемого фрейма
---@param x real Значение x-координаты
---@param y real Значение y-координаты
---@return nil
function Frame:SetPoint(point, relative, relative_point, x, y)
    local r = relative
    if type(relative) == "table" then
        r = relative:GetHandle()
    end
    BlzFrameSetPoint(self.frame, point, r, relative_point, x, y)
end

--- Установить размер границ фрейма
---@param width real Ширина
---@param height real Высота
---@return nil
function Frame:SetSize(width, height)
    BlzFrameSetSize(self.frame, width, height)
end

--- Установить размер фрейма
---@param scale real Значение размера
---@return nil
function Frame:SetScale(scale)
    BlzFrameSetScale(self.frame, scale)
end

--- Установить модель
---@param model string Название модели
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
---@param value real Число
---@return nil
function Frame:SetValue(value)
    BlzFrameSetValue(self.frame, value)
end

--- Установить текст фрейму
---@param text string Строка
---@return nil
function Frame:SetText(text)
    BlzFrameSetText(self.frame, text)
end

--- Привязать тултип к фрейму
---@param title string Заголовок
---@param text string Содержимое
---@return nil
function Frame:SetTooltip(title, text)
    local tooltip = Frame("Tooltip", self:GetHandle())
    local tooltip_title = Frame("TooltipTitle", tooltip:GetHandle())
    local tooltip_context = Frame("TooltipContext", tooltip:GetHandle())
    BlzFrameSetTooltip(self.frame, tooltip:GetHandle())
    -- крепим точки тултипа относительно текста,
    -- дабы тултип мог расширяться
    tooltip:SetPoint(FRAMEPOINT_TOPRIGHT, tooltip_context, FRAMEPOINT_TOPRIGHT, 0.005, 0.005)
    tooltip:SetPoint(FRAMEPOINT_BOTTOMLEFT, tooltip_context, FRAMEPOINT_BOTTOMLEFT, -0.005, -0.005)
    tooltip_title:SetPoint(FRAMEPOINT_TOPLEFT, tooltip, FRAMEPOINT_TOPLEFT, 0.005, -0.005)
    tooltip_context:SetPoint(FRAMEPOINT_TOPLEFT, self.frame, FRAMEPOINT_TOPRIGHT, 0.01, -0.025)
    tooltip_title:SetText(title)
    tooltip_context:SetText(text)
    tooltip:SetPoint(FRAMEPOINT_TOPLEFT, self.frame, FRAMEPOINT_TOPRIGHT, 0.005, 0.005)
end

-- Getters

--- Получить главный фрейм
---@return framehandle
function Frame:GetOriginFrame()
    return BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)
end

--- Получить хэндл фрейма по имени
---@param name string Название фрейма из fdf-шаблона
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

--- Возвращает имя фрейма
---@return string
function Frame:GetName()
    return BlzFrameGetName(self.frame)
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

-- Meta

--- Отключить фрейм
---@return nil
function Frame:Disable()
    BlzFrameSetEnable(self.frame, false)
end

--- Включить фрейм
---@return nil
function Frame:Enable()
    BlzFrameSetEnable(self.frame, true)
end
