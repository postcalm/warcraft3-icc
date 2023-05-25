gg_trg_EntryPoint = nil
gg_trg_Alert = nil
gg_trg_RespawnHero = nil
function InitGlobals()
end

--CUSTOM_CODE
-- Copyright (c) meiso

--Paladin
JUDGEMENT_OF_LIGHT_BUFF = FourCC("B002")
JUDGEMENT_OF_WISDOM_BUFF = FourCC("B003")

--Priest
PRAYER_OF_FORTITUDE_BUFF = FourCC("B006")


-- Copyright (c) meiso

Items = {}
Items["ARMOR_ITEM"]                 = FourCC("I001")
Items["ATTACK_ITEM"]                = FourCC("I000")
Items["HP_ITEM"]                    = FourCC("I002")
Items["MAGICARMOR_ITEM"]            = FourCC("I003")
Items["DEC_DMG_ITEM"]               = FourCC("I004")
Items["BLESSING_OF_WISDOM_ITEM"]    = FourCC("I005")
Items["MP_ITEM"]                    = FourCC("I006")
Items["PRAYER_OF_FORTITUDE_ITEM"]   = FourCC("I007")


ItemsSpells = {}
ItemsSpells["ARMOR_500"]          = { int = FourCC("A008"), str = "A008" }
ItemsSpells["ATTACK_1500"]        = { int = FourCC("A007"), str = "A007" }
ItemsSpells["HP_90K"]             = { int = FourCC("A00D"), str = "A00D" }
ItemsSpells["MAGICARMOR_500"]     = { int = FourCC("A00I"), str = "A00I" }
ItemsSpells["DECREASE_DMG"]       = { int = FourCC("A00K"), str = "A00K" }
ItemsSpells["BLESSING_OF_WISDOM"] = { int = FourCC("A00F"), str = "A00F" }
ItemsSpells["MP_50K"]             = { int = FourCC("A00W"), str = "A00W" }
ItemsSpells["HP_165_POF"]         = { int = FourCC("A010"), str = "A010" }

-- Copyright (c) meiso

--- Метр. Равен 20 игровым единицам
METER = 20

--- Сила атаки
AP = 1.

--- Сила заклинаний
SPD = 1.

--- Урон в секунду
DPS = 3.5

-- Ловкость
--AGILITY = 1
--
-- Интеллект
--INTELLECT = 1
--
-- Сила
--STRENGTH = 1.

-- Copyright (c) meiso

--Lord Marrowgar
BONE_SPIKE_OBJ = FourCC('h000')

--Common
DUMMY       = FourCC('h002')
SPELL_DUMMY = FourCC('h001')
DUMMY_EQUIP = FourCC('e000')

-- Copyright (c) meiso

PLAYER_1   = Player(0)
PLAYER_2   = Player(1)
LICH_KING  = Player(10)

COMMON_TIMER = FourCC("BTLF")
ARROW_MODEL = "Abilities\\Spells\\Other\\Aneu\\AneuCaster.mdl"
CHANNEL_EFFECT = "Abilities\\Spells\\Undead\\DeathPact\\DeathPactTarget.mdl"

-- Copyright (c) meiso
Paladin = {
    hero = nil,
    consecration_effect = nil,
}

Priest = {
    hero = nil,
}

DeathKnight = {
    hero = nil,
    blood_runes = 2,
    frost_runes = 2,
    unholy_runes = 2,
    death_runes = 0,
}

LordMarrowgar = {
    unit = nil,
    coldflame = nil,
    coldflame_effect = false,
    bonespike_effect = false,
    whirlwind_effect = false,
}

LadyDeathwhisper = {
    unit = nil,
    mana_shield = nil,
    mana_is_over = false,
    dominate_mind_effect = false,
    death_and_decay_effect = false,
    phase = 1,
}

CultAdherent = {
    unit = nil,
    summoned = false,
    morphed = false,
}

CultFanatic = {
    unit = nil,
    summoned = false,
    morphed = false,
}

--- Кэш для системы экипировки
EQUIP_CACHE = nil

-- Copyright (c) meiso

--Lord Marrowgar
COLDFLAME               = FourCC("A001")
WHIRLWIND               = FourCC("A005")

--Paladin
DIVINE_SHIELD           = FourCC("AHds")
CONSECRATION            = FourCC("A00A")
HAMMER_RIGHTEOUS        = FourCC("A00B")
BLESSING_OF_KINGS       = FourCC("A00C")
BLESSING_OF_SANCTUARY   = FourCC("A00H")
BLESSING_OF_WISDOM      = FourCC("A00G")
BLESSING_OF_MIGHT       = FourCC("A00M")
CRUSADER_AURA           = FourCC("A00J")
JUDGEMENT_OF_LIGHT      = FourCC("A00N")
JUDGEMENT_OF_LIGHT_TR   = FourCC("A00P")
JUDGEMENT_OF_WISDOM     = FourCC("A00O")
JUDGEMENT_OF_WISDOM_TR  = FourCC("A00Q")
SHIELD_OF_RIGHTEOUSNESS = FourCC("A00R")
AVENGERS_SHIELD         = FourCC("A004")
SPELLBOOK_PALADIN       = FourCC("A00L")

--Priest
FLASH_HEAL              = FourCC("A00S")
RENEW                   = FourCC("A00T")
CIRCLE_OF_HEALING       = FourCC("A00U")
PRAYER_OF_MENDING       = FourCC("A009")
POWER_WORD_SHIELD       = FourCC("A00V")
GUARDIAN_SPIRIT         = FourCC("A00X")
SPELLBOOK_PRIEST        = FourCC("A00Y")
PRAYER_OF_FORTITUDE     = FourCC("A00Z")

-- Copyright (c)  meiso

--- Аналог python функции zip().
--- Объединяет в таблицы элементы из последовательностей переданных в качестве аргументов
function zip(...)
    local args = table.pack(...)
    local array = {}
    local len = #args[1]

    --опеределяем самую маленькую последовательность
    for i = 1, args.n do
        if #args[i] < len then
            len = #args[i]
        end
    end

    for i = 1, len do
        local array_mini = {}
        for j = 1, args.n do
            table.insert(array_mini, args[j][i])
        end
        table.insert(array, array_mini)
    end
    return array
end

--- Разбивает строку по разделителю
---@param inputstr string Строка
---@param sep string Разделитель. По умолчанию пробел
---@return table
function split(inputstr, sep)
    local s = sep or " "
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. s .. "]+)") do
        table.insert(t, str)
    end
    return t
end

--- Загружает toc-файл
---@param file string Путь до toc-файла
---@return nil
function loadTOCFile(file)
    if not BlzLoadTOCFile(file) then
        print("Failed to load: ", file)
    end
end

--- Округляет число
---@param number number
---@return number
function round(number)
    return number >= 0 and math.floor(number + 0.5) or math.ceil(number - 0.5)
end

--- Проверяет, является ли объектом типом "table"
---@param object type Проверяемый объект
---@return boolean
function isTable(object)
    return type(object) == "table"
end

-- Copyright (c) meiso

--Bosses
LORD_MARROWGAR      = FourCC("U001")
LADY_DEATHWHISPER   = FourCC("U000")
--mobs
--adds
CULT_ADHERENT       = FourCC("u002")
CULT_ADHERENT_MORPH = FourCC("u003")
CULT_FANATIC        = FourCC("h003")
CULT_FANATIC_MORPH  = FourCC("h004")

--tanks
PALADIN             = FourCC("Hpal")
DEATH_KNIGHT        = FourCC("Udea")
WARRIOR             = nil
--damage dealers
WARLOCK             = nil
HUNTER              = nil
ROGUE               = nil
MAGE                = nil
--healers
DRUID               = nil
SHAMAN              = nil
PRIEST              = FourCC("Hblm")

-- Copyright (c) meiso

--- Класс конфигурирования способностей
---@param ability ability Способность
---@param tooltip string Название способности
---@param text string Описание способности
---@param icon string Иконка
---@param buff_tooltip string Название бафа
---@param buff_desc string Описание бафа
Ability = {}
Ability.__index = Ability

setmetatable(Ability, {
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
    end,
})

--- Конструктор класса
function Ability:_init(ability, tooltip, text, icon, buff_tooltip, buff_desc)
    self.ability = ability
    self.tooltip = tooltip
    self.text = text
    self.icon = icon
    self.buff_tooltip = buff_tooltip or tooltip
    self.buff_desc = buff_desc or text
end

--- Проинициализировать способность.
---Задать тултип, описание и иконку
function Ability:Init()
    self:SetTooltip()
    self:SetText()
    self:SetIcon()
end

--- Установить название для способности
---@param tooltip string
---@return nil
function Ability:SetTooltip(tooltip)
    local t = tooltip or self.tooltip
    BlzSetAbilityTooltip(self.ability, t, 0)
end

--- Установить описание для способности
---@param text string
---@return nil
function Ability:SetText(text)
    local t = text or self.text
    BlzSetAbilityExtendedTooltip(self.ability, t, 0)
end

--- Установить иконку способности
---@param icon string Путь до текстуры
---@return nil
function Ability:SetIcon(icon)
    local i = icon or self.icon
    BlzSetAbilityIcon(self.ability, i)
end

function Ability:SpellCasted()
    return GetSpellAbilityId() == self.ability
end

--- Вернуть идентификатор способности
---@return ability
function Ability:GetId()
    return self.ability
end

-- Copyright (c) meiso

--- Класс создания эффектов на юнитах
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

-- Copyright (c) meiso

--- Базовый класс событий
Events = {}
Events.__index = Events

--Обёртка над конструктором класса
setmetatable(Events, {
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
    end,
})

--- Конструктор класса
function Events:_init()
    self.trigger = CreateTrigger()
end

--- Добавляет условие для выполнения события
---@param func function Функция, возвращающая bool или boolexpr
---@return nil
function Events:AddCondition(func)
    TriggerAddCondition(self.trigger, Condition(func))
end

--- Добавляет действие для события
---@param func function Функция, запускающаяся после срабатывания события
---@return nil
function Events:AddAction(func)
    TriggerAddAction(self.trigger, func)
end

--- Отключает триггер
---@return nil
function Events:DisableTrigger()
    DisableTrigger(self.trigger)
end

--- Включает триггер
---@return nil
function Events:EnableTrigger()
    EnableTrigger(self.trigger)
end

--- Уничтожает триггер
---@return nil
function Events:Destroy()
    DestroyTrigger(self.trigger)
end

-- Copyright (c) meiso

--- Класс регистрации событий фрейма
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

-- Copyright (c) meiso

--- Класс регистрации событий игрока
---@param player playerid Id игрока. По умолчанию - локальный игрок
EventsPlayer = {}
EventsPlayer.__index = EventsPlayer

setmetatable(EventsPlayer, {
    __index = Events,
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
    end,
})

--- Конструктор класса
function EventsPlayer:_init(player)
    Events._init(self)
    self.player = player or GetLocalPlayer()
end

--- Регистриует событие нажатия кнопки мыши
---@return nil
function EventsPlayer:RegisterPlayerMouseDown()
    TriggerRegisterPlayerEvent(self.trigger, self.player, EVENT_PLAYER_MOUSE_DOWN)
end

--- Регистриует событие, написания в чат
---@param text string Сообщение, которое необходимо отследить
---@param exact boolean Проверять как точное вхождение
---@return nil
function EventsPlayer:RegisterChatEvent(text, exact)
    local e = exact or false
    TriggerRegisterPlayerChatEvent(self.trigger, self.player, text, e)
end

function EventsPlayer:RegisterUnitAttacked()
    TriggerRegisterPlayerUnitEvent(self.trigger, self.player, EVENT_PLAYER_UNIT_ATTACKED, nil)
end

--- Регистриует событие каста способности юнитом игрока
---@return nil
function EventsPlayer:RegisterUnitSpellCast()
    TriggerRegisterPlayerUnitEvent(self.trigger, self.player, EVENT_PLAYER_UNIT_SPELL_CAST, nil)
end

--- Регистриует событие нанесения урона юнитом игрока
---@return nil
function EventsPlayer:RegisterUnitDamaging()
    TriggerRegisterPlayerUnitEvent(self.trigger, self.player, EVENT_PLAYER_UNIT_DAMAGING, nil)
end

--- Регистриует событие получения урона юнитом игрока
---@return nil
function EventsPlayer:RegisterUnitDamaged()
    TriggerRegisterPlayerUnitEvent(self.trigger, self.player, EVENT_PLAYER_UNIT_DAMAGED, nil)
end

--- Регистриует событие смерти юнита игрока
---@return nil
function EventsPlayer:RegisterUnitDeath()
    TriggerRegisterPlayerUnitEvent(self.trigger, self.player, EVENT_PLAYER_UNIT_DEATH, nil)
end

--- Регистриует собыие призыва юнита игрока
---@return nil
function EventsPlayer:RegisterUnitSummon()
    TriggerRegisterPlayerUnitEvent(self.trigger, self.player, EVENT_PLAYER_UNIT_SUMMON, nil)
end

-- далее идут бессмысленные обёртки над методами родителя
-- и нужны только для того, чтобы методы показывались в IDE

--- Добавляет условие для выполнения события
---@param func function Функция, возвращающая bool или boolexpr
---@return nil
function EventsPlayer:AddCondition(func)
    Events.AddCondition(self, func)
end

--- Добавляет действие для события
---@param func function Функция, запускающаяся после срабатывания события
---@return nil
function EventsPlayer:AddAction(func)
    Events.AddAction(self, func)
end

--- Отключает триггер
---@return nil
function EventsPlayer:DisableTrigger()
    Events.DisableTrigger(self)
end

--- Включает триггер
---@return nil
function EventsPlayer:EnableTrigger()
    Events.EnableTrigger(self)
end

--- Уничтожает триггер
---@return nil
function EventsPlayer:Destroy()
    Events.Destroy(self)
end

-- Copyright (c) meiso

--- Класс регистрации событий юнита
---@param unit unit Id юнита или юнит от класса Unit
EventsUnit = {}
EventsUnit.__index = EventsUnit

setmetatable(EventsUnit, {
    __index = Events,
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
    end,
})

--- Конструктор класса
function EventsUnit:_init(unit)
    Events._init(self)
    self.unit = unit
    if isTable(unit) then
        self.unit = unit:GetId()
    end
end

--- Регистриует событие получения урона юнитом (после вычета брони)
---@return nil
function EventsUnit:RegisterDamaged()
    TriggerRegisterUnitEvent(self.trigger, self.unit, EVENT_UNIT_DAMAGED)
end

--- Регистриует событие получения урона юнитом (до вычета брони)
---@return nil
function EventsUnit:RegisterDamaging()
    TriggerRegisterUnitEvent(self.trigger, self.unit, EVENT_UNIT_DAMAGING)
end

--- Регистриует событие, когда юнит в бою
---@return nil
function EventsUnit:RegisterAttacked()
    TriggerRegisterUnitEvent(self.trigger, self.unit, EVENT_UNIT_ATTACKED)
end

function EventsUnit:RegisterWithinRange(range)
    TriggerRegisterUnitInRange(self.trigger, self.unit, range * METER, nil)
end

function EventsUnit:RegisterUnitLife(life)
    TriggerRegisterUnitLifeEvent(self.trigger, self.unit, GREATER_THAN_OR_EQUAL, life)
end

-- далее идут бессмысленные обёртки над методами родителя
-- и нужны только для того, чтобы методы показывались в IDE

--- Добавляет условие для выполнения события
---@param func function Функция, возвращающая bool или boolexpr
---@return nil
function EventsUnit:AddCondition(func)
    Events.AddCondition(self, func)
end

--- Добавляет действие для события
---@param func function Функция, запускающаяся после срабатывания события
---@return nil
function EventsUnit:AddAction(func)
    Events.AddAction(self, func)
end

--- Отключает триггер
---@return nil
function EventsUnit:DisableTrigger()
    Events.DisableTrigger(self)
end

--- Включает триггер
---@return nil
function EventsUnit:EnableTrigger()
    Events.EnableTrigger(self)
end

--- Уничтожает триггер
---@return nil
function EventsUnit:Destroy()
    Events.Destroy(self)
end

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
        self.frame = BlzCreateSimpleFrame(name, own, 0, self:GetContext())
    else
        self.frame = BlzCreateFrame(name, own, 0, self:GetContext())
    end
    self.drop = false
end

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
    if isTable(relative) then
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

--- Задать ширину фрейма
---@param value real Значение ширины
---@return nil
function Frame:SetWidth(value)
    BlzFrameSetSize(self.frame, value, self:GetHeight())
end

--- Задать высоту фрейма
---@param value real Значение высоты
---@return nil
function Frame:SetHeight(value)
    BlzFrameSetSize(self.frame, self:GetWidth(), value)
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

--- Получить главный фрейм
---@return framehandle
function Frame:GetOriginFrame()
    return BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)
end

--- Получить хэндл фрейма по имени
---@param name string Название фрейма из fdf-шаблона
---@return framehandle
function Frame:GetFrameByName(name)
    return BlzGetFrameByName(name, self:GetContext())
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

--- Получить "контекст" фрейма.
---По сути возвращает ID игрока
---@return integer
function Frame:GetContext()
    return GetHandleId(GetLocalPlayer())
end

--- Получить высоту фрейма
---@return integer
function Frame:GetHeight()
    return BlzFrameGetHeight(self.frame)
end

--- Получить ширину фрейма
---@return integer
function Frame:GetWidth()
    return BlzFrameGetWidth(self.frame)
end

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

--- Скрыть фрейм
---@return nil
function Frame:Hide()
    BlzFrameSetVisible(self.frame, false)
end

--- Показать фрейм
---@return nil
function Frame:Show()
    BlzFrameSetVisible(self.frame, true)
end

--- Created by meiso.

Line = {}
Line.__index = Line

setmetatable(Line, {
    __index = Point,
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
    end,
})

function Line:_init(point1, point2)
    self.point1 = point1 or 0
    self.point2 = point2 or 0
end

--- Возвращает количество точек на линии
---@param quantity integer
function Line:getPoints(quantity)
    local new_points = {}
    local points = {}
    quantity = quantity or 1
    local ydiff, xdiff = self.point2.Y - self.point1.Y,
                         self.point2.X - self.point1.X
    local slope = (ydiff) / (xdiff)
    local x, y

    for i = 1, quantity do
        if slope == 0 then
            y = 0
        else
            y = ydiff * (i / quantity)
        end

        if slope == 0 then
            x = xdiff * (i / quantity)
        else
            x = y / slope
        end

        points = Point(
                round(x) + self.point1.X,
                round(y) + self.point1.Y
        )
        table.insert(new_points, i, points:get2DPoint())
    end
    table.insert(new_points, 1, self.point1:get2DPoint())
    return new_points
end

function Line:getLength()
    local x = (self.point2.X - self.point1.X) ^ 2
    local y = (self.point2.Y - self.point1.Y) ^ 2
    local len = math.sqrt(x + y)
    return len
end


-- Copyright (c) meiso

--- Класс создания точек
---@param X real Координата X. По умолчанию 0
---@param Y real Координата Y. По умолчанию 0
---@param Z real Координата Z. По умолчанию 0
Point = {}
Point.__index = Point

setmetatable(Point, {
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
    end,
})

--- Конструктор класса
function Point:_init(X, Y, Z)
    self.X = X or 0.
    self.Y = Y or 0.
    self.Z = Z or 0.
end

function Point:get2DPoint()
    return { self.X, self.Y }
end

function Point:get3DPoint()
    return { self.X, self.Y, self.Z }
end

--- Проверяет равны ли указанные точки
---@param point Point
---@param inaccuracy boolean Учитывать ли погрешность
---@return boolean
function Point:atPoint(point, inaccuracy)
    if not inaccuracy then
        inaccuracy = 0
    else
        inaccuracy = 30.
    end
    if math.abs(self.X - point.X) <= inaccuracy and
            math.abs(self.Y - point.Y) <= inaccuracy then
        return true
    end
    return false
end

-- Copyright (c) meiso

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

--- Конструктор класса
function TextTag:_init(text, unit, zoffset, size, red, green, blue, transparency)
    self.texttag = CreateTextTag()
    self.text_height = 0
    self.zoffset = 0
    self.text = text
    self.unit = unit
    -- неявное приведение к int
    if type(text) == "number" then
        self.text = I2S(text // 1)
    end
    if isTable(unit) then
        self.unit = unit:GetId()
    end

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
---@return nil
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
---@return nil
function TextTag:SetLifespan(lifespan)
    SetTextTagLifespan(self.texttag, lifespan)
end

--- Установить направление перемещения текста
---@param speed real Скорость перемещения
---@param angle real Угол направления
---@return nil
function TextTag:SetVelocity(speed, angle)
    SetTextTagVelocityBJ(self.texttag, speed, angle)
end

--- Установить цвет тексту
---@param red integer Интенсивность красного
---@param green integer Интенсивность зеленого
---@param blue integer Интенсивность синего
---@param transparency integer Уровень прозрачноти
---@return nil
function TextTag:SetColor(red, green, blue, transparency)
    SetTextTagColor(self.texttag, red, green, blue, PercentTo255(100.0 - transparency))
end

--- Установить размер текста
---@param size real Значение размера
---@return nil
function TextTag:SetSize(size)
    self.text_height = TextTagSize2Height(size)
    SetTextTagText(self.texttag, self.text, self.text_height)
end

--- Расположить текст относительно юнита
---@param zoffset real Значение оси-z
---@return nil
function TextTag:SetPosition(zoffset)
    SetTextTagPosUnit(self.texttag, self.unit, zoffset)
end

--- Установить или снять перманентность
---@param flag boolean
---@return nil
function TextTag:Permanent(flag)
    SetTextTagPermanent(self.texttag, flag)
end

--- Уничтожить текст
---@return nil
function TextTag:Destroy()
    DestroyTextTag(self.texttag)
end


Timer = {}
Timer.__index = Timer

setmetatable(Timer, {
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
    end,
})

---@param timeout real
---@param func function
function Timer:_init(timeout, func)
    self.timer = CreateTimer()
    self.timeout = timeout
    self.func = function() func() end
end

--- Запустить таймер
function Timer:Start()
    TimerStart(self.timer, self.timeout, false, self.func())
end

--- Уничтожить таймер
function Timer:Destroy()
    DestroyTimer(self.timer)
end

-- Copyright (c) meiso

--- Класс создания юнита
---@param player player Игрок-владелец
---@param unit_id unit Raw-code, создаваемого юнита
---@param location location Позиция, в которой требуется создать юнита
---@param face real Угол поворота юнита
Unit = {}
Unit.__index = Unit

setmetatable(Unit, {
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        if #table.pack(...) == 1 then
            self.unit = ...
        else
            self:_init(...)
        end
        return self
    end,
})

--- Конструктор класса
function Unit:_init(player, unit_id, location, face)
    local x = GetLocationX(location)
    local y = GetLocationY(location)
    local f = face or GetRandomDirectionDeg()
    self.basemana = 0
    self.unit = CreateUnit(player, unit_id, x, y, f)
end

-- Всё что связано с уроном

--- Выставить базовый урон
---@param value integer Урон
---@param index integer Номер атаки. 0 (первая) или 1 (вторая)
---@return nil
function Unit:SetBaseDamage(value, index)
    local i = index or 0
    BlzSetUnitBaseDamage(self.unit, value, i)
end

--- Нанести физический урон.
--- Урон снижается как от количества защиты, так и от её типа
---@param target unit Цель
---@param damage real Урон
---@param attack_type attacktype Тип атаки. По умолчанию ближняя
---@return nil
function Unit:DealPhysicalDamage(target, damage, attack_type)
    local t = attack_type or ATTACK_TYPE_MELEE
    local u = target
    if isTable(target) then
        u = target:GetId()
    end
    UnitDamageTargetBJ(self.unit, u, damage, t, DAMAGE_TYPE_NORMAL)
end

--- Нанести физический урон, проходящий через защиту.
--- Урон снижается только от типа защиты
---@param target unit Цель
---@param damage real Урон
---@param attack_type attacktype Типа атаки. По умолчанию ближняя
---@return nil
function Unit:DealUniversalDamage(target, damage, attack_type)
    local t = attack_type or ATTACK_TYPE_MELEE
    local u = target
    if isTable(target) then
        u = target:GetId()
    end
    UnitDamageTargetBJ(self.unit, u, damage, t, DAMAGE_TYPE_UNIVERSAL)
end

--- Нанести магической урон.
--- Урон снижается "сопротивлением от магии"
---@param target unit Цель
---@param damage real Урон
---@return nil
function Unit:DealMagicDamage(target, damage)
    local u = target
    if isTable(target) then
        u = target:GetId()
    end
    BattleSystem.disable = true
    UnitDamageTargetBJ(self.unit, u, damage, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC)
    TextTag(damage, self.unit):Preset("spell")
    BattleSystem.disable = false
end

--- Нанести магической урон по площади.
--- Урон снижается "сопротивлением от магии"
---@param damage real Урон
---@param overtime real Частота нанесения урона
---@param location location Место нанесения урона
---@param radius real Радиус в метрах
---@return nil
function Unit:DealMagicDamageLoc(args)
    local meters = METER * args.radius
    local ot = args.overtime or 0.
    local group = GetUnitsInRangeOfLocAll(meters, args.location)

    local function act()
        local u = GetEnumUnit()
        if self:IsEnemy(u) then
            self:DealMagicDamage(u, args.damage)
        end
    end
    ForGroupBJ(group, act)
    TriggerSleepAction(ot)
    DestroyGroup(group)
end

--- Нанести магический урон, проходящий через иммунитет к магии.
--- Урон игнорирует иммунитет к магии, но снижается "сопротивляемостью к магии"
---@param target unit Цель
---@param damage real Урон
---@return nil
function Unit:DealUniversalMagicDamage(target, damage)
    local u = target
    if isTable(target) then
        u = target:GetId()
    end
    UnitDamageTargetBJ(self.unit, u, damage, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL)
end

--- Нанести смешанный урон.
--- Урон снижается и от защиты, и от сопротивления к магии
---@param target unit Цель
---@param damage real Урон
---@return nil
function Unit:DealMixedDamage(target, damage)
    local u = target
    if isTable(target) then
        u = target:GetId()
    end
    UnitDamageTargetBJ(self.unit, u, damage, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL)
end

--- Нанести чистый урон.
--- Не снижается защитой
---@param target unit Цель
---@param damage real Урон
---@return nil
function Unit:DealCleanDamage(target, damage)
    local u = target
    if isTable(target) then
        u = target:GetId()
    end
    UnitDamageTargetBJ(self.unit, u, damage, ATTACK_TYPE_CHAOS, DAMAGE_TYPE_UNIVERSAL)
end

-- Способности

--- Выдать юниту указанные способности
---@param ability ability Список способностей (через запятую)
---@return nil
function Unit:AddAbilities(...)
    local abilities = table.pack(...)
    for _, ability in ipairs(abilities) do
        UnitAddAbility(self.unit, ability)
    end
end

--- Удалить у юнита указанные способности
---@param ability ability Список способностей (через запятую)
---@return nil
function Unit:RemoveAbilities(...)
    local abilities = table.pack(...)
    for _, ability in ipairs(abilities) do
        UnitRemoveAbility(self.unit, ability)
    end
end

--- Выдать книгу заклинаний
---@param spellbook spellbook Id книги заклинаний
---@return nil
function Unit:AddSpellbook(spellbook)
    local p = GetOwningPlayer(self.unit)
    if not spellbook then
        return
    end
    UnitAddAbility(self.unit, spellbook)
    UnitMakeAbilityPermanent(self.unit, true, spellbook)
    SetPlayerAbilityAvailable(p, spellbook, true)
end

--- Применить способность
---@param ability string Id способности
---@return nil
function Unit:UseAbility(ability)
    IssueImmediateOrder(self.unit, ability)
end

--- Использовать заклинание по цели
---@param spell string Id приказа
---@param target unitid Цель
---@return nil
function Unit:CastToTarget(spell, target)
    local u = target
    if isTable(target) then
        u = target:GetId()
    end
    IssueTargetOrder(self.unit, spell, u)
end

--- Установить затраты маны на способность (от базовой маны)
---@param ability ability Id способности
---@param manacost integer Затраты в процентах
---@return nil
function Unit:SetAbilityManacost(ability, manacost)
    local factor = 100
    if manacost <= 1 then
        factor = 1
    end
    local m = (self.basemana * (manacost / factor)) // 1
    BlzSetAbilityIntegerLevelField(
            BlzGetUnitAbility(self:GetId(), ability),
            ABILITY_ILF_MANA_COST,
            0,
            m
    )
end

--- Установить время восстановления у способности
---@param ability ability Id способности
---@param cooldown real Время восстановления
---@return nil
function Unit:SetAbilityCooldown(ability, cooldown)
    BlzSetAbilityRealLevelField(
            BlzGetUnitAbility(self:GetId(), ability),
            ABILITY_RLF_COOLDOWN,
            0,
            cooldown
    )
end

--- Скрыть способность у юнита
---@param ability ability ID способности
---@return nil
function Unit:HideAbility(ability)
    BlzUnitHideAbility(self.unit, ability, true)
end

--- Показать способность у юнита
---@param ability ability ID способности
---@return nil
function Unit:ShowAbility(ability)
    BlzUnitHideAbility(self.unit, ability, false)
end

--- Использовать способность-функцию
---@param func function Способность-функция
---@param location location Место применения
---@param radius real Радиус применения (в метрах)
---@return nil
function Unit:UseSpellFunc(args)
    local meters = METER * args.radius
    local group = GetUnitsInRangeOfLocAll(meters, args.location)
    ForGroupBJ(group, args.func)
    TriggerSleepAction(0.)
    DestroyGroup(group)
end

--- Проверить есть ли баф на юните
---@param buff ability Название бафа
---@return boolean
function Unit:HasBuff(buff)
    return GetUnitAbilityLevel(self.unit, buff) > 0
end

-- Мана

--- Потратить указанное количество маны
---@param mana real Количество маны в абсолютных единицах
---@param percent real Количество маны в процентах
---@param check boolean Проверять ли текущее количество маны. По умолчанию true
---@return boolean
function Unit:LoseMana(arg)
    local m = self:GetPercentManaOfMax(arg.percent) or arg.mana
    if arg.check == nil then
        arg.check = true
    end
    if m > self:GetCurrentMana() and arg.check then
        DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "Недостаточно маны")
        return false
    end
    self:SetMana(self:GetCurrentMana() - m)
    return true
end

--- Получить ману количественно или в процентах от максимума
---@param mana real Количество маны в абсолютных единицах
---@param percent real Количество маны в процентах
---@return nil
function Unit:GainMana(arg)
    local m = self:GetPercentManaOfMax(arg.percent) or arg.mana
    self:SetMana(self:GetCurrentMana() + m)
end

--- Получить процент маны от максимума
---@param percent real Количество маны в процентах
---@return real
function Unit:GetPercentManaOfMax(percent)
    if percent == nil then
        return nil
    end
    local factor = 100
    if percent <= 1 then
        factor = 1
    end
    return GetUnitState(self.unit, UNIT_STATE_MAX_MANA) * (percent / factor)
end

--- Установить текущее количество маны
---@param value real Количество маны в абсолютных величинах
---@return nil
function Unit:SetMana(value)
    SetUnitState(self.unit, UNIT_STATE_MANA, value)
end

--- Установить базовое количество маны
---@param value real Количество маны в абсолютных величинах
---@return nil
function Unit:SetBaseMana(value)
    self.basemana = value
    self:SetMana(value)
end

--- Установить максимальное значение маны
---@param value real Количество маны в абсолютных величинах
---@param full boolean Заполнить до максимума
---@return nil
function Unit:SetMaxMana(value, full)
    local f = full or false
    BlzSetUnitMaxMana(self.unit, value)
    if f then
        self:SetMana(self:GetMaxLife())
    end
end

--- Получить максимальное количество маны юнита
---@return real
function Unit:GetMaxMana()
    return BlzGetUnitMaxMana(self.unit)
end

--- Получить текущее количество маны юнита
---@return real
function Unit:GetCurrentMana()
    return GetUnitState(self.unit, UNIT_STATE_MANA)
end

--- Получить базовое количество маны
---@return real
function Unit:GetBaseMana()
    return self.basemana
end

-- Здоровье

--- Потратить указанное количество хп
---@param life real Количество хп в абсолютных величинах
---@param percent real Количество хп в процентах
---@return nil
function Unit:LoseLife(arg)
    local l = self:GetPercentLifeOfMax(arg.percent) or arg.life
    self:SetLife(self:GetCurrentLife() - l)
end

--- Дать хп количественно или в процентах от максимума
---@param life real Количество хп в абсолютных величинах
---@param percent real Количество хп в процентах
---@param show boolean Показывать ли исцеление
---@return nil
function Unit:GainLife(arg)
    local l = self:GetPercentLifeOfMax(arg.percent) or arg.life
    self:SetLife(self:GetCurrentLife() + l)
    if arg.show then
        TextTag(l, self:GetId()):Preset("heal")
    end
end

--- Получить процент хп от максимума
---@param percent real Количество хп в процентах
---@return real
function Unit:GetPercentLifeOfMax(percent)
    if percent == nil then
        return nil
    end
    local factor = 100
    if percent <= 1 then
        factor = 1
    end
    return GetUnitState(self.unit, UNIT_STATE_MAX_LIFE) * (percent / factor)
end

--- Установить текущее количество хп
---@param value real Количество хп в абсолютных величинах
---@return nil
function Unit:SetLife(value)
    SetUnitState(self.unit, UNIT_STATE_LIFE, value)
end

--- Установить максимальное значение хп
---@param value real Количество хп в абсолютных величинах
---@param full boolean Заполнить до максимума
---@return nil
function Unit:SetMaxLife(value, full)
    local f = full or false
    BlzSetUnitMaxHP(self.unit, value)
    if f then
        self:SetLife(self:GetMaxLife())
    end
end

--- Получить максимальное количество хп юнита
---@return real
function Unit:GetMaxLife()
    return BlzGetUnitMaxHP(self.unit)
end

--- Получить текущее количество хп юнита
---@return real
function Unit:GetCurrentLife()
    return GetUnitState(self.unit, UNIT_STATE_LIFE)
end

-- Передвижение

--- Установить скорость передвижения юнита
---@param movespeed real
---@return nil
function Unit:SetMoveSpeed(movespeed)
    SetUnitMoveSpeed(self.unit, movespeed)
end

--- Получить скорость передвижения юнита
---@return real
function Unit:GetMoveSpeed()
    return GetUnitMoveSpeed(self.unit)
end

--- Установить/снять прохождение через объекты
---@param flag boolean
---@return nil
function Unit:SetPathing(flag)
    SetUnitPathing(self.unit, flag)
end

--- Следовать к указанному юниту
---@param unit unit
---@return nil
function Unit:MoveToUnit(unit)
    local loc
    if isTable(unit) then
        loc = unit:GetLoc()
    else
        loc = GetUnitLoc(unit)
    end
    IssuePointOrderLoc(self.unit, "move", loc)
end

--- Следовать к указанной точке
---@param location location
---@return nil
function Unit:MoveToLoc(location)
    IssuePointOrderLoc(self.unit, "move", location)
end

--- Вернуть ближайших врагов
---@param radius real Радиус в метрах, в котором выбираются враги. Необязательный аргумент
---@param filter function Функция-фильтр
---@return group
function Unit:GetNearbyEnemies(radius, filter)
    local group = CreateGroup()
    local r = radius or 25
    local location = self:GetLoc()
    local f = Condition(filter) or nil
    GroupEnumUnitsInRangeOfLoc(group, location, r * METER, f)
    DestroyBoolExpr(f)
    return group
end

--- Получить текущее местоположение юнита
---@return location
function Unit:GetLoc()
    return GetUnitLoc(self.unit)
end

-- Анимации

--- Добавить тэг анимации
---@param tag string Название тэга
---@return nil
function Unit:AddAnimationTag(tag)
    AddUnitAnimationProperties(self.unit, tag, true)
end

--- Удалить тэг анимации
---@param tag string Название тэга
---@return nil
function Unit:RemoveAnimationTag(tag)
    AddUnitAnimationProperties(self.unit, tag, false)
end

-- Прочие методы

--- Проверяет является ли юнит героем
---@return boolean
function Unit:IsHero()
    return IsUnitType(self.unit, UNIT_TYPE_HERO) == true
end

--- Проверяет является ли юнит союзником
---@param unit unit Юнит
---@return boolean
function Unit:IsAlly(unit)
    if isTable(unit) then
        return IsPlayerAlly(self:GetOwner(), unit:GetOwner())
    end
    return IsPlayerAlly(self:GetOwner(), GetOwningPlayer(unit))
end

--- Проверяет является ли юнит противником
---@param unit unit Юнит
---@return boolean
function Unit:IsEnemy(unit)
    if isTable(unit) then
        return IsPlayerEnemy(self:GetOwner(), unit:GetOwner())
    end
    return IsPlayerEnemy(self:GetOwner(), GetOwningPlayer(unit))
end

--- Получить градус поворота юнита
---@return real
function Unit:GetFacing()
    return GetUnitFacing(self.unit)
end

--- Проверяет мертв ли юнит
---@return boolean
function Unit:IsDied()
    return GetDyingUnit() == self.unit
end

--- Установить уровень юнита
---@param level integer Уровень в пределах до 83
---@return nil
function Unit:SetLevel(level)
    SetHeroLevel(self.unit, level, false)
end

--- Установить количество брони
---@param armor real Количество брони в абсолютных величинах
---@return nil
function Unit:SetArmor(armor)
    BlzSetUnitArmor(self.unit, armor)
end

--- Установить время жизни юнита
---@param time real Время в абсолютных величинах
---@return nil
function Unit:ApplyTimedLife(time)
    UnitApplyTimedLife(self.unit, COMMON_TIMER, time)
end

--- Воскрешает юнита
---@param location location Место воскрешения. Опционально. По умолчанию воскрешает в той же точке, где умер
---@return nil
function Unit:Revive(location)
    local loc = location or self:GetLoc()
    local x = GetLocationX(loc)
    local y = GetLocationY(loc)
    ReviveHero(self.unit, x, y, false)
end

--- Получить идентификатор созданного юнита
---@return unitid
function Unit:GetId()
    return self.unit
end

--- Получить игрока, владеющего юнитом
---@return player
function Unit:GetOwner()
    return GetOwningPlayer(self.unit)
end

--- Установить имя юниту
---@return nil
function Unit:SetName(name)
    BlzSetUnitName(self.unit, name)
end

--- Убить юнита
---@return nil
function Unit:Kill()
    KillUnit(self.unit)
end

--- Удалить юнита
---@return nil
function Unit:Remove()
    RemoveUnit(self.unit)
end

-- Copyright (c) meiso

--- Класс создания дамми-юнита.
--- Юнит используется для применения способностей
---@param owner unit
---@param location location
UnitSpell = {}
UnitSpell.__index = UnitSpell

setmetatable(UnitSpell, {
    __index = Unit,
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
    end,
})

--- Конструктор класса
function UnitSpell:_init(owner, location)
    local loc = location or GetUnitLoc(owner)
    local face = GetUnitFacing(owner)
    self.unit = Unit(GetOwningPlayer(owner), SPELL_DUMMY, loc, face):GetId()
    self:SetMoveSpeed(512.)
end

--- Проверяет находится ли дамми-юнит возле таргета
---@param target unit Цель
---@return boolean
function UnitSpell:NearTarget(target)
    local loc
    if isTable(target) then
        loc = target:GetLoc()
    else
        loc = GetUnitLoc(target)
    end
    local target_point = Point(GetLocationX(loc), GetLocationY(loc))
    local unit_loc = self:GetLoc()
    local unit_point = Point(GetLocationX(unit_loc), GetLocationY(unit_loc))
    return target_point:atPoint(unit_point, true)
end

-- Copyright (c) Vlod www.xgm.ru
-- Copyright (c) meiso

--- Система сохранений
SaveSystem = {
    --- Фактический юнит/Игровой персонаж
    hero       = {},
    --- Юнит, которого требуется сохранить
    unit       = nil,
    --- Идентификатор класса
    classid    = 0,
    --- Список способностей юнита
    abilities  = {},
    --- Книга заклинаний юнита
    spellbook  = nil,
    --- Место воскрешения
    respawn    = nil,
    --- Директория, где будут лежать сохранения
    directory  = "test",
    --- Идентификатор автора системы сохранений
    author     = 1546,
    --- Пользовательские данные
    user_data  = {},
    --- Данные игрока и его юнита
    data       = {},
    --- Флаг процесса сохранения
    process    = false,
    hash1      = 0,
    hash2      = 0,
    --- Кэш для синхронизации данных
    gamecache  = nil,
    --- Номер карты
    map_number = 0,
    -- Автор данного творения запихал все данные в один массив
    -- и дабы как-то различать что находится внутри него,
    -- добавил специальные числа, разграничиваниющие области эти данных
    scope = {
        --- Область, за которой следует номер карты
        map        = 2,
        --- Область, за которой следуют данные о ресурсах игрока
        resources  = 3,
        --- Область, за которой следуют данные о юните (положение, хп, мана)
        hero_data  = 4,
        --- Область, за которой следуют данные о количестве skill points
        hero_skill = 5,
        --- Область, за которой следуют данные о характеристиках
        state      = 6,
        --- Область, за которой следуют данные о способностях героя
        abilities  = 7,
        --- Область, за которой следуют данные об имеющихся предметах
        items      = 8,
    },
    -- Числа, расшифровать смысл которых, так и не получилось
    magic_number = {
        one   = 18259200,
        two   = 44711,
        three = 259183,
        four  = 129593,
        five  = 259200,
        six   = 54773,
        seven = 7141,
        eight = 421,
        nine  = 259199,
    },
}

--- Условные идентификаторы классов для системы сохранений
CLASSES = {
    paladin = 1,
    priest  = 2,
}

--- Фактические идентификаторы классов
HEROES = {
    paladin = PALADIN,
    priest  = PRIEST,
}

-- Copyright (c) meiso

--- Проверяет создан ли герой для игрока
---@return boolean
function SaveSystem.IsHeroNotCreated()
    if not SaveSystem.hero[GetConvertedPlayerId(GetTriggerPlayer())] then
        return true
    end
    return false
end

-- Copyright (c) meiso

--- Возвращает итератор на следующую область для считывания данных
---@param index int Текущее значение итератора
---@param current_scope int Текущая область
---@return int Положение следующей области
function SaveSystem.next_scope(index, current_scope)
    if current_scope == SaveSystem.scope.map then
        return index + 2
    end
    if current_scope == SaveSystem.scope.resources then
        return index + 3
    end
    if current_scope == SaveSystem.scope.hero_data then
        return index + 7
    end
    if current_scope == SaveSystem.scope.hero_skill then
        return index + SaveSystem.data[index + 1] * 2 + 2
    end
    -- блок со статами
    if current_scope == SaveSystem.scope.state then
        return index + 5
    end
    -- блок со способностями
    if current_scope == SaveSystem.scope.abilities then
        return index + SaveSystem.data[index + 1] * 2 + 2
    end
    -- блок с предметами
    if current_scope == SaveSystem.scope.items then
        return index + SaveSystem.data[index + 1] * 2 + 2
    end

    -- вернем что угодно, чтобы выйти из цикла
    return GetRandomInt(100000, 2000000)
end

--- Функция генерации первого хэша
---@return integer
function SaveSystem.generation1()
    SaveSystem.hash1 = SaveSystem.hash1 * SaveSystem.magic_number.seven + SaveSystem.magic_number.six
    SaveSystem.hash1 = math.fmod(SaveSystem.hash1, SaveSystem.magic_number.five)
    return SaveSystem.hash1
end

--- Функция генерации второго хэша
---@return integer
function SaveSystem.generation2()
    SaveSystem.hash2 = SaveSystem.hash2 * SaveSystem.magic_number.eight + SaveSystem.magic_number.six
    SaveSystem.hash2 = math.fmod(SaveSystem.hash2, SaveSystem.magic_number.five)
    return SaveSystem.hash2
end

-- Copyright (c) meiso

--- Возвращает ключ игрока
---@return int Ключ игрока
function SaveSystem.GetUserKey()
    if SaveSystem.author > 0 then
        Preloader("save\\" .. SaveSystem.directory .. "\\" .. "user.txt")
        local public_key = GetPlayerTechMaxAllowed(Player(25), -1)
        local secret_key = GetPlayerTechMaxAllowed(Player(25), 0)
        if public_key == nil then
            return 0
        end
        if public_key <= 0 or public_key / 8286 > SaveSystem.magic_number.nine then
            return 0
        end

        SaveSystem.hash1 = public_key

        secret_key = secret_key - SaveSystem.generation1()
        if secret_key <= 0 then
            return 0
        end
        return secret_key
    end
    return 0
end

--- Генерирует ключ игрока
---@param salt integer "Соль" для ключа
---@param val integer Значение для генерации ключа
---@return integer Ключ игрока
function SaveSystem.CreateUserKey(salt, val)
    if SaveSystem.author > 0 then
        SaveSystem.hash1 = salt
        PreloadGenClear()
        Preload("\")\n call SetPlayerTechMaxAllowed(Player(25)," .. I2S(-1) .. "," .. I2S(salt) .. ") \n //")
        Preload("\")\n call SetPlayerTechMaxAllowed(Player(25)," .. I2S(0) .. "," .. I2S(val + SaveSystem.generation1()) .. ") //")
        PreloadGenEnd("save\\" .. SaveSystem.directory .. "\\" .. "user.txt")
        return val
    end
    return 0
end

--- Сохраняет пользовательские данные
---@param i integer
---@return integer
function SaveSystem.SaveUserData(i)
    if i > 0 then
        local n = SaveSystem.user_data[1]
        if n > 0 then
            SaveSystem.data[i] = 1
            i = i + 1
            SaveSystem.data[i] = n
            i = i + 1
            for j = 2, n do
                SaveSystem.data[i] = SaveSystem.user_data[j]
                i = i + 1
            end
        end
    end
    return i
end

--- Загружает пользовательские данные
---@return nil
function SaveSystem.LoadUserData()
    if SaveSystem.data[1] > 0 then
        local case = -1
        local i = 2
        local count = SaveSystem.data[1]
        while i < count do
            case = SaveSystem.data[i]
            if case == 1 then
                local max_count_data = SaveSystem.data[i + 1]
                local cjlocgn_00000004 = i + 1
                for j = 2, max_count_data do
                    SaveSystem.user_data[j] = SaveSystem.data[cjlocgn_00000004 + j]
                end
                SaveSystem.user_data[1] = max_count_data
            end
            i = SaveSystem.next_scope(i, case)
        end
    end
end


-- Copyright (c) meiso

--- Сохранаяет информацию о характеристиках, способностях и предметах
---@param i integer Текущий итератор
---@param u unitid Сохраняемый юнит
---@return integer Следующий итератор
function SaveSystem.SaveUnitData(i, u)
    local ability_count = 0
    local item_count = 0
    local max_slots = 5

    if IsUnitType(u, UNIT_TYPE_HERO) == true then
        -- сохраняем инфу: опыт, сила, ловкость, интеллект
        SaveSystem.data[i] = SaveSystem.scope.state
        i = i + 1
        SaveSystem.data[i] = GetHeroXP(u)
        i = i + 1
        SaveSystem.data[i] = GetHeroStr(u, false)
        i = i + 1
        SaveSystem.data[i] = GetHeroAgi(u, false)
        i = i + 1
        SaveSystem.data[i] = GetHeroInt(u, false)
        i = i + 1
        SaveSystem.data[i] = SaveSystem.scope.abilities
        i = i + 1
        local ability_index = i
        i = i + 1

        -- сохраняем способности
        for k = 1, #SaveSystem.abilities do
            local ability_level = GetUnitAbilityLevel(u, SaveSystem.abilities[k])
            if ability_level > 0 then
                ability_count = ability_count + 1
                SaveSystem.data[i] = SaveSystem.abilities[k]
                i = i + 1
                SaveSystem.data[i] = ability_level
                i = i + 1
            end
        end
        SaveSystem.data[ability_index] = ability_count
        SaveSystem.data[i] = SaveSystem.scope.items
        i = i + 1
        local item_index = i
        i = i + 1
        -- сохраняем предметы
        for item_iter = 1, max_slots do
            local item_id = UnitItemInSlot(u, item_iter)
            if item_id ~= nil then
                item_count = item_count + 1
                SaveSystem.data[i] = GetItemTypeId(item_id)
                i = i + 1
                SaveSystem.data[i] = GetItemCharges(item_id)
                i = i + 1
            end
        end
        SaveSystem.data[item_index] = item_count
    end
    return i
end

--- Сохранаяет информацию о местоположении игрока, хп, мп, кол-во вкаченных навыков
---@param i integer Текущий итератор
---@param u unitid Сохраняемый юнит
---@param world rect Текущий игровой мир
---@return integer Следующий итератор
function SaveSystem.SaveBaseState(i, u, world)

    if u ~= nil then
        local rect_min_x = R2I(GetRectMinX(world))
        local rect_max_x = R2I(GetRectMaxX(world))
        local rect_min_y = R2I(GetRectMinY(world))
        local rect_max_y = R2I(GetRectMaxY(world))
        local map_number = SaveSystem.map_number
        local unit_type_id = GetUnitTypeId(u)

        local hero_position_x = R2I((GetUnitX(u) - rect_min_x) * (I2R(SaveSystem.magic_number.one) / (rect_max_x - rect_min_x)))
        local hero_position_y = R2I((GetUnitY(u) - rect_min_y) * (I2R(SaveSystem.magic_number.one) / (rect_max_y - rect_min_y)))
        local hero_facing = R2I(GetUnitFacing(u) * (SaveSystem.magic_number.one / 360.))

        local health = R2I(GetUnitState(u, UNIT_STATE_LIFE) * (SaveSystem.magic_number.one / GetUnitState(u, UNIT_STATE_MAX_LIFE)))
        local mana = R2I(GetUnitState(u, UNIT_STATE_MANA) * (SaveSystem.magic_number.one / GetUnitState(u, UNIT_STATE_MAX_MANA)))
        local count_gold = GetPlayerState(GetLocalPlayer(), PLAYER_STATE_RESOURCE_GOLD)
        local count_lumber = GetPlayerState(GetLocalPlayer(), PLAYER_STATE_RESOURCE_LUMBER)
        SaveSystem.data[i] = SaveSystem.scope.map
        i = i + 1
        SaveSystem.data[i] = map_number
        i = i + 1
        SaveSystem.data[i] = SaveSystem.scope.hero_data
        i = i + 1
        SaveSystem.data[i] = unit_type_id
        i = i + 1
        SaveSystem.data[i] = hero_position_x
        i = i + 1
        SaveSystem.data[i] = hero_position_y
        i = i + 1
        SaveSystem.data[i] = hero_facing
        i = i + 1
        SaveSystem.data[i] = health
        i = i + 1
        SaveSystem.data[i] = mana
        i = i + 1
        --SaveSystem.data[i] = SaveSystem.classid
        --i = i + 1
        SaveSystem.data[i] = SaveSystem.scope.resources
        i = i + 1
        SaveSystem.data[i] = count_gold
        i = i + 1
        SaveSystem.data[i] = count_lumber
        i = i + 1
        SaveSystem.data[i] = SaveSystem.scope.hero_skill
        i = i + 1
    end
    return i
end

--- Загружает информацию о характеристиках, способностях и предметах
---@return nil
function SaveSystem.LoadUnitData()
    if SaveSystem.unit ~= nil then
        local current_unit = SaveSystem.unit
        local unit_loc_x = GetUnitX(current_unit)
        local unit_loc_y = GetUnitY(current_unit)
        local current_case = -1
        local i = 2
        local maximum_data = SaveSystem.data[1]
        while i < maximum_data do
            current_case = SaveSystem.data[i]
            -- выдаем предметы
            if current_case == SaveSystem.scope.items then
                local max_count_data = SaveSystem.data[i + 1]
                local j = i + 2
                while max_count_data >= 0 do
                    local current_item = CreateItem(SaveSystem.data[j], unit_loc_x, unit_loc_y)
                    UnitAddItem(current_unit, current_item)
                    SetItemCharges(current_item, SaveSystem.data[j + 1])
                    j = j + 2
                    max_count_data = max_count_data - 1
                end
            end

            -- проставляем статы
            if current_case == SaveSystem.scope.state then
                SetHeroXP(current_unit, SaveSystem.data[i + 1], false)
                if GetHeroStr(current_unit, false) < SaveSystem.data[i + 2] then
                    SetHeroStr(current_unit, SaveSystem.data[i + 2], false)
                end
                if GetHeroAgi(current_unit, false) < SaveSystem.data[i + 3] then
                    SetHeroAgi(current_unit, SaveSystem.data[i + 3], false)
                end
                if GetHeroInt(current_unit, false) < SaveSystem.data[i + 4] then
                    SetHeroInt(current_unit, SaveSystem.data[i + 4], false)
                end
            end

            -- выдаем юниту его очки навыков
            if current_case == SaveSystem.scope.hero_skill then
                local max_count_data = SaveSystem.data[i + 1]
                local j = i + 2
                while max_count_data >= 0 do
                    local count_level = SaveSystem.data[j + 1] or 0
                    while count_level > 0 do
                        SelectHeroSkill(current_unit, SaveSystem.data[j])
                        count_level = count_level - 1
                    end
                    j = j + 2
                    max_count_data = max_count_data - 1
                end
            end

            -- выдаем способности
            if current_case == SaveSystem.scope.abilities then
                -- сколько всего способностей было сохранено
                local max_count_data = SaveSystem.data[i + 1]
                -- индекс, по которому лежит способность
                local j = i + 2
                while max_count_data >= 0 do
                    UnitAddAbility(current_unit, SaveSystem.data[j])
                    SetUnitAbilityLevel(current_unit, SaveSystem.data[j], SaveSystem.data[j + 1])
                    j = j + 2
                    max_count_data = max_count_data - 1
                end
            end

            i = SaveSystem.next_scope(i, current_case)
        end
    end
end

--- Загрузка общих данных об игроке и его юните
---@param pl playerid Локальный игрок
---@return nil
function SaveSystem.LoadBaseState(pl)
    local unit_x
    local unit_y
    local unit_face
    local count_gold
    local count_lumber
    local unit_id
    local health
    local mana
    if SaveSystem.data[1] > 0 then
        -- размеры карты
        local rect_min_x = R2I(GetRectMinX(GetWorldBounds()))
        local rect_max_x = R2I(GetRectMaxX(GetWorldBounds()))
        local rect_min_y = R2I(GetRectMinY(GetWorldBounds()))
        local rect_max_y = R2I(GetRectMaxY(GetWorldBounds()))
        -- номер карты
        local map_number = -1
        local i = 2
        local case = -1
        -- макс. кол-во записанных данных
        local n = SaveSystem.data[1]

        while i < n do
            case = SaveSystem.data[i]
            if case == SaveSystem.scope.map then
                map_number = SaveSystem.data[i + 1]
            end

            if case == SaveSystem.scope.resources then
                count_gold = SaveSystem.data[i + 1]
                count_lumber = SaveSystem.data[i + 2]
            end

            if case == SaveSystem.scope.hero_data then
                unit_id = SaveSystem.data[i + 1]
                -- местоположение игрока в месте, где он сохранялся
                unit_x = rect_min_x + (rect_max_x - rect_min_x) * (I2R(SaveSystem.data[i + 2]) / SaveSystem.magic_number.one)
                unit_y = rect_min_y + (rect_max_y - rect_min_y) * (I2R(SaveSystem.data[i + 3]) / SaveSystem.magic_number.one)
                unit_face = 360. * (I2R(SaveSystem.data[i + 4]) / SaveSystem.magic_number.one)
                health = SaveSystem.data[i + 5]
                mana = SaveSystem.data[i + 6]
                --SaveSystem.classid = SaveSystem.data[i + 7]
            end
            i = SaveSystem.next_scope(i, case)
        end

        -- если карта другая - создаём персонажа в заранее заданном месте
        if map_number ~= SaveSystem.map_number then
            local loc = GetRandomLocInRect(gg_rct_RespawZone)
            unit_x = GetLocationX(loc)
            unit_y = GetLocationY(loc)
        end

        --SaveSystem.AddHeroAbilities(SaveSystem.classid)
        local unit_obj = CreateUnit(pl, unit_id, unit_x, unit_y, unit_face)
        SaveSystem.unit = unit_obj

        if unit_obj ~= nil then
            SetUnitState(unit_obj, UNIT_STATE_LIFE, GetUnitState(unit_obj, UNIT_STATE_MAX_LIFE) * (I2R(health) / SaveSystem.magic_number.one))
            SetUnitState(unit_obj, UNIT_STATE_MANA, GetUnitState(unit_obj, UNIT_STATE_MAX_MANA) * (I2R(mana) / SaveSystem.magic_number.one))
            SetPlayerState(pl, PLAYER_STATE_RESOURCE_GOLD, count_gold)
            SetPlayerState(pl, PLAYER_STATE_RESOURCE_LUMBER, count_lumber)
        end
    end
end

-- Copyright (c) meiso

--- Создает юнита из полученных данных
---@return nil
function SaveSystem.CreateUnit(gc, pl)
    if gc ~= nil then
        local count = GetStoredInteger(gc, "1", "1")
        for i = 1, count do
            SaveSystem.data[i] = GetStoredInteger(gc, I2S(i), I2S(i))
        end
        TriggerSleepAction(0.)

        -- загружаем общее состояние игрока
        SaveSystem.LoadBaseState(pl)

        if SaveSystem.unit == nil then
            DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "error data")
            return
        end

        TriggerSleepAction(0.)
        SaveSystem.LoadUnitData()
        TriggerSleepAction(0.)
        SaveSystem.LoadUserData()
        DisplayTextToPlayer(pl, 0, 0, "load complite")
    end
end

--- Синхронизирует данные между игроками
---@return nil
function SaveSystem.Syncing(gc, is_player)
    if is_player then
        local count = SaveSystem.data[1]
        for i = 1, count do
            StoreInteger(gc, I2S(i), I2S(i), SaveSystem.data[i])
            SyncStoredInteger(gc, I2S(i), I2S(i))
        end
        StoreInteger(gc, "bool", "bool", 1)
        SyncStoredInteger(gc, "bool", "bool")
    end
end

--- Проверяет целостность данных
---@return boolean
function SaveSystem.CheckDataIntegrity(author, user)
    local encrypted_data
    if author > 0 and user > 0 then
        local player_s = Player(25)
        local max_count_data = GetPlayerTechMaxAllowed(player_s, -1)
        local saved_encrypted_key = GetPlayerTechMaxAllowed(player_s, -2)
        SaveSystem.hash1 = saved_encrypted_key
        SaveSystem.hash2 = saved_encrypted_key

        local check_sum = GetPlayerTechMaxAllowed(player_s, SaveSystem.generation2())
        local check_max_count_data = check_sum - SaveSystem.generation1()

        if max_count_data == check_max_count_data then
            -- дешифруем
            for i = 2, max_count_data do
                encrypted_data = GetPlayerTechMaxAllowed(player_s, SaveSystem.generation2())
                check_sum = math.fmod(check_sum + encrypted_data, SaveSystem.magic_number.three)

                encrypted_data = encrypted_data - SaveSystem.generation1()
                check_max_count_data = math.fmod(check_max_count_data + encrypted_data, SaveSystem.magic_number.four)

                SaveSystem.data[i] = encrypted_data
            end
            SaveSystem.data[1] = max_count_data

            if check_sum ~= GetPlayerTechMaxAllowed(player_s, SaveSystem.generation2()) - SaveSystem.generation1() then
                DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "error rsum")
                return false
            end

            local result = math.fmod(math.fmod(math.fmod(math.fmod(author, SaveSystem.magic_number.two) *
                    math.fmod(check_max_count_data, SaveSystem.magic_number.two), SaveSystem.magic_number.two) *
                    math.fmod(saved_encrypted_key, SaveSystem.magic_number.two), SaveSystem.magic_number.two) *
                    math.fmod(user, SaveSystem.magic_number.two), SaveSystem.magic_number.two)
            if GetPlayerTechMaxAllowed(player_s, -3) == result then
                return true
            end
        end
        DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "Error load. Pls, take a look \"Allow Local Files\"")
    end
    return false
end

--- Дешифрует полученные данные из файла сохранения
---@return nil
function SaveSystem.afa(gc, pl, file_name)
    local is_player_author = false
    local user_key
    local id_player

    if gc ~= nil then
        is_player_author = GetLocalPlayer() == pl
        id_player = SaveSystem.author

        if id_player <= 0 then
            is_player_author = false
        end

        if is_player_author then
            user_key = SaveSystem.GetUserKey()
            if user_key == 0 then
                is_player_author = false
            end
        end

        TriggerSleepAction(0.)

        -- загружаем данные из save-файла
        if is_player_author then
            Preloader("save\\" .. SaveSystem.directory .. "\\" .. file_name)
        end

        TriggerSleepAction(0.)

        if is_player_author then
            is_player_author = SaveSystem.CheckDataIntegrity(id_player, user_key)
        end

        TriggerSleepAction(0.)
        TriggerSyncStart()
        SaveSystem.Syncing(gc, is_player_author)
        TriggerSleepAction(2.)
        TriggerSyncReady()

        if GetStoredInteger(gc, "bool", "bool") == 1 then
            SaveSystem.CreateUnit(gc, pl)
        end

        StoreInteger(gc, "bool", "bool", 0)
    end
end

--- Загружает юнита
---@return nil
function SaveSystem.Load()
    local save_file
    local full_command_from_chat

    if not SaveSystem.process then
        full_command_from_chat = GetEventPlayerChatString()

        -- определяем имя save-файла
        if StringLength(full_command_from_chat) > 6 then
            save_file = SubString(full_command_from_chat, 6, 16) .. ".txt"
        else
            save_file = "default.txt"
        end

        SaveSystem.afa(SaveSystem.gamecache, GetTriggerPlayer(), save_file)

        for i = 1, #SaveSystem.data do
            Preload(I2S(SaveSystem.data[i]) .. " data[" .. I2S(i) .. "] < load")
        end
        for j = 1, #SaveSystem.user_data do
            Preload(I2S(SaveSystem.user_data[j]) .. " user_data[" .. I2S(j) .. "] < load")
        end
        PreloadGenEnd("save\\" .. SaveSystem.directory .. "\\" .. "log_load.txt")
        PreloadGenClear()
    end
end

--- Шифрует полученные данные и записывает в файл сохранений
---@return nil
function SaveSystem.ada(is_player, file_name, u)
    local user_key
    local id_author = SaveSystem.author
    local handle_world
    local key = GetRandomInt(1, SaveSystem.magic_number.nine)
    local new_key = GetRandomInt(1, SaveSystem.magic_number.nine)
    local salt = GetRandomInt(1, SaveSystem.magic_number.nine)
    local value_for_key = GetRandomInt(1, 2000000000)
    local data_copy = {}
    local item_data = 2
    local n
    local encrypted_data
    local raw_index = 0
    local encrypted = 0

    if u ~= nil then
        handle_world = GetWorldBounds()

        if id_author <= 0 then
            is_player = false
        end

        if is_player then
            user_key = SaveSystem.GetUserKey()
            if user_key == 0 then
                user_key = SaveSystem.CreateUserKey(salt, value_for_key)
            end
        end

        if is_player then
            item_data = SaveSystem.SaveUnitData(item_data, u)
        end

        if is_player then
            item_data = SaveSystem.SaveBaseState(item_data, u, handle_world)
        end

        if SaveSystem.user_data[1] > 0 then
            if is_player then
                if SaveSystem.user_data[1] + item_data < 1200 then
                    item_data = SaveSystem.SaveUserData(item_data)
                else
                    DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "too much data")
                    is_player = false
                end
            end
        end

        if is_player then
            item_data = item_data - 1
            data_copy[item_data + 1] = 0
            SaveSystem.data[1] = item_data
            SaveSystem.hash1 = key
            SaveSystem.hash2 = key

            for i = 1, item_data do
                encrypted_data = SaveSystem.data[i]
                raw_index = math.fmod(raw_index + encrypted_data, SaveSystem.magic_number.four)
                encrypted_data = encrypted_data + SaveSystem.generation1()
                encrypted = math.fmod(encrypted + encrypted_data, SaveSystem.magic_number.three)
                SaveSystem.data[i] = encrypted_data
                data_copy[i] = SaveSystem.generation2()
            end

            SaveSystem.data[item_data + 1] = encrypted + SaveSystem.generation1()
            data_copy[item_data + 1] = SaveSystem.generation2()
        end

        TriggerSleepAction(0.)

        if is_player then
            SaveSystem.hash1 = new_key
            n = item_data + 1
            for i = 1, n do
                local k = R2I((I2R(SaveSystem.generation1()) / SaveSystem.magic_number.nine) * n)
                encrypted_data = SaveSystem.data[i]
                SaveSystem.data[i] = SaveSystem.data[k]
                SaveSystem.data[k] = encrypted_data
                encrypted_data = data_copy[i]
                data_copy[i] = data_copy[k]
                data_copy[k] = encrypted_data
            end
        end

        TriggerSleepAction(0.)

        if is_player then
            PreloadGenClear()
            n = item_data + 1
            for i = 1, n do
                if data_copy[i] == nil or SaveSystem.data[i] == nil then
                    DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "repeat, pls")
                    return
                end
                Preload("\")\n\n call SetPlayerTechMaxAllowed(Player(25)," .. I2S(data_copy[i]) .. "," .. I2S(SaveSystem.data[i]) .. ") \n //")
            end

            -- сохранение данных в файл
            Preload("\")\n\n call SetPlayerTechMaxAllowed(Player(25)," .. I2S(-1) .. "," .. I2S(item_data) .. ") \n //")
            Preload("\")\n\n call SetPlayerTechMaxAllowed(Player(25)," .. I2S(-2) .. "," .. I2S(key) .. ") \n //")
            -- смысл этих вычислений скрыт от мира сего
            local a = math.fmod(user_key, SaveSystem.magic_number.two) * math.fmod(raw_index, SaveSystem.magic_number.two)
            local b = math.fmod(a, SaveSystem.magic_number.two) * math.fmod(key, SaveSystem.magic_number.two)
            local c = math.fmod(b, SaveSystem.magic_number.two) * math.fmod(id_author, SaveSystem.magic_number.two)
            encrypted_data = math.fmod(c, SaveSystem.magic_number.two)
            Preload("\")\n\n call SetPlayerTechMaxAllowed(Player(25)," .. I2S(-3) .. "," .. I2S(encrypted_data) .. ") \n //")
            PreloadGenEnd("save\\" .. SaveSystem.directory .. "\\" .. file_name)
            PreloadGenClear()

            DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "save complite")
        end
    end
end

--- Сохраняет юнита
---@return nil
function SaveSystem.Save()
    local file
    if not SaveSystem.process then
        SaveSystem.process = true
        local handle_player = GetTriggerPlayer()
        local full_command_from_chat = GetEventPlayerChatString()

        -- если не понятно кого сохранять - сообщаем об этом в чат
        if SaveSystem.unit == nil then
            DisplayTextToPlayer(handle_player, 0, 0, "unit is not selected")
            return
        end

        -- определяем имя save-файла
        if StringLength(full_command_from_chat) > 6 then
            file = SubString(full_command_from_chat, 6, 16) .. ".txt"
        else
            file = "default.txt"
        end

        SaveSystem.ada((GetLocalPlayer() == handle_player), file, SaveSystem.unit)
        SaveSystem.process = false
    end
end

-- Copyright (c) meiso

--- Возрождает юнита
---@return nil
function SaveSystem.UnitsRespawn()
    local unit = Unit(GetTriggerUnit())
    if unit:IsHero() then
        TriggerSleepAction(5)
        unit:Revive()
    end
end

--- Определяет способности выбранного класса
---@return nil
function SaveSystem.DefineAbilities()
    if SaveSystem.classid == CLASSES["paladin"] then
        SaveSystem.DefineAbilitiesPaladin()
    elseif SaveSystem.classid == CLASSES["priest"] then
        SaveSystem.DefineAbilitiesPriest()
    end
end

--- Определяет способности паладина
---@return nil
function SaveSystem.DefineAbilitiesPaladin()
    SaveSystem.abilities = {
        DIVINE_SHIELD,
        CONSECRATION,
        HAMMER_RIGHTEOUS,
        JUDGEMENT_OF_LIGHT_TR,
        JUDGEMENT_OF_WISDOM_TR,
        SHIELD_OF_RIGHTEOUSNESS,
        AVENGERS_SHIELD,
        SPELLBOOK_PALADIN,
    }
    SaveSystem.spellbook = SPELLBOOK_PALADIN
end

--- Определяет способности приста
---@return nil
function SaveSystem.DefineAbilitiesPriest()
    SaveSystem.abilities = {
        FLASH_HEAL,
        RENEW,
        CIRCLE_OF_HEALING,
    }
    SaveSystem.spellbook = nil
end

--- Выдает герою способности
---@return nil
function SaveSystem.AddHeroAbilities(class)
    SaveSystem.classid = CLASSES[class]
    local hero = Unit(SaveSystem.hero[GetConvertedPlayerId(GetTriggerPlayer())])
    SaveSystem.DefineAbilities()
    hero:AddAbilities(table.unpack(SaveSystem.abilities))
    hero:AddSpellbook(SaveSystem.spellbook)
    hero:SetLevel(80)
end

-- Copyright (c)  meiso

--- Добавляет нового юнита игроку
---@return nil
function SaveSystem.AddNewHero()
    local text = GetEventPlayerChatString()
    local unit
    local playerid = GetConvertedPlayerId(GetTriggerPlayer())
    if text:find("paladin") then
        unit = Unit(GetTriggerPlayer(), PALADIN, GetRectCenter(gg_rct_RespawZone))
        SaveSystem.hero[playerid] = unit:GetId()
        SaveSystem.AddHeroAbilities("paladin")
    elseif text:find("priest") then
        unit = Unit(GetTriggerPlayer(), PRIEST, GetRectCenter(gg_rct_RespawZone))
        SaveSystem.hero[playerid] = unit:GetId()
        SaveSystem.AddHeroAbilities("priest")
    end
end

--- Инициализирует событие выдачи юнита игроку
---@return nil
function SaveSystem.InitNewHeroEvent()
    local event = EventsPlayer()
    event:RegisterChatEvent("-new")
    event:AddCondition(SaveSystem.IsHeroNotCreated)
    event:AddAction(SaveSystem.AddNewHero)
end

-- Copyright (c)  meiso

--- Сохраняет юнита игрока
---@return nil
function SaveSystem.SaveHero()
    SaveSystem.unit = SaveSystem.hero[GetConvertedPlayerId(GetTriggerPlayer())]
    SaveSystem.user_data[1] = 1
    SaveSystem.Save()
end

--- Инициализирует событие сохранения юнита
---@return nil
function SaveSystem.InitSaveEvent()
    local event = EventsPlayer()
    event:RegisterChatEvent("-save")
    event:AddAction(SaveSystem.SaveHero)
end

-- Copyright (c)  meiso

--- Загружает юнита
---@return nil
function SaveSystem.LoadHero()
    local i = GetConvertedPlayerId(GetTriggerPlayer())
    SaveSystem.Load()
    SaveSystem.hero[i] = SaveSystem.unit
end

--- Инициализация события по загрузке юнита
---@return nil
function SaveSystem.InitLoadEvent()
    local event = EventsPlayer()
    event:RegisterChatEvent("-load")
    event:AddCondition(SaveSystem.IsHeroNotCreated)
    event:AddAction(SaveSystem.LoadHero)
end

-- Copyright (c)  meiso

--Обёртка над системой экипировки

EquipSystem = {}

--- Регистрирует предмет со способностями.
--- Последовательность имен в массивах должна сохраняться
---@param items string Список предметов
---@param items_spells string Список способностей предметов
---@return nil
function EquipSystem.RegisterItems(items, items_spells)
    local count = 1
    local items_ = zip(items, items_spells)
    for _, item in pairs({ table.unpack(items_) }) do
        reg_item_eq(Items[item[1]], ItemsSpells[item[2]].str, count)
    end
end

--- Добавляет юниту некоторое количество предметов
---@param unit unit Id юнита или от класса Unit
---@param items string Список предметов
---@param count int Количество предметов
---@return nil
function EquipSystem.AddItemsToUnit(unit, items, count)
    local c = count or 1
    local u = unit
    if isTable(unit) then
        u = unit:GetId()
    end
    for _, item in pairs(items) do
        equip_items_id(u, Items[item], c)
    end
end

--- Удаляет у юнита некоторое количество предметов
---@param unit unit Id юнита или от класса Unit
---@param items string Список предметов
---@param count int Количество предметов
---@return nil
function EquipSystem.RemoveItemsToUnit(unit, items, count)
    local c = count or 1
    local u = unit
    if isTable(unit) then
        u = unit:GetId()
    end
    for _, item in pairs(items) do
        unequip_item_id(u, Items[item], c)
    end
end

--Equipment system
--author Warden | 5.08.2007 | Warden_xgm@mail.ru | WWW.XGM.RU

--[[
>> Для работы системы требуется :
1. Триггер "equipment system" / скрипт включенный в карту
2. Переменная типа "буфер игры" (Записанная в функцию "get_cache_eq")
3. Юнит со способностью "предметы(герой)" (Записанный в функцию "dummy_eq")

>> Основные функции :
1. function equip_item takes unit hero, item it returns nothing
2. function equip_items_id takes unit hero, integer id, integer c returns nothing
3. function unequip_item_id takes unit hero, integer id, integer c returns nothing
4. function reg_item_eq takes integer id, string ablist, integer c returns nothing

1. Добавляет герою (hero) невидимый предмет (it)
2. Добавляет герою (hero) невидимый предмет типа (id), (c) раза
3. Удаляет у героя (hero) невидимый предмет типа (id), (c) раза
4. Регистрирует предмет типа (id), со способностями (ablist), с количеством способностей (c)

>> Примечания :
1. в 'ablist' записываются id способностей предмета, без тегов и через запятую (Например : "I000,I001")
--]]

--Код взят в исходном виде и переписан под Lua (C) meiso

function dummy_eq()
    return FourCC('e000')
end

function get_cache_eq()
    if EQUIP_CACHE == nil then
        FlushGameCache(InitGameCache("equipment_vars.w3v"))
        EQUIP_CACHE = InitGameCache("equipment_vars.w3v")
    end
    return EQUIP_CACHE
end

--###########################################################################
function get_item_list_eq(id)
    return GetStoredString(get_cache_eq(), "eq_", "item_ab_list" .. I2S(id))
end

function get_item_abc_eq(id)
    return GetStoredInteger(get_cache_eq(), "eq_", "item_ab_count" .. I2S(id))
end

function reg_item_eq(id, ablist, c)
    StoreInteger(get_cache_eq(), "eq_", "item_ab_count" .. I2S(id), c)
    StoreString(get_cache_eq(), "eq_", "item_ab_list" .. I2S(id), ablist)
end

--###########################################################################
function chr(i)
    local abc = "abcdefghijklmnopqrstuvwxyz"
    local ABC = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    local digits = "0123456789"
    if i >= 65 and i <= 90 then
        return SubString(ABC, i - 65, i - 64)
    elseif i >= 97 and i <= 122 then
        return SubString(abc, i - 97, i - 96)
    elseif i >= 48 and i <= 57 then
        return SubString(digits, i - 48, i - 47)
    end
    return ""
end

function CPos(strData, toFind, from)
    local fromPos = from
    while not SubString(strData, fromPos, fromPos + 1) == toFind or
            not SubString(strData, fromPos, fromPos + 1) == "" do
        fromPos = fromPos + 1
    end
    if SubString(strData, fromPos, fromPos + 1) == toFind then
        return fromPos
    end
    return -1
end

function convert_to_int(str)
    local position = CPos("ABCDEFGHIJKLMNOPQRSTUVWXYZ", str, 0) + 65
    if position == 64 then
        position = CPos("0123456789", str, 0) + 48
    end
    if position == 47 then
        position = CPos("abcdefghijklmnopqrstuvwxyz", str, 0) + 97
    end
    if str == "" then
        return 0
    else
        return position
    end
end

function id2string(itemid)
    return chr(itemid / 256 / 256 / 256) ..
            chr(ModuloInteger(itemid / 256 / 256, 256)) ..
            chr(ModuloInteger(itemid / 256, 256)) ..
            chr(ModuloInteger(itemid, 256))
end

function string2id(str)
    return convert_to_int(SubString(str, 0, 1)) * 256 * 256 * 256 +
            convert_to_int(SubString(str, 1, 2)) * 256 * 256 +
            convert_to_int(SubString(str, 2 ,3)) * 256 +
            convert_to_int(SubString(str, 3, 4))
end

--###########################################################################
function get_string_str(str, divisor, n)
    local num = 0
    local res = ""
    for i = 0, StringLength(str) do
        if SubString(str, i, i + 1) == divisor then
            if num == n then
                return res
            else
                res = ""
            end
            num = num + 1
        else
            res = res .. SubString(str, i, i + 1)
        end
    end
    return res
end

--###########################################################################
function convert_item()
    RemoveItem(GetManipulatedItem())
end

function equip_item(hero, id)
    local i = -1
    local t = CreateTrigger()
    local u = CreateUnit(GetOwningPlayer(hero), dummy_eq(), GetUnitX(hero), GetUnitY(hero), 0.)
    local itx
    local abc = get_item_abc_eq(id)
    if abc == 0 then
        return
    end

    repeat
        i = i + 1
        itx = UnitItemInSlot(hero, i)
    until i == 5 or itx == nil

    if i >= 5 then
        itx = UnitRemoveItemFromSlotSwapped(5, hero)
    else
        itx = nil
    end

    local it = CreateItem(id, 0, 0)

    TriggerRegisterUnitEvent(t, u, EVENT_UNIT_DROP_ITEM)
    TriggerAddAction(t, convert_item)
    UnitAddItem(u, it)
    UnitAddItem(hero, it)
    DestroyTrigger(t)
    RemoveUnit(u)

    if itx ~= nil then
        UnitAddItem(hero, itx)
    end
end

function equip_items_id(hero, id, c)
    local i = -1
    local t = CreateTrigger()
    local u = CreateUnit(GetOwningPlayer(hero), dummy_eq(), GetUnitX(hero), GetUnitY(hero), 0.)
    local it
    local itx
    local abc = get_item_abc_eq(id)

    if abc == 0 then
        return
    end

    repeat
        i = i + 1
        itx = UnitItemInSlot(hero, i)
    until i == 5 or itx == nil

    if i >= 5 then
        itx = UnitRemoveItemFromSlotSwapped(5, hero)
    else
        itx = nil
    end

    TriggerRegisterUnitEvent(t, u, EVENT_UNIT_DROP_ITEM)
    TriggerAddAction(t, convert_item)

    for _ = 1, c do
        it = CreateItem(id, 0, 0)
        UnitAddItem(u, it)
        UnitAddItem(hero, it)
    end

    if itx ~= nil then
        UnitAddItem(hero, itx)
    end
    DestroyTrigger(t)
    RemoveUnit(u)
end

function unequip_item_id(hero, id, c)
    local ablist = get_item_list_eq(id)
    local abc = get_item_abc_eq(id)
    for i = 1, c do
        for j = 0, abc - 1 do
            local str = get_string_str(ablist, ",", j)
            UnitRemoveAbility(hero, FourCC(str))
        end
    end
end

-- Copyright (c)  meiso

BuffSystem = {
    --- Таблица содержащая всех героев с бафами
    ---Формат:
    ---{ unit = { buff, debuff, func, frame } }
    buffs = {},
    debuffs = {},
    main_frame_buff = nil,
    main_frame_debuff = nil,
}

function BuffSystem.LoadFrame()
    BuffSystem.main_frame_buff = Frame("BSMainFrame")
    BuffSystem.main_frame_debuff = Frame("BSMainFrame")
    --если ставить фрейм в упор к границе, то фрейм ужимает в два раза,
    --потому немного смещаем бафы на позицию 0.015
    BuffSystem.main_frame_buff:SetAbsPoint(FRAMEPOINT_CENTER, 0.015, 0.18)
    BuffSystem.main_frame_debuff:SetAbsPoint(FRAMEPOINT_CENTER, 0.61, 0.18)
    BuffSystem.main_frame_buff:Hide()
    BuffSystem.main_frame_debuff:Hide()
end

--- Регистрирует героя в системе
---@param hero unit Id героя
---@return nil
function BuffSystem.RegisterHero(hero)
    if isTable(hero) then hero = hero:GetId() end
    if BuffSystem.IsHeroInSystem(hero) then
        return
    end
    local u = I2S(GetHandleId(hero))
    BuffSystem.buffs[u] = {}
end

--- Добавляет герою баф
---@param hero unit Id героя
---@param buff ability Название бафа
---@param func function Функция, снимающая баф
---@param is_debuff boolean Является баф дебафом
---@return nil
function BuffSystem.AddBuffToHero(hero, buff, func, is_debuff)
    if isTable(hero) then hero = hero:GetId() end
    if BuffSystem.IsBuffOnHero(hero, buff) then
        return
    end
    local u = I2S(GetHandleId(hero))
    if is_debuff then
        table.insert(BuffSystem.buffs[u], { buff_ = "", debuff_ = buff, func_ = func, frame_ = Frame("BSIconTemp") })
    else
        table.insert(BuffSystem.buffs[u], { buff_ = buff, debuff_ = "", func_ = func, frame_ = Frame("BSIconTemp") })
    end
    BuffSystem.CheckingBuffsExceptions(hero, buff)
    if is_debuff then
        BuffSystem.main_frame_debuff:Show()
        BuffSystem._ShowDebuffs(u)
    else
        BuffSystem.main_frame_buff:Show()
        BuffSystem._ShowBuffs(u)
    end
end

--- Проверяет есть ли герой в системе бафов
---@param hero unit Id героя
---@return boolean
function BuffSystem.IsHeroInSystem(hero)
    if isTable(hero) then hero = hero:GetId() end
    local u = I2S(GetHandleId(hero))
    for name, _ in pairs(BuffSystem.buffs) do
        if name == u then
            return true
        end
    end
    return false
end

--- Проверяет есть ли на герое баф
---@param hero unit Id героя
---@param buff ability Название бафа
---@return boolean
function BuffSystem.IsBuffOnHero(hero, buff)
    if isTable(hero) then hero = hero:GetId() end
    local u = I2S(GetHandleId(hero))
    if not BuffSystem.IsHeroInSystem(hero) then
        return false
    end
    if #BuffSystem.buffs[u] == 0 then
        return false
    end
    BuffSystem.CheckingBuffsExceptions(hero, buff)
    for i = 1, #BuffSystem.buffs[u] do
        if BuffSystem.buffs[u][i] == nil then
            return false
        end
        if BuffSystem.buffs[u][i].buff_ == buff or
                BuffSystem.buffs[u][i].debuff_ == buff then
            return true
        end
    end
    return false
end

--- Удаляет у героя баф
---@param hero unit Id героя
---@param buff ability Название бафа
---@return nil
function BuffSystem.RemoveBuffFromHero(hero, buff)
    if isTable(hero) then hero = hero:GetId() end
    local u = I2S(GetHandleId(hero))
    for i = 1, #BuffSystem.buffs[u] do
        if BuffSystem.buffs[u][i].buff_ == buff or
                BuffSystem.buffs[u][i].debuff_ == buff then
            BuffSystem.buffs[u][i].frame_:Destroy()
            BuffSystem.buffs[u][i] = nil
        end
    end
    BuffSystem._ShowBuffs(u)
    BuffSystem._ShowDebuffs(u)
end

--- Использует функцию для удаления бафа
---@param hero unit Id героя
---@param buff ability Название бафа
---@return nil
function BuffSystem.RemoveBuffFromHeroByFunc(hero, buff)
    if isTable(hero) then hero = hero:GetId() end
    local u = I2S(GetHandleId(hero))
    for i = 1, #BuffSystem.buffs[u] do
        if BuffSystem.buffs[u][i] == nil then
            return
        end
        if BuffSystem.buffs[u][i].buff_ == buff or
                BuffSystem.buffs[u][i].debuff_ == buff then
            BuffSystem.buffs[u][i].func_()
            BuffSystem.buffs[u][i] = nil
        end
    end
end

--- Проверяет относится ли баф к группе однотипных бафов
---@param hero unit Юнит
---@param buff ability Название бафа
---@return nil
function BuffSystem.CheckingBuffsExceptions(hero, buff)
    if isTable(hero) then hero = hero:GetId() end
    local buffs_exceptions = {
        paladin = { blessing_of_kings, blessing_of_wisdom, blessing_of_sanctuary, blessing_of_might },
        priest = {},
        shaman = {},
        druid = {},
    }

    local debuffs_exceptions = {
        paladin = { JUDGEMENT_OF_WISDOM, JUDGEMENT_OF_LIGHT },
    }

    local function getBuffsByClass()
        for class, buffs in pairs(buffs_exceptions) do
            for i in pairs(buffs) do
                if buffs[i] == buff then
                    return buffs_exceptions[class]
                end
            end
        end
        for class, buffs in pairs(debuffs_exceptions) do
            for i in pairs(buffs) do
                if buffs[i] == buff then
                    return debuffs_exceptions[class]
                end
            end
        end
        return {}
    end

    for _, buff_ in pairs(getBuffsByClass()) do
        if buff_ ~= buff then
            BuffSystem.RemoveBuffFromHeroByFunc(hero, buff_)
        end
    end
end

--- Удалить все бафы с юнита
---@param hero unit
---@return nil
function BuffSystem.RemoveAllBuffs(hero)
    if isTable(hero) then hero = hero:GetId() end
    local u = I2S(GetHandleId(hero))
    for i = 1, #BuffSystem.buffs[u] do
        BuffSystem.RemoveBuffFromHeroByFunc(hero, BuffSystem.buffs[u][i].buff_)
        BuffSystem.RemoveBuffFromHeroByFunc(hero, BuffSystem.buffs[u][i].debuff_)
    end
end

--- Удалить баф со всех юнитов
---@param buff ability Название бафа
---@return nil
function BuffSystem.RemoveBuffFromUnits(buff)
    for unit, _ in pairs(BuffSystem.buffs) do
        for i = 1, #BuffSystem.buffs[unit] do
            if BuffSystem.buffs[unit][i] == nil then
                return
            end
            if BuffSystem.buffs[unit][i].buff_ == buff or
                    BuffSystem.buffs[unit][i].debuff_ == buff then
                BuffSystem.buffs[unit][i].frame_:Destroy()
                BuffSystem.buffs[unit][i] = nil
            end
        end
        BuffSystem._ShowBuffs(unit)
        BuffSystem._ShowDebuffs(unit)
    end
end

--- Удаляет героя из системы бафов
---@param hero unit Id героя
---@return nil
function BuffSystem.RemoveHero(hero)
    if isTable(hero) then hero = hero:GetId() end
    local u = I2S(GetHandleId(hero))
    --TODO: корректно удалять все бафы и фреймы!!
    BuffSystem.buffs[u] = nil
end

--- Усилить воздействие способности на цель взависимости от наличия определенного бафа
---@param hero unit Юнит, на которого воздействуют спеллом
---@param value integer Количество урона/исцеления воздействующее на цель
---@return real
function BuffSystem.ImproveSpell(hero, value)
    if isTable(hero) then hero = hero:GetId() end
    local improving_buffs = {
        guardian_spirit,
    }
    if not BuffSystem.IsHeroInSystem(hero) then
        return value
    end
    local u = I2S(GetHandleId(hero))
    for i = 1, #BuffSystem.buffs[u] do
        for _, buff in pairs(improving_buffs) do
            if BuffSystem.buffs[u][i] == nil then
                return value
            end
            if buff == BuffSystem.buffs[u][i].buff_ then
                return value * 1.4
            end
        end
    end
    return value
end

function BuffSystem._ResizeMainFrame(main_frame, icon_frame, count)
    --расположение иконки бафа по X
    --расстояние между иконками + суммарный размер всех иконок + граница справа от фона
    local x = 0.005 + (count * icon_frame:GetWidth()) + (0.0025 * count)
    --на сколько расширить фон
    --(ширина иконки * 2 + расстояние между иконками) * количество всех бафов
    local _add = (icon_frame:GetWidth() * 2 + 0.005) * count
    --0.03 - базовая ширина фона
    main_frame:SetWidth(0.03 + _add)
    icon_frame:SetPoint(FRAMEPOINT_LEFT, main_frame, FRAMEPOINT_LEFT, x, 0.0)
end

function BuffSystem._SetIcon(icon)
    local buff_icon = Frame(Frame:GetFrameByName("BSIcon"))
    buff_icon:SetTexture(icon)
end

function BuffSystem._ShowBuffs(u)
    local count = 0
    for i = 1, #BuffSystem.buffs[u] do
        if BuffSystem.buffs[u][i].buff_ ~= "" then
            count = count + 1
            local buff_ = BuffSystem.buffs[u][i].buff_
            BuffSystem._ResizeMainFrame(
                    BuffSystem.main_frame_buff,
                    BuffSystem.buffs[u][i].frame_,
                    count - 1
            )
            BuffSystem._SetIcon(BuffSystem.buffs[u][i].buff_.icon)
            BuffSystem.buffs[u][i].frame_:SetTooltip(buff_.buff_tooltip, buff_.buff_desc)
        end
    end
    if count == 0 then
        BuffSystem.main_frame_buff:Hide()
    end
end

function BuffSystem._ShowDebuffs(u)
    local count = 0
    for i = 1, #BuffSystem.buffs[u] do
        if BuffSystem.buffs[u][i].debuff_ ~= "" then
            count = count + 1
            local debuff_ = BuffSystem.buffs[u][i].debuff_
            BuffSystem._ResizeMainFrame(
                    BuffSystem.main_frame_debuff,
                    BuffSystem.buffs[u][i].frame_,
                    count - 1
            )
            BuffSystem._SetIcon(debuff_.icon)
            BuffSystem.buffs[u][i].frame_:SetTooltip(debuff_.buff_tooltip, debuff_.buff_desc)
        end
    end
    if count == 0 then
        BuffSystem.main_frame_debuff:Hide()
    end
end

-- Copyright (c) meiso

BattleSystem = {
    target = nil,
    target_event = nil,
    disable = false,
}

function BattleSystem.Init()
    local damaged = EventsPlayer()
    local settarget = EventsPlayer()
    damaged:RegisterUnitDamaged()
    settarget:RegisterPlayerMouseDown()

    damaged:AddAction(BattleSystem.ShowDamage)
    settarget:AddCondition(BattleSystem.IsRightButton)
    settarget:AddAction(BattleSystem.SetTarget)
end

function BattleSystem.IsRightButton()
    return BlzGetTriggerPlayerMouseButton() == MOUSE_BUTTON_TYPE_RIGHT
end

function BattleSystem.SetTarget()
    -- получаем таргет (на кого тыкнул игрок)
    if BlzGetMouseFocusUnit() then
        BattleSystem.target = Unit(BlzGetMouseFocusUnit())
    end
    -- если игрок решит сменить цель - то удалим ранее созданный ивент
    if BattleSystem.target_event then
        BattleSystem.target_event:Destroy()
    end
    -- регистрируем ивент для таргета
    if IsPlayerEnemy(GetLocalPlayer(), BattleSystem.target:GetOwner()) then
        BattleSystem.target_event = EventsUnit(BattleSystem.target)
        BattleSystem.target_event:RegisterDamaged()
        BattleSystem.target_event:AddAction(BattleSystem.ShowDamage)
    end
end

function BattleSystem.ShowDamage()
    local unit = GetTriggerUnit()
    local damage = GetEventDamage()
    if damage ~= 0. and not BattleSystem.disable then
        TextTag(damage, unit):Preset("damage")
    end
end

-- Copyright (c) meiso

-- Обертки над близовскими функциями для работы с областями и их переделка под себя

function GroupHeroesInArea(area, which_player)
    return GetUnitsInRectOfPlayer(area, which_player)
end

function GroupUnitsInRect(rect, boolexpr)
    return GetUnitsInRectMatching(rect, Condition(boolexpr))
end

function GroupHeroesInRangeOnSpell(loc, radius, expr, which_player)
    local group_heroes = CreateGroup()
    bj_groupEnumOwningPlayer = which_player
    GroupEnumUnitsInRangeOfLoc(group_heroes, loc, radius, expr)
    return group_heroes
end

function GroupUnitsInRangeOfLocUnit(radius, which_location)
    local group_heroes = CreateGroup()
    GroupEnumUnitsInRangeOfLoc(group_heroes, which_location, radius, nil)
    return group_heroes
end

function GetUnitInArea(group_heroes)
    bj_groupRandomConsidered = 0
    bj_groupRandomCurrentPick = nil

    ForGroup(group_heroes, GroupPickRandomUnitEnum)
    DestroyGroup(group_heroes)

    return bj_groupRandomCurrentPick
end

--возвращает вектор между двумя юнитами
function GetVectorBetweenUnits(first_unit, second_unit, process)
    local vector_x = GetLocationX(second_unit) - GetLocationX(first_unit)
    local vector_y = GetLocationY(second_unit) - GetLocationY(first_unit)

    if process then
        if math.abs(vector_x) > 50 and math.abs(vector_x) < 150 then
            vector_x = vector_x * GetRandomReal(5, 7)
        end
        if math.abs(vector_y) > 50 and math.abs(vector_y) < 150 then
            vector_y = vector_x * GetRandomReal(5, 7)
        end
    end
    return Location(vector_x, vector_y)
end

-- Copyright (c) meiso

-- Описания классов

paladin_tooltip = "Паладин"
paladin_text = "Паладины бьются с врагом лицом к лицу, " ..
        "полагаясь на тяжелые доспехи и навыки целительства. " ..
        "Прочный щит или двуручное оружие — не столь важно, чем владеет паладин. " ..
        "Он сумеет не только защитить соратников от вражеских когтей и клинков, " ..
        "но и удержит группу на ногах при помощи исцеляющих заклинаний."

priest_tooltip = "Жрец"
priest_text = "Жрецы могут задействовать мощную целительную магию, " ..
        "чтобы спасти себя и своих спутников. Им подвластны и сильные " ..
        "атакующие заклинания, но физическая слабость и отсутствие прочных " ..
        "доспехов заставляют жрецов бояться сближения с противником. " ..
        "Опытные жрецы используют боевые и контролирующие способности, " ..
        "не допуская гибели членов отряда."

deathknight_tooltip = "Рыцарь смерти"
deathknight_text = "Рыцари смерти сходятся с противником в ближнем бою, дополняя удары " ..
        "клинка темной магией, которая делает врага уязвимым или ранит его нечестивой " ..
        "энергией. Они провоцируют противников, вынуждая их сражаться один на один и " ..
        "не подпуская их к более слабым союзникам. Чтобы не дать противнику ускользнуть, " ..
        "рыцари смерти должны постоянно помнить о силе, извлекаемой из рун, и " ..
        "соответствующим образом направлять свои атаки."

druid_tooltip = "Друид"
druid_text = "Друиды могут подходить к сражению совершенно по-разному. Они вольны " ..
        "играть почти любую роль в команде: быть целителями, танками или бойцами, но " ..
        "должны помнить об особенностях каждой роли. Друид вынужден внимательно " ..
        "подбирать облик к ситуации, так как каждый из них служит определенной цели."

shaman_tooltip = "Шаман"
shaman_text = "В бою шаман ставит на землю контролирующие и наносящие урон тотемы, " ..
        "чтобы помочь союзникам и ослабить противника. Шаманы могут как вступать в " ..
        "ближний бой, так и атаковать с расстояния. Мудрый шаман всегда старается " ..
        "учитывать сильные и слабые стороны врага."

warrior_tooltip = "Воин"
warrior_text = "Воины тщательно готовятся к бою, а с противником сражаются лицом к лицу, " ..
        "принимая все удары на свои доспехи. Они пользуются различными боевыми " ..
        "тактиками и применяют разнообразное оружие, чтобы защитить своих более " ..
        "хрупких союзников. Для максимальной эффективности воины должны " ..
        "контролировать свою ярость — ту силу, что питает их наиболее опасные атаки."

mage_tooltip = "Маг"
mage_text = "Маги уничтожают врагов тайными заклинаниями. Несмотря на магическую силу, " ..
        "маги хрупки, не носят тяжелых доспехов, поэтому уязвимы в ближнем бою. " ..
        "Умные маги при помощи заклинаний удерживают врага на расстоянии или вовсе " ..
        "обездвиживают его."

rogue_tooltip = "Разбойник"
rogue_text = "Разбойники часто нападают из теней, начиная бой комбинацией свирепых ударов. " ..
        "В затяжном бою они изматывают врага тщательно продуманной серией атак, " ..
        "прежде чем нанести решающий удар. Разбойнику следует внимательно отнестись " ..
        "к выбору противника, чтобы оптимально использовать тактику, и не упустить момент, " ..
        "когда надо спрятаться или бежать, если ситуация складывается не в их пользу."

warlock_tooltip = "Чернокнижник"
warlock_text = "Чернокнижники уничтожают ослабленного противника, сочетая увечащие болезни и " ..
        "темную магию. Находясь под защитой своих питомцев, чернокнижники разят врага " ..
        "на расстоянии. Физически слабые колдуны не могут носить тяжелую броню, " ..
        "поэтому подставляют под вражеские удары своих слуг."

hunter_tooltip = "Охотник"
hunter_text = "Охотники бьют врага на расстоянии или в ближнем бою, " ..
        "приказывая питомцам атаковать, пока сами натягивают тетиву, " ..
        "заряжают ружье или разят древковым оружием. Их оружие действенно и вблизи, " ..
        "и издалека. Кроме того, охотники очень подвижны. " ..
        "Они могут уклониться от атаки или задержать противника, контролируя поле боя."

-- Описания способностей
----------------------------------------------------
-- Паладин

consecration_tooltip = "Освящение (R)"
consecration_desc = "Освящает участок земли, на котором стоит паладин, " ..
        "нанося урон от светлой магии в течение 8 сек., противникам, которые находятся на этом участке"

judgement_of_light_tooltip = "Правосудие света (D)"
judgement_of_light_desc = "Высвобождает энергию печати и обрушивает ее на противника, после чего в течение 20 сек. " ..
        "после чего каждая атака против него может восстановить 2% от максимального запаса здоровья атакующего."

judgement_of_wisdom_tooltip = "Правосудие мудрости (F)"
judgement_of_wisdom_desc = "Высвобождает энергию печати и обрушивает ее на противника, после чего в течение 20 сек. " ..
        "после чего каждая атака против него может восстановить 2% базового запаса маны атакующего."

shield_of_righteousness_tooltip = "Щит праведности (W)"
shield_of_righteousness_desc = "Мощный удар щитом, наносящий урон от светлой магии. " ..
        "Величина урона рассчитывается исходя из показателя блока и увеличивается на 520 ед. дополнительно."

-- Copyright (c) meiso

HeroSelector = {
    table = nil,
    paladin = nil,
    priest = nil,
    dk = nil,
    druid = nil,
    shaman = nil,
    warrior = nil,
    mage = nil,
    rogue = nil,
    warlock = nil,
    hunter = nil,
    hero = nil,
    selected_heroes = {},
}

function HeroSelector.Init()
    HeroSelector.table = Frame("HeroSelector")
    HeroSelector.table:SetAbsPoint(FRAMEPOINT_CENTER, 0.4, 0.3)

    HeroSelector.InitPaladinSelector()
    HeroSelector.InitPriestSelector()
    HeroSelector.InitDKSelector()
    HeroSelector.InitDruidSelector()
    HeroSelector.InitShamanSelector()
    HeroSelector.InitWarriorSelector()
    HeroSelector.InitMageSelector()
    HeroSelector.InitRogueSelector()
    HeroSelector.InitWarlockSelector()
    HeroSelector.InitHunterSelector()
end

function HeroSelector.InitPaladinSelector()
    HeroSelector.paladin = Frame(Frame:GetFrameByName("Paladin_Button"))
    HeroSelector.paladin:SetTooltip(paladin_tooltip, paladin_text)
    HeroSelector.ConfirmCharacter(HeroSelector.paladin)
end

function HeroSelector.InitPriestSelector()
    HeroSelector.priest = Frame(Frame:GetFrameByName("Priest_Button"))
    HeroSelector.priest:SetTooltip(priest_tooltip, priest_text)
    HeroSelector.ConfirmCharacter(HeroSelector.priest)
end

function HeroSelector.InitDKSelector()
    HeroSelector.dk = Frame(Frame:GetFrameByName("DeathKnight_Button"))
    HeroSelector.dk:SetTooltip(deathknight_tooltip, deathknight_text)
    HeroSelector.ConfirmCharacter(HeroSelector.dk)
end

function HeroSelector.InitDruidSelector()
    HeroSelector.druid = Frame(Frame:GetFrameByName("Druid_Button"))
    HeroSelector.druid:SetTooltip(druid_tooltip, druid_text)
    HeroSelector.ConfirmCharacter(HeroSelector.druid)
end

function HeroSelector.InitShamanSelector()
    HeroSelector.shaman = Frame(Frame:GetFrameByName("Shaman_Button"))
    HeroSelector.shaman:SetTooltip(shaman_tooltip, shaman_text)
    HeroSelector.ConfirmCharacter(HeroSelector.shaman)
end

function HeroSelector.InitWarriorSelector()
    HeroSelector.warrior = Frame(Frame:GetFrameByName("Warrior_Button"))
    HeroSelector.warrior:SetTooltip(warrior_tooltip, warrior_text)
    HeroSelector.ConfirmCharacter(HeroSelector.warrior)
end

function HeroSelector.InitMageSelector()
    HeroSelector.mage = Frame(Frame:GetFrameByName("Mage_Button"))
    HeroSelector.mage:SetTooltip(mage_tooltip, mage_text)
    HeroSelector.ConfirmCharacter(HeroSelector.mage)
end

function HeroSelector.InitRogueSelector()
    HeroSelector.rogue = Frame(Frame:GetFrameByName("Rogue_Button"))
    HeroSelector.rogue:SetTooltip(rogue_tooltip, rogue_text)
    HeroSelector.ConfirmCharacter(HeroSelector.rogue)
end

function HeroSelector.InitWarlockSelector()
    HeroSelector.warlock = Frame(Frame:GetFrameByName("Warlock_Button"))
    HeroSelector.warlock:SetTooltip(warlock_tooltip, warlock_text)
    HeroSelector.ConfirmCharacter(HeroSelector.warlock)
end

function HeroSelector.InitHunterSelector()
    HeroSelector.hunter = Frame(Frame:GetFrameByName("Hunter_Button"))
    HeroSelector.hunter:SetTooltip(hunter_tooltip, hunter_text)
    HeroSelector.ConfirmCharacter(HeroSelector.hunter)
end

function HeroSelector.ConfirmCharacter(hero)
    local dialog = EventsFrame(hero:GetHandle())
    dialog:RegisterControlClick()
    dialog:AddAction(function()
        local confirm = Frame("ConfirmCharacter")
        local trig = EventsFrame(confirm:GetHandle())
        trig:RegisterDialogAccept()
        trig:RegisterDialogCancel()
        trig:AddAction(function()
            if dialog:GetEvent() == FRAMEEVENT_DIALOG_ACCEPT then
                dialog:Destroy()
                local tmp = split(hero:GetName(), "_")[1]
                HeroSelector.hero = tmp:lower()
                HeroSelector.AcceptHero(HeroSelector.hero)
                HeroSelector.Close()
            end
            confirm:Destroy()
        end)
    end)
end

function HeroSelector.CreateHero()
    local playerid = GetConvertedPlayerId(GetTriggerPlayer())
    local unit = Unit(GetTriggerPlayer(), HEROES[HeroSelector.hero], Location(-60., -750.))
    SaveSystem.hero[playerid] = unit:GetId()
    SaveSystem.AddHeroAbilities(HeroSelector.hero)
end

function HeroSelector.AcceptHero(hero)
    local function check()
        for _, h in pairs(HeroSelector.selected_heroes) do
            if h == hero then
                return true
            end
        end
        return false
    end
    if check() then
        return
    end
    table.insert(HeroSelector.selected_heroes, hero)
    HeroSelector.CreateHero()
end

function HeroSelector.Close()
    HeroSelector.table:Destroy()
end

-- Copyright (c) meiso

avengers_shield = Ability(
        AVENGERS_SHIELD,
        "Щит мстителя (C)",
        "Бросает в противника священный щит, наносящий ему урон от светлой магии. " ..
                "Щит затем перескакивает на других находящихся поблизости противников. " ..
                "Способен воздействовать на 3 цели.",
        "ReplaceableTextures/CommandButtons/avengers_shield.tga"
)

blessing_of_kings = Ability(
        BLESSING_OF_KINGS,
        "Благословение королей (Z)",
        "Благословляет дружественную цель, повышая все ее характеристики на 10 на 10 мин.",
        "ReplaceableTextures/CommandButtons/blessing_of_kings.tga",
        "Благословение королей",
        "Все характеристики повышены на 10."
)

blessing_of_might = Ability(
        BLESSING_OF_MIGHT,
        "Благословение могущества (V)",
        "Благословляет дружественную цель, увеличивая силу атаки на 550. Эффект длится 10 мин.",
        "ReplaceableTextures/CommandButtons/blessing_of_might.tga",
        "Благословение могущества",
        "Сила атаки увеличена на 550."
)

blessing_of_wisdom = Ability(
        BLESSING_OF_WISDOM,
        "Благословение мудрости (C)",
        "Благословляет дружественную цель, восполняя ей 92 ед. маны раз в 5 секунд в течение 10 мин.",
        "ReplaceableTextures/CommandButtons/blessing_of_wisdom.tga",
        "Благословение мудрости",
        "Восполнение 92 ед. маны раз в 5 сек."
)

blessing_of_sanctuary = Ability(
        BLESSING_OF_SANCTUARY,
        "Благословение неприкосновенности (X)",
        "Благословляет дружественную цель, уменьшая любой наносимый ей урон на 3 и " ..
                "повышая ее силу и выносливость на 10. Эффект длится 10 мин.",
        "ReplaceableTextures/CommandButtons/blessing_of_sanctuary.tga",
        "Благословение неприкосновенности",
        "Получаемый урон снижен на 3, сила и выносливость повышены на 10. Если вы парируете, " ..
                "блокируете атаку или уклоняетесь от нее, вы восполняете 2 от максимального запаса маны."
)

consecration = Ability(
        CONSECRATION,
        "Освящение (R)",
        "Освящает участок земли, на котором стоит паладин, " ..
                "нанося урон от светлой магии в течение 8 сек., противникам, которые находятся на этом участке",
        "ReplaceableTextures/CommandButtons/consecration.tga"
)

judgement_of_light_tr = Ability(
        JUDGEMENT_OF_LIGHT_TR,
        "Правосудие света (D)",
        "Высвобождает энергию печати и обрушивает ее на противника, после чего в течение 20 сек. " ..
                "после чего каждая атака против него может восстановить 2% от максимального запаса здоровья атакующего.",
        "ReplaceableTextures/CommandButtons/judgement_of_light.tga"
)

judgement_of_wisdom_tr = Ability(
        JUDGEMENT_OF_WISDOM_TR,
        "Правосудие мудрости (F)",
        "Высвобождает энергию печати и обрушивает ее на противника, после чего в течение 20 сек. " ..
                "после чего каждая атака против него может восстановить 2% базового запаса маны атакующего.",
        "ReplaceableTextures/CommandButtons/judgement_of_wisdom.tga"
)

shield_of_righteousness = Ability(
        SHIELD_OF_RIGHTEOUSNESS,
        "Щит праведности (W)",
        "Мощный удар щитом, наносящий урон от светлой магии. " ..
                "Величина урона рассчитывается исходя из показателя блока и увеличивается на 520 ед. дополнительно.",
        "ReplaceableTextures/CommandButtons/shield_of_righteousness.tga"
)

-------------------------------------------

flash_heal = Ability(
        FLASH_HEAL,
        "Быстрое исцеление (Q)",
        "Восстанавливает 1887 - 2193 ед. здоровья союзнику.",
        "ReplaceableTextures/CommandButtons/flash_heal.tga"
)

renew = Ability(
        RENEW,
        "Обновление (E)",
        "Восстанавливает цели 1400 ед. здоровья в течение 15 сек.",
        "ReplaceableTextures/CommandButtons/renew.tga",
        "Обновление",
        "Восстановление 280 ед. здоровья раз в 3 с."
)

power_word_shield = Ability(
        POWER_WORD_SHIELD,
        "Слово силы: Щит (S)",
        "Вытягивает частичку души союзника и создает из нее щит, способный поглотить 2230 ед. урона. " ..
                "Время действия – 30 сек.. Пока персонаж защищен, произнесение им заклинаний не может быть прервано " ..
                "получением урона. Повторно наложить щит можно только через 15 сек.",
        "ReplaceableTextures/CommandButtons/power_word_shield.tga",
        "Слово силы: Щит",
        "Поглощение урона."
)

weakened_soul = Ability(
        "",
        "Ослабленная душа",
        "Персонаж не может быть целью заклинания 'Слово Силы: Щит'.",
        "ReplaceableTextures/CommandButtons/weakened_soul.tga"
)

guardian_spirit = Ability(
        GUARDIAN_SPIRIT,
        "Оберегающий дух (R)",
        "Призывает оберегающего духа для охраны дружественной цели. " ..
                "Дух улучшает действие всех эффектов исцеления на выбранного союзника на 40 и спасает его от смерти, " ..
                "жертвуя собой. Смерть духа прекращает действие эффекта улучшенного исцеления, но восстанавливает цели " ..
                "50 ее максимального запаса здоровья. Время действия – 10 сек.",
        "ReplaceableTextures/CommandButtons/guardian_spirit.tga",
        "Оберегающий дух",
        "Получаемое исцеление увеличено на 40. Предотвращает один смертельный удар."
)

prayer_of_mending = Ability(
        PRAYER_OF_MENDING,
        "Молитва восстановления (D)",
        "Молитва оберегает союзника и восстанавливает ему 1043 ед. здоровья при следующем " ..
                "получении урона. После исцеления заклинание переходит к другому участнику рейда в пределах 20 м. " ..
                "Молитва может совершать переход 5 раз и длится 30 сек.. после смены цели. Это заклинание можно накладывать " ..
                "только на одну цель одновременно.",
        "ReplaceableTextures/CommandButtons/prayer_of_mending.tga",
        "Молитва восстановления",
        "Восстанавливает 1043 ед. здоровья при последующем получении урона."
)

circle_of_healing = Ability(
        CIRCLE_OF_HEALING,
        "Круг исцеления (W)",
        "Восстанавливает 958 - 1058 ед. здоровья участникам группы или рейда," ..
                "находящимся в радиусе 15 м от выбранной цели. Может излечить до 5 персонажей.",
        "ReplaceableTextures/CommandButtons/circle_of_healing.tga"
)

prayer_of_fortitude = Ability(
        PRAYER_OF_FORTITUDE,
        "Молитва стойкости",
        "Повышает выносливость всех участников группы или рейда на 165 ед. на 1 ч.",
        "ReplaceableTextures/CommandButtons/prayer_of_mending.tga",
        "Молитва стойкости",
        "Выносливость повышена на 165."
)


function DummyForDPS(location)
    local loc = location or Location(4480., 400.)
    local d = Unit(LICH_KING, FourCC('hfoo'), loc, 0.)
    d:SetMaxLife(500000, true)
    d:SetBaseDamage(4000.)
end


function DummyForHealing(location)
    local loc = location or Location(4480., 400.)
    local d = Unit(GetLocalPlayer(), FourCC('hfoo'), loc, 0.)
    d:SetMaxLife(500000)
    d:SetLife(100)
end


function CultAdherent.DarkMartyrdom()
    -- взрывается нанося урон в радиусе 8 метров
    --TODO: добавить эффект и паузу
    CultAdherent.unit:DealMagicDamageLoc {
        damage=1504, location=CultAdherent.unit:GetLoc(), radius=8
    }
    CultAdherent.summoned = false
    CultAdherent.morphed = false
end

function CultAdherent.LowHP()
    if CultAdherent.unit:GetCurrentLife() <=
            CultAdherent.unit:GetPercentLifeOfMax(20) then
        return true
    end
    return false
end

function CultAdherent.InitDarkMartyrdom()
    local event = EventsUnit(CultAdherent.unit)
    event:RegisterAttacked()
    event:AddCondition(CultAdherent.LowHP)
    event:AddAction(CultAdherent.DarkMartyrdom)
end


function CultAdherent.Init(location, face)
    local current_hp
    local current_mp
    --определяем кого суммонить
    local adherent = CULT_ADHERENT
    if CultAdherent.morphed then adherent = CULT_ADHERENT_MORPH end

    --если уже призван - уберём и сохраним хп и мп
    if CultAdherent.unit then
        current_hp = CultAdherent.unit:GetCurrentLife()
        current_mp = CultAdherent.unit:GetCurrentMana()
        CultAdherent.unit:Remove()
    end

    CultAdherent.unit = Unit(LICH_KING, adherent, location, face)

    if CultAdherent.summoned then
        CultAdherent.unit:SetBaseDamage(940)
        CultAdherent.unit:SetMaxLife(51720, true)
        CultAdherent.unit:SetMaxMana(65250, true)
    end
    if CultAdherent.morphed then
        CultAdherent.unit:SetBaseDamage(1254)
        CultAdherent.unit:SetLife(current_hp)
        CultAdherent.unit:SetMana(current_mp)
    end

    CultAdherent.unit:SetArmor(220)

    CultAdherent.InitDarkMartyrdom()
end


function CultFanatic.DarkMartyrdom()
    -- взрывается нанося урон в радиусе 8 метров
    --TODO: добавить эффект и паузу
    CultFanatic.unit:DealMagicDamageLoc {
        damage=1504, location=CultFanatic.unit:GetLoc(), radius=8
    }
    CultFanatic.summoned = false
    CultFanatic.morphed = false
end

function CultFanatic.LowHP()
    if CultFanatic.unit:GetCurrentLife() <=
            CultFanatic.unit:GetPercentLifeOfMax(20) then
        return true
    end
    return false
end

function CultFanatic.InitDarkMartyrdom()
    local event = EventsUnit(CultFanatic.unit)
    event:RegisterAttacked()
    event:AddCondition(CultFanatic.LowHP)
    event:AddAction(CultFanatic.DarkMartyrdom)
end


function CultFanatic.Init(location, face)
    local current_hp
    --определяем кого суммонить
    local fanatic = CULT_FANATIC
    if CultFanatic.morphed then fanatic = CULT_FANATIC_MORPH end

    --если уже призван - уберём и сохраним хп
    if CultFanatic.unit then
        current_hp = CultFanatic.unit:GetCurrentLife()
        CultFanatic.unit:Remove()
    end

    CultFanatic.unit = Unit(LICH_KING, fanatic, location, face)

    if CultFanatic.summoned then
        CultFanatic.unit:SetBaseDamage(940)
        CultFanatic.unit:SetMaxLife(64650, true)
    end
    if CultFanatic.morphed then
        CultFanatic.unit:SetBaseDamage(1254)
        CultFanatic.unit:SetLife(current_hp)
    end

    --CultFanatic.unit:SetBaseDamage(1881, 1)
    CultFanatic.unit:SetArmor(220)

    CultFanatic.InitDarkMartyrdom()
end

-- Copyright (c) meiso

function LordMarrowgar.BoneSpike()
    TriggerSleepAction(GetRandomReal(14., 17.))
    local gr = GroupHeroesInArea(gg_rct_areaLM, GetOwningPlayer(GetAttacker()))
    local target_enemy = GetUnitInArea(gr)
    local target_enemy_health = GetUnitState(target_enemy, UNIT_STATE_MAX_LIFE)

    if LordMarrowgar.bonespike_effect then
        -- призываем шип в позиции атакованной цели
        local bone_spike_obj = Unit(LICH_KING, BONE_SPIKE_OBJ, GetUnitLoc(target_enemy)):GetId()

        SetUnitAnimation(bone_spike_obj, "Stand Lumber")
        SetUnitFlyHeight(target_enemy, 150., 0.)

        PauseUnit(target_enemy, true)
        PauseUnit(bone_spike_obj, true)

        -- сразу 9к
        SetUnitState(target_enemy, UNIT_STATE_LIFE, GetUnitState(target_enemy, UNIT_STATE_LIFE) - 9000.)

        while true do
            SetUnitState(target_enemy, UNIT_STATE_LIFE, GetUnitState(target_enemy, UNIT_STATE_LIFE) - (target_enemy_health * 0.10))
            TriggerSleepAction(3.)

            -- TODO: поменять время разложения
            -- если шип уничтожен - выходим и сбрасываем игрока
            if GetUnitState(bone_spike_obj, UNIT_STATE_LIFE) <= 0 then
                SetUnitAnimation(bone_spike_obj, "Decay")
                SetUnitFlyHeight(target_enemy, 0., 0.)
                PauseUnit(target_enemy, false)
                RemoveUnit(bone_spike_obj)
                LordMarrowgar.bonespike_effect = false
                break
            -- если игрок умер - сбрасываем шип
            elseif GetUnitState(target_enemy, UNIT_STATE_LIFE) <= 0 then
                RemoveUnit(bone_spike_obj)
                LordMarrowgar.bonespike_effect = false
                break
            end
        end
    end
end

-- если шип не призван
function LordMarrowgar.StartBoneSpike()
    if not LordMarrowgar.bonespike_effect then
        LordMarrowgar.bonespike_effect = true
        return true
    end
    return false
end

function LordMarrowgar.InitBoneSpike()
    local event = EventsUnit(LordMarrowgar.unit)
    event:RegisterAttacked()
    event:AddCondition(LordMarrowgar.StartBoneSpike)
    event:AddAction(LordMarrowgar.BoneSpike)
end


-- Copyright (c) meiso

function LordMarrowgar.Coldflame()
    TriggerSleepAction(GetRandomReal(2., 3.))

    local target = Unit(GetUnitInArea(GroupHeroesInArea(gg_rct_areaLM,
            GetOwningPlayer(GetAttacker()))))
    local lord_location = LordMarrowgar.unit:GetLoc()
    local target_location = target:GetLoc()

    if LordMarrowgar.coldflame_effect then
        -- призываем дамми-юнита и направляем его в сторону игрока
        local coldflame_obj = Unit(GetTriggerPlayer(), DUMMY, lord_location)
        coldflame_obj:SetMoveSpeed(0.6)
        coldflame_obj:SetPathing(false)

        -- через 9 сек дамми-юнит должен умереть
        coldflame_obj:ApplyTimedLife(9.)

        while true do
            coldflame_obj:MoveToLoc(target_location)
            -- другим дамми-юнитом кастуем flame strike, иммитируя coldflame
            LordMarrowgar.coldflame:CastToTarget("flamestrike", coldflame_obj)
            TriggerSleepAction(0.03)
            if coldflame_obj:GetCurrentLife() <= 0 then
                break
            end
        end
        LordMarrowgar.coldflame_effect = false
    end
end

function LordMarrowgar.StartColdflame()
    if not LordMarrowgar.coldflame_effect then
        LordMarrowgar.coldflame_effect = true
        return true
    end
    return false
end

function LordMarrowgar.InitColdflame()
    local event = EventsUnit(LordMarrowgar.unit)
    event:RegisterAttacked()
    event:AddCondition(LordMarrowgar.StartColdflame)
    event:AddAction(LordMarrowgar.Coldflame)
end


function LordMarrowgar.Init()
    local items_list = {"ARMOR_ITEM", "ATTACK_ITEM", "HP_ITEM"}
    local items_spells_list = {"ARMOR_500", "ATTACK_1500", "HP_90K"}

    LordMarrowgar.unit = Unit(LICH_KING, LORD_MARROWGAR, Location(4090., -1750.), -131.)
    LordMarrowgar.coldflame = Unit(LICH_KING, DUMMY, Location(4410., -1750.), -131.)

    EquipSystem.RegisterItems(items_list, items_spells_list)
    EquipSystem.AddItemsToUnit(LordMarrowgar.unit, items_list)

    LordMarrowgar.unit:SetLevel(83)

    LordMarrowgar.coldflame:AddAbilities(COLDFLAME)
    --LordMarrowgar.unit:AddAbilities(WHIRLWIND)

    LordMarrowgar.InitColdflame()
    --LordMarrowgar.InitBoneSpike()
    --LordMarrowgar.InitWhirlwind()
end

-- Copyright (c) meiso

function LordMarrowgar.ResetAnimation()
    if LordMarrowgar.whirlwind_effect then
        LordMarrowgar.whirlwind_effect = false
    end
    DestroyTimer(GetExpiredTimer())
end

function LordMarrowgar.Whirlwind()
    local whirlwind_timer = CreateTimer()

    local function action()
        local timer_reset = CreateTimer()
        IssueImmediateOrder(LordMarrowgar.unit:GetId(), "whirlwind")
        TimerStart(timer_reset, 5., false, LordMarrowgar.ResetAnimation)
        DestroyTimer(whirlwind_timer)
    end

    if LordMarrowgar.whirlwind_effect then
        TimerStart(whirlwind_timer, GetRandomReal(20., 30.), false, action)
    end
end

function LordMarrowgar.StartWhirlwind()
    if not LordMarrowgar.whirlwind_effect then
        LordMarrowgar.whirlwind_effect = true
        return true
    end
    return false
end

function LordMarrowgar.InitWhirlwind()
    local event = EventsUnit(LordMarrowgar.unit)
    event:RegisterAttacked()
    event:AddCondition(LordMarrowgar.StartWhirlwind)
    event:AddAction(LordMarrowgar.Whirlwind)
end

-- Copyright (c) meiso

function LadyDeathwhisper.DeathAndDecay()
    local model = "Abilities\\Spells\\Items\\VampiricPotion\\VampPotionCaster.mdl"
    local effect
    if LadyDeathwhisper.death_and_decay_effect then
        local loc = GetUnitLoc(GetAttacker())
        effect = AddSpecialEffectLoc(model, loc)
        LadyDeathwhisper.unit:DealMagicDamageLoc {
            damage = 450., location = loc, radius = 15
        }
        TriggerSleepAction(10.)
        LadyDeathwhisper.death_and_decay_effect = false
        DestroyEffect(effect)
    end
end

function LadyDeathwhisper.DeathAndDecayExist()
    if not LadyDeathwhisper.death_and_decay_effect then
        LadyDeathwhisper.death_and_decay_effect = true
        return true
    end
    return false
end

function LadyDeathwhisper.InitDeathAndDecay()
    local event = EventsUnit(LadyDeathwhisper.unit)
    event:RegisterAttacked()
    event:AddCondition(LadyDeathwhisper.DeathAndDecayExist)
    event:AddAction(LadyDeathwhisper.DeathAndDecay)
end

-- Copyright (c) meiso

function LadyDeathwhisper.DominateMind()
    --TODO: исправить на нормальную реализацию
    local target = GetAttacker()
    local prev_owner = GetOwningPlayer(target)
    if LadyDeathwhisper.dominate_mind_effect then
        SetUnitOwner(target, LICH_KING, true)
        TriggerSleepAction(5.)
        SetUnitOwner(target, prev_owner, true)
        TriggerSleepAction(20.)
        LadyDeathwhisper.dominate_mind_effect = false
    end
end

function LadyDeathwhisper.DominateMindExist()
    if not LadyDeathwhisper.dominate_mind_effect then
        LadyDeathwhisper.dominate_mind_effect = true
        return true
    end
    return false
end

function LadyDeathwhisper.InitDominateMind()
    local event = EventsUnit(LadyDeathwhisper.unit)
    event:RegisterAttacked()
    event:AddCondition(LadyDeathwhisper.DominateMindExist)
    event:AddAction(LadyDeathwhisper.DominateMind)
end

-- Copyright (c) meiso

function LadyDeathwhisper.FrostBolt()
    --TriggerSleepAction(10.)
    local enemy = Unit(GetUnitInArea(GroupHeroesInArea(gg_rct_areaLD, GetOwningPlayer(GetAttacker()))))
    local enemy_movespeed = enemy:GetMoveSpeed()

    local model_name = "Abilities\\Spells\\Other\\FrostBolt\\FrostBoltMissile.mdl"

    local fb = UnitSpell(LadyDeathwhisper.unit:GetId())
    local effect = Effect(fb, model_name)
    while true do
        TriggerSleepAction(0.)
        fb:MoveToUnit(enemy)
        if fb:NearTarget(enemy) then
            local damage = GetRandomInt(100., 120.)
            print("FrostBolt", damage)
            LadyDeathwhisper.unit:DealMagicDamage(enemy, damage)
            enemy:SetMoveSpeed(enemy_movespeed / 2)
            break
        end
    end
    effect:Destroy()
    fb:Remove()
end

function LadyDeathwhisper.FBCheckPhase()
    if LadyDeathwhisper.phase == 2 then
        return true
    end
    return false
end

function LadyDeathwhisper.InitFrostBolt()
    local event = EventsUnit(LadyDeathwhisper.unit)
    event:RegisterAttacked()
    event:AddCondition(LadyDeathwhisper.FBCheckPhase)
    event:AddAction(LadyDeathwhisper.FrostBolt)
end


-- Copyright (c) meiso

function LadyDeathwhisper.FrostBoltVolley()
    TriggerSleepAction(15.)
    local model_name = "Abilities\\Spells\\Other\\FrostBolt\\FrostBoltMissile.mdl"

    local function frostbolt(enemy)
        local fb = UnitSpell(LadyDeathwhisper.unit:GetId())
        local enemy_movespeed = enemy:GetMoveSpeed()
        local effect = Effect(fb, model_name)
        while true do
            TriggerSleepAction(0.)
            fb:MoveToUnit(enemy)
            if fb:NearTarget(enemy) then
                --TODO: выставить правильный урон
                local damage = GetRandomInt(10., 12.)
                LadyDeathwhisper.unit:DealMagicDamage(enemy, damage)
                enemy:SetMoveSpeed(enemy_movespeed / 2)
                break
            end
        end
        effect:Destroy()
        fb:Remove()
    end

    local enemies = LadyDeathwhisper.unit:GetNearbyEnemies()
    local count = CountUnitsInGroup(enemies)
    for _ = 1, count do
        local enemy = Unit(GroupPickRandomUnit(enemies))
        GroupRemoveUnit(enemies, enemy:GetId())
        if LadyDeathwhisper.unit:IsEnemy(enemy) then
            StartThread(frostbolt(enemy))
        end
    end
end

function LadyDeathwhisper.FBVCheckPhase()
    if LadyDeathwhisper.phase <= 2 then
        return true
    end
    return false
end

function LadyDeathwhisper.InitFrostBoltVolley()
    local event = EventsUnit(LadyDeathwhisper.unit)
    event:RegisterAttacked()
    event:AddCondition(LadyDeathwhisper.FBVCheckPhase)
    event:AddAction(LadyDeathwhisper.FrostBoltVolley)
end


function LadyDeathwhisper.Init()
    local items_list = {"ARMOR_ITEM", "ATTACK_ITEM", "MP_ITEM"}
    local items_spells_list = {"ARMOR_500", "ATTACK_1500", "MP_50K"}

    LadyDeathwhisper.unit = Unit(LICH_KING, LADY_DEATHWHISPER, Location(4095., 1498.), 270.)

    LadyDeathwhisper.unit:SetLevel(83)
    LadyDeathwhisper.unit:SetMana(500)

    EquipSystem.RegisterItems(items_list, items_spells_list)
    EquipSystem.AddItemsToUnit(LadyDeathwhisper.unit, items_list)
    --EquipSystem.AddItemsToUnit(LadyDeathwhisper.unit, {"MP_ITEM"}, 4)

    -- both phase
    --LadyDeathwhisper.InitDeathAndDecay()
    LadyDeathwhisper.InitSummoning()
    -- только в 25-ке
    --LadyDeathwhisper.InitDominateMind()

    -- first phase
    LadyDeathwhisper.InitManaShield()
    --LadyDeathwhisper.InitShadowBolt()

    -- second phase
    --LadyDeathwhisper.InitFrostBolt()
    --LadyDeathwhisper.InitFrostBoltVolley()
end

-- Copyright (c) meiso

function LadyDeathwhisper.ManaShield()
    local event = EventsUnit(LadyDeathwhisper.unit)
    local model = "Abilities\\Spells\\Human\\ManaShield\\ManaShieldCaster.mdx"

    event:RegisterDamaged()

    if not LadyDeathwhisper.mana_shield and not LadyDeathwhisper.mana_is_over then
        LadyDeathwhisper.mana_shield = Effect(LadyDeathwhisper.unit, model, "origin")
    end

    local function ManaShield()
        local damage = GetEventDamage()

        if damage == 0 then
            event:Destroy()
            return
        end

        TriggerSleepAction(0.7)
        --можно было бы реализовать через BlzSetEventDamage, но в оригинале
        --хп у Леди явно регенилось от маны
        LadyDeathwhisper.unit:GainLife { life = damage }
        LadyDeathwhisper.unit:LoseMana { mana = damage, check = false }
        event:Destroy()
    end

    local function UsingManaShield()
        if LadyDeathwhisper.unit:GetCurrentMana() >= 10. then
            return true
        end
        LadyDeathwhisper.mana_is_over = true
        LadyDeathwhisper.phase = 2
        LadyDeathwhisper.mana_shield:Destroy()
        event:Destroy()
        return false
    end

    event:AddCondition(UsingManaShield)
    event:AddAction(ManaShield)
end

function LadyDeathwhisper.MSCheckPhase()
    if LadyDeathwhisper.phase == 1 then
        return true
    end
    return false
end

function LadyDeathwhisper.InitManaShield()
    local event = EventsUnit(LadyDeathwhisper.unit)
    event:RegisterAttacked()
    event:AddCondition(LadyDeathwhisper.MSCheckPhase)
    event:AddAction(LadyDeathwhisper.ManaShield)
end


-- Copyright (c) meiso

function LadyDeathwhisper.ShadowBolt()
    TriggerSleepAction(10.)
    local enemy = GetUnitInArea(GroupHeroesInArea(gg_rct_areaLD, GetOwningPlayer(GetAttacker())))

    local model_name = "Abilities\\Spells\\Other\\BlackArrow\\BlackArrowMissile.mdl"

    local sb = UnitSpell(LadyDeathwhisper.unit:GetId())
    local effect = Effect(sb, model_name)
    while true do
        TriggerSleepAction(0.)
        sb:MoveToUnit(enemy)
        if sb:NearTarget(enemy) then
            local damage = GetRandomReal(9200., 12000.)
            LadyDeathwhisper.unit:DealMagicDamage(enemy, damage)
            break
        end
    end
    effect:Destroy()
    sb:Remove()
end

function LadyDeathwhisper.SBCheckPhase()
    if LadyDeathwhisper.phase == 1 then
        return true
    end
    return false
end

function LadyDeathwhisper.InitShadowBolt()
    local event = EventsUnit(LadyDeathwhisper.unit)
    event:RegisterAttacked()
    event:AddCondition(LadyDeathwhisper.SBCheckPhase)
    event:AddAction(LadyDeathwhisper.ShadowBolt)
end


-- Copyright (c) meiso

function LadyDeathwhisper.Summoning()
    if not CultAdherent.summoned and not CultFanatic.summoned then
        CultAdherent.summoned = true
        CultFanatic.summoned = true
        CultAdherent.Init(Location(4671., 1483.), 350.)
        CultFanatic.Init(Location(4671., 1483.), 350.)
    end
    if not CultAdherent.morphed and CultAdherent.summoned and GetRandomReal(0., 1.) >= 0.7 then
        CultAdherent.morphed = true
        local loc = CultAdherent.unit:GetLoc()
        local face = CultAdherent.unit:GetFacing()
        CultAdherent.Init(loc, face)
    end
    if not CultFanatic.morphed and CultFanatic.summoned and GetRandomReal(0., 1.) >= 0.7 then
        CultFanatic.morphed = true
        local loc = CultFanatic.unit:GetLoc()
        local face = CultFanatic.unit:GetFacing()
        CultFanatic.Init(loc, face)
    end
end

function LadyDeathwhisper.SummonCheckPhase()
    if LadyDeathwhisper.phase == 2 then
        return true
    end
    return false
end

function LadyDeathwhisper.InitSummoning()
    local event = EventsUnit(LadyDeathwhisper.unit)
    event:RegisterAttacked()
    event:AddCondition(LadyDeathwhisper.SummonCheckPhase)
    event:AddAction(LadyDeathwhisper.Summoning)
end

-- Copyright (c) meiso

function Paladin.AvengersShield()
    local target = Unit(GetSpellTargetUnit())
    local light_magic_damage = 1
    local factor = 0.07
    --т.к. силы атаки так таковой нет, то считается она, как сила героя помноженная на 2
    local attack_power = GetHeroStr(GetTriggerUnit(), true) * AP

    local damage = 0
    local model_name = "Aegis.mdl"

    local exclude_targets = {}

    local function AddTarget(target_, exc)
        table.insert(exc, target_:GetId())
    end

    local function TargetTookDamage(target_, exc)
        for i = 1, #exc do
            if target_ == exc[i] then
                return true
            end
        end
        return false
    end

    local function GetTarget(target_, exc)
        local temp
        local group = GroupUnitsInRangeOfLocUnit(200, target_:GetLoc())
        for _ = 1, CountUnitsInGroup(group) do
            TriggerSleepAction(0.)
            temp = GroupPickRandomUnit(group)
            if not TargetTookDamage(temp, exc) and
                    not IsUnitAlly(temp, GetOwningPlayer(GetTriggerUnit())) then
                return Unit(temp)
            end
            GroupRemoveUnit(group, temp)
        end
        DestroyGroup(group)
        return 0
    end

    local i = 0
    local shield = UnitSpell(Paladin.hero:GetId())
    local effect = Effect(shield, model_name, "overhead")
    while i < 3 do
        TriggerSleepAction(0.)
        shield:MoveToUnit(target)
        if target:IsDied() then
            target = GetTarget(target, exclude_targets)
            if target == 0 then
                break
            end
            i = i + 1
        end
        if shield:NearTarget(target) then
            damage = R2I(GetRandomInt(1100, 1344) + (factor * light_magic_damage) + (factor * attack_power))
            Paladin.hero:DealPhysicalDamage(target, damage)
            TextTag(damage, target):Preset("spell")
            AddTarget(target, exclude_targets)
            target = GetTarget(target, exclude_targets)
            if target == 0 then
                break
            end
            i = i + 1
        end
    end
    effect:Destroy()
    shield:Remove()
end

function Paladin.IsAvengersShield()
    return avengers_shield:SpellCasted()
end

function Paladin.InitAvengersShield()
    avengers_shield:Init()
    Paladin.hero:SetAbilityManacost(avengers_shield:GetId(), 26)
    Paladin.hero:SetAbilityCooldown(avengers_shield:GetId(), 30.)
    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Paladin.IsAvengersShield)
    event:AddAction(Paladin.AvengersShield)
end

-- Copyright (c) meiso

function Paladin.RemoveBlessingOfKings(unit, stat, timer)
    if BuffSystem.IsBuffOnHero(unit, blessing_of_kings) then
        SetHeroStr(unit, GetHeroStr(unit, false) - stat[1], false)
        SetHeroAgi(unit, GetHeroAgi(unit, false) - stat[2], false)
        SetHeroInt(unit, GetHeroInt(unit, false) - stat[3], false)
        BuffSystem.RemoveBuffFromHero(unit, blessing_of_kings)
    end
    DestroyTimer(timer)
end

function Paladin.BlessingOfKings()
    local unit = GetSpellTargetUnit()
    BuffSystem.RegisterHero(unit)

    if BuffSystem.IsBuffOnHero(unit, blessing_of_kings) then
        BuffSystem.RemoveBuffFromHeroByFunc(unit, blessing_of_kings)
    end

    --массив с доп. статами
    local stat = {
        R2I(GetHeroStr(unit, false) * 0.1),
        R2I(GetHeroAgi(unit, false) * 0.1),
        R2I(GetHeroInt(unit, false) * 0.1)
    }
    --бафаем цель
    SetHeroStr(unit, GetHeroStr(unit, false) + stat[1], false)
    SetHeroAgi(unit, GetHeroAgi(unit, false) + stat[2], false)
    SetHeroInt(unit, GetHeroInt(unit, false) + stat[3], false)

    --создаем лямбду для снятия бафа
    local timer = CreateTimer()
    local remove_buff = function()
        Paladin.RemoveBlessingOfKings(unit, stat, timer)
    end

    BuffSystem.AddBuffToHero(unit, blessing_of_kings, remove_buff)

    --скидываем баф через 10 минут
    TimerStart(timer, 600., false, remove_buff)

end

function Paladin.IsBlessingOfKings()
    return blessing_of_kings:SpellCasted()
end

function Paladin.InitBlessingOfKings()
    blessing_of_kings:Init()
    Paladin.hero:SetAbilityManacost(blessing_of_kings:GetId(), 6)
    Paladin.hero:SetAbilityCooldown(blessing_of_kings:GetId(), 1.5)

    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Paladin.IsBlessingOfKings)
    event:AddAction(Paladin.BlessingOfKings)
end

-- Copyright (c) meiso

function Paladin.RemoveBlessingOfMight(unit, timer)
    if BuffSystem.IsBuffOnHero(unit, blessing_of_might) then
        SetHeroStr(unit, GetHeroStr(unit, false) - 225, false)
        BuffSystem.RemoveBuffFromHero(unit, blessing_of_might)
    end
    DestroyTimer(timer)
end

function Paladin.BlessingOfMight()
    local unit = GetSpellTargetUnit()
    BuffSystem.RegisterHero(unit)

    if BuffSystem.IsBuffOnHero(unit, blessing_of_might) then
        BuffSystem.RemoveBuffFromHeroByFunc(unit, blessing_of_might)
    end

    -- fixme: увеличивать урон напрямую (3.5 AP = 1 ед. урона)
    SetHeroStr(unit, GetHeroStr(unit, false) + 225, false)

    local timer = CreateTimer()
    local remove_buff = function()
        Paladin.RemoveBlessingOfMight(unit, timer)
    end

    BuffSystem.AddBuffToHero(unit, blessing_of_might, remove_buff)

    TimerStart(timer, 600., false, remove_buff)
end

function Paladin.IsBlessingOfMight()
    return blessing_of_might:SpellCasted()
end

function Paladin.InitBlessingOfMight()
    blessing_of_might:Init()
    Paladin.hero:SetAbilityManacost(blessing_of_might:GetId(), 5)
    Paladin.hero:SetAbilityCooldown(blessing_of_might:GetId(), 1.5)

    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Paladin.IsBlessingOfMight)
    event:AddAction(Paladin.BlessingOfMight)
end

-- Copyright (c) meiso

function Paladin.RemoveBlessingOfSanctuary(unit, stat, items_list, timer)
    if BuffSystem.IsBuffOnHero(unit, blessing_of_sanctuary) then
        SetHeroStr(unit, GetHeroStr(unit, false) - stat, false)
        EquipSystem.RemoveItemsToUnit(unit, items_list)
        BuffSystem.RemoveBuffFromHero(unit, blessing_of_sanctuary)
    end
    DestroyTimer(timer)
end

function Paladin.BlessingOfSanctuary()
    local unit = GetSpellTargetUnit()
    local items_list = { "DEC_DMG_ITEM" }
    local items_spells_list = { "DECREASE_DMG" }

    BuffSystem.RegisterHero(unit)
    EquipSystem.RegisterItems(items_list, items_spells_list)

    if BuffSystem.IsBuffOnHero(unit, blessing_of_sanctuary) then
        BuffSystem.RemoveBuffFromHeroByFunc(unit, blessing_of_sanctuary)
    end

    EquipSystem.AddItemsToUnit(unit, items_list)
    local stat = R2I(GetHeroStr(unit, false) * 0.1)
    SetHeroStr(unit, GetHeroStr(unit, false) + stat, false)

    local timer = CreateTimer()
    local remove_buff = function()
        Paladin.RemoveBlessingOfSanctuary(unit, stat, items_list, timer)
    end

    BuffSystem.AddBuffToHero(unit, blessing_of_sanctuary, remove_buff)

    TimerStart(timer, 600., false, remove_buff)
end

function Paladin.IsBlessingOfSanctuary()
    return blessing_of_sanctuary:SpellCasted()
end

function Paladin.InitBlessingOfSanctuary()
    blessing_of_sanctuary:Init()
    Paladin.hero:SetAbilityManacost(blessing_of_sanctuary:GetId(), 7)
    Paladin.hero:SetAbilityCooldown(blessing_of_sanctuary:GetId(), 1.5)

    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Paladin.IsBlessingOfSanctuary)
    event:AddAction(Paladin.BlessingOfSanctuary)
end

-- Copyright (c) meiso

function Paladin.RemoveBlessingOfWisdom(unit, items_list, timer)
    if BuffSystem.IsBuffOnHero(unit, blessing_of_wisdom) then
        EquipSystem.RemoveItemsToUnit(unit, items_list)
        BuffSystem.RemoveBuffFromHero(unit, blessing_of_wisdom)
    end
    DestroyTimer(timer)
end

function Paladin.BlessingOfWisdom()
    local unit = GetSpellTargetUnit()
    local items_list = { "BLESSING_OF_WISDOM_ITEM" }
    local items_spells_list = { "BLESSING_OF_WISDOM" }

    BuffSystem.RegisterHero(unit)
    EquipSystem.RegisterItems(items_list, items_spells_list)

    if BuffSystem.IsBuffOnHero(unit, blessing_of_wisdom) then
        BuffSystem.RemoveBuffFromHeroByFunc(unit, blessing_of_wisdom)
    end

    EquipSystem.AddItemsToUnit(unit, items_list)

    local timer = CreateTimer()
    local remove_buff = function()
        Paladin.RemoveBlessingOfWisdom(unit, items_list, timer)
    end
    BuffSystem.AddBuffToHero(unit, blessing_of_wisdom, remove_buff)

    TimerStart(timer, 600., false, remove_buff)
end

function Paladin.IsBlessingOfWisdom()
    return blessing_of_wisdom:SpellCasted()
end

function Paladin.InitBlessingOfWisdom()
    blessing_of_wisdom:Init()
    Paladin.hero:SetAbilityManacost(blessing_of_wisdom:GetId(), 5)
    Paladin.hero:SetAbilityCooldown(blessing_of_wisdom:GetId(), 1.5)

    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Paladin.IsBlessingOfWisdom)
    event:AddAction(Paladin.BlessingOfWisdom)
end

-- Copyright (c) meiso

function Paladin.EnableConsecration()
    local location
    local light = 1
    local factor = 0.04
    local ap = GetHeroStr(Paladin.hero:GetId(), true) * 2
    local damage = 8 * (113 + factor * light + factor * ap)

    while Paladin.consecration_effect do
        location = Location(
                BlzGetLocalSpecialEffectX(Paladin.consecration_effect),
                BlzGetLocalSpecialEffectY(Paladin.consecration_effect)
        )
        Paladin.hero:DealMagicDamageLoc {
            damage = damage,
            overtime = 1.,
            location = location,
            radius = 8
        }
    end
end

function Paladin.DisableConsecration()
    DestroyTimer(GetExpiredTimer())
    DestroyEffect(Paladin.consecration_effect)
    Paladin.consecration_effect = nil
end

function Paladin.Consecration()
    local loc = Paladin.hero:GetLoc()
    local model = "Consecration_Impact_Base.mdx"
    local timer = CreateTimer()
    Paladin.consecration_effect = AddSpecialEffectLoc(model, loc)
    TimerStart(timer, 8., false, Paladin.DisableConsecration)
    Paladin.EnableConsecration()
end

function Paladin.IsConsecration()
    return consecration:SpellCasted()
end

function Paladin.InitConsecration()
    consecration:Init()
    Paladin.hero:SetAbilityManacost(consecration:GetId(), 22)
    Paladin.hero:SetAbilityCooldown(consecration:GetId(), 8.)

    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Paladin.IsConsecration)
    event:AddAction(Paladin.Consecration)
end

-- Copyright (c) meiso

function Paladin.Init(location)
    local loc = location or Location(4000., 200.)
    local items_list = {"ARMOR_ITEM", "ATTACK_ITEM", "HP_ITEM"}
    local items_spells_list = {"ARMOR_500", "ATTACK_1500", "HP_90K"}

    Paladin.hero = Unit(GetLocalPlayer(), PALADIN, loc, 90.)

    --EquipSystem.RegisterItems(items_list, items_spells_list)
    --EquipSystem.AddItemsToUnit(Paladin.hero, items_list)

    Paladin.hero:SetLevel(80)
    Paladin.hero:SetBaseMana(4394)
    Paladin.hero:SetMaxMana(4394, true)

    Paladin.hero:AddAbilities(
            DIVINE_SHIELD,
            CONSECRATION,
            HAMMER_RIGHTEOUS,
            JUDGEMENT_OF_LIGHT_TR,
            JUDGEMENT_OF_WISDOM_TR,
            SHIELD_OF_RIGHTEOUSNESS,
            AVENGERS_SHIELD,
            SPELLBOOK_PALADIN
    )

    --даём паладину книжку с бафами и пассивками
    Paladin.hero:AddSpellbook(SPELLBOOK_PALADIN)

    Paladin.InitConsecration()
    Paladin.InitBlessingOfKings()
    Paladin.InitBlessingOfMight()
    Paladin.InitBlessingOfSanctuary()
    Paladin.InitBlessingOfWisdom()
    Paladin.InitJudgementOfLight()
    Paladin.InitJudgementOfWisdom()
    Paladin.InitShieldOfRighteousness()
    Paladin.InitAvengersShield()
end

-- Copyright (c) meiso

function Paladin.RemoveJudgementOfLight(target, timer)
    if BuffSystem.IsBuffOnHero(target, JUDGEMENT_OF_LIGHT) then
        UnitRemoveAbilityBJ(JUDGEMENT_OF_LIGHT_BUFF, target)
        BuffSystem.RemoveBuffFromHero(target, JUDGEMENT_OF_LIGHT)
    end
    DestroyTimer(timer)
end

function Paladin.JudgementOfLight()
    if GetRandomReal(0., 1.) <= 0.7 then
        Paladin.hero:GainLife { percent = 2, show = true }
        TextTag(Paladin.hero:GetPercentLifeOfMax(2), Paladin.hero):Preset("heal")
    end
end

function Paladin.IsJudgementOfLightDebuff()
    return GetUnitAbilityLevel(GetEventDamageSource(), JUDGEMENT_OF_LIGHT_BUFF) > 0
end

function Paladin.CastJudgementOfLight()
    local target = GetSpellTargetUnit()
    BuffSystem.RegisterHero(target)
    --создаем юнита и выдаем ему основную способность
    --и бьем по таргету паладина
    if BuffSystem.IsBuffOnHero(target, JUDGEMENT_OF_LIGHT) then
        BuffSystem.RemoveBuffFromHeroByFunc(target, JUDGEMENT_OF_LIGHT)
    end

    local jol_unit = Unit(GetTriggerPlayer(), DUMMY, Paladin.hero:GetLoc())
    jol_unit:AddAbilities(JUDGEMENT_OF_LIGHT)
    jol_unit:CastToTarget("shadowstrike", target)

    local timer = CreateTimer()
    local remove_buff = function()
        Paladin.RemoveJudgementOfLight(target, timer)
    end

    BuffSystem.AddBuffToHero(target, JUDGEMENT_OF_LIGHT, remove_buff)
    TimerStart(timer, 20., false, remove_buff)
    jol_unit:ApplyTimedLife(2.)
end

function Paladin.IsJudgementOfLight()
    return judgement_of_light_tr:SpellCasted()
end

function Paladin.InitJudgementOfLight()
    judgement_of_light_tr:Init()
    Paladin.hero:SetAbilityManacost(judgement_of_light_tr:GetId(), 5)
    Paladin.hero:SetAbilityCooldown(judgement_of_light_tr:GetId(), 10.)

    local event_ability = EventsPlayer()
    local event_jol = EventsPlayer()

    --персонаж использовал способность
    event_ability:RegisterUnitSpellCast()
    event_ability:AddCondition(Paladin.IsJudgementOfLight)
    event_ability:AddAction(Paladin.CastJudgementOfLight)

    --персонаж бьёт юнита с дебафом
    event_jol:RegisterUnitDamaging()
    event_jol:AddCondition(Paladin.IsJudgementOfLightDebuff)
    event_jol:AddAction(Paladin.JudgementOfLight)
end

-- Copyright (c) meiso

function Paladin.RemoveJudgementOfWisdom(target, timer)
    if BuffSystem.IsBuffOnHero(target, JUDGEMENT_OF_WISDOM) then
        UnitRemoveAbilityBJ(JUDGEMENT_OF_WISDOM_BUFF, target)
        BuffSystem.RemoveBuffFromHero(target, JUDGEMENT_OF_WISDOM)
    end
    DestroyTimer(timer)
end

function Paladin.JudgementOfWisdom()
    if GetRandomReal(0., 1.) <= 0.7 then
        Paladin.hero:GainMana { percent = 2 }
        TextTag(Paladin.hero:GetPercentManaOfMax(2), Paladin.hero):Preset("mana")
    end
end

function Paladin.IsJudgementOfWisdomDebuff()
    return GetUnitAbilityLevel(GetEventDamageSource(), JUDGEMENT_OF_WISDOM_BUFF) > 0
end

function Paladin.CastJudgementOfWisdom()
    local target = GetSpellTargetUnit()
    BuffSystem.RegisterHero(target)
    if BuffSystem.IsBuffOnHero(target, JUDGEMENT_OF_WISDOM) then
        BuffSystem.RemoveBuffFromHeroByFunc(target, JUDGEMENT_OF_WISDOM)
    end

    local jow_unit = Unit(GetTriggerPlayer(), DUMMY, Paladin.hero:GetLoc())
    jow_unit:AddAbilities(JUDGEMENT_OF_WISDOM)
    jow_unit:CastToTarget("shadowstrike", target)

    local timer = CreateTimer()
    local remove_buff = function()
        Paladin.RemoveJudgementOfWisdom(target, timer)
    end

    BuffSystem.AddBuffToHero(target, JUDGEMENT_OF_WISDOM, remove_buff)
    TimerStart(timer, 20., false, remove_buff)
    jow_unit:ApplyTimedLife(2.)
end

function Paladin.IsJudgementOfWisdom()
    return judgement_of_wisdom_tr:SpellCasted()
end

function Paladin.InitJudgementOfWisdom()
    judgement_of_wisdom_tr:Init()
    Paladin.hero:SetAbilityManacost(judgement_of_wisdom_tr:GetId(), 5)
    Paladin.hero:SetAbilityCooldown(judgement_of_wisdom_tr:GetId(), 10.)

    local event_ability = EventsPlayer()
    local event_jow = EventsPlayer()

    --событие того, что персонаж использовал способность
    event_ability:RegisterUnitSpellCast()
    event_ability:AddCondition(Paladin.IsJudgementOfWisdom)
    event_ability:AddAction(Paladin.CastJudgementOfWisdom)

    --событие того, персонаж бьёт юнита с дебафом
    event_jow:RegisterUnitDamaging()
    event_jow:AddCondition(Paladin.IsJudgementOfWisdomDebuff)
    event_jow:AddAction(Paladin.JudgementOfWisdom)
end

-- Copyright (c) meiso

function Paladin.ShieldOfRighteousness()
    -- 42 от силы + 520 ед. урона дополнительно
    local damage = GetHeroStr(GetTriggerUnit(), true) * 1.42 + 520.
    Paladin.hero:DealMagicDamage(GetSpellTargetUnit(), damage)
end

function Paladin.IsShieldOfRighteousness()
    return shield_of_righteousness:SpellCasted()
end

function Paladin.InitShieldOfRighteousness()
    shield_of_righteousness:Init()
    Paladin.hero:SetAbilityManacost(shield_of_righteousness:GetId(), 6)
    Paladin.hero:SetAbilityCooldown(shield_of_righteousness:GetId(), 6.)

    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Paladin.IsShieldOfRighteousness)
    event:AddAction(Paladin.ShieldOfRighteousness)
end

-- Copyright (c) Kodpi, meiso

function Priest.CastCircleOfHealing()
    if not Priest.hero:LoseMana { percent = 21 } then
        return
    end
    local heal = GetRandomInt(958, 1058)

    local function act()
        local u = GetEnumUnit()
        if Priest.hero:IsAlly(u) then
            heal = BuffSystem.ImproveSpell(u, heal)
            Unit(u):GainLife { life = heal, show = true }
        end
    end

    Priest.hero:UseSpellFunc {
        location = Priest.hero:GetLoc(),
        radius = 15,
        func = act
    }
end

function Priest.IsCircleOfHealing()
    return circle_of_healing:SpellCasted()
end

function Priest.InitCircleOfHealing()
    circle_of_healing:Init()
    Priest.hero:SetAbilityManacost(circle_of_healing:GetId(), 21)
    Priest.hero:SetAbilityCooldown(circle_of_healing:GetId(), 6.)

    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Priest.IsCircleOfHealing)
    event:AddAction(Priest.CastCircleOfHealing)
end

-- Copyright (c) Kodpi, meiso

function Priest.CastFlashHeal()
    local cast_time = 1.5
    local target = Unit(GetSpellTargetUnit())

    --TODO: скалировать от стат
    local heal = GetRandomInt(1887, 2193)
    heal = BuffSystem.ImproveSpell(target, heal)

    -- проверяем есть ли мана
    if not Priest.hero:LoseMana{ percent = 18 } then return end

    -- отображаем кастбар
    Frame:CastBar(cast_time, "Быстрое исцеление", Priest.hero)
    TriggerSleepAction(cast_time)
    -- дропаем каст заклинания, если кастбар был сброшен
    if Frame:IsDrop() then return end

    -- даем хп указанному юниту
    target:GainLife { life = heal, show = true}
end

function Priest.IsFlashHeal()
    return flash_heal:SpellCasted()
end

function Priest.InitFlashHeal()
    flash_heal:Init()
    Priest.hero:SetAbilityManacost(flash_heal:GetId(), 18)
    Priest.hero:SetAbilityCooldown(flash_heal:GetId(), 1.5)

    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Priest.IsFlashHeal)
    event:AddAction(Priest.CastFlashHeal)
end

-- Copyright (c) meiso

function Priest.CastGuardianSpirit()
    local unit = Unit(GetSpellTargetUnit())
    local model = "Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl"

    BuffSystem.RegisterHero(unit)

    local timer = CreateTimer()
    local gs_effect = Effect(Priest.hero, model, "origin")
    local event = EventsUnit(unit)
    event:RegisterDamaged()

    local remove_buff = function()
        BuffSystem.RemoveBuffFromHero(unit, guardian_spirit)
        DestroyTimer(timer)
        gs_effect:Destroy()
        event:Destroy()
    end

    local function SaveHero()
        BlzSetEventDamage(0.)
        unit:SetLife(unit:GetPercentLifeOfMax(50.))
    end

    local function GetLife()
        local damage = GetEventDamage()
        local current_hp = unit:GetCurrentLife()
        return current_hp < damage
    end

    BuffSystem.AddBuffToHero(unit, guardian_spirit)
    TimerStart(timer, 10., false, remove_buff)

    event:AddCondition(GetLife)
    event:AddAction(SaveHero)
end

function Priest.IsGuardianSpirit()
    return guardian_spirit:SpellCasted()
end

function Priest.InitGuardianSpirit()
    guardian_spirit:Init()
    Priest.hero:SetAbilityManacost(guardian_spirit:GetId(), 6)
    Priest.hero:SetAbilityCooldown(guardian_spirit:GetId(), 180.)

    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Priest.IsGuardianSpirit)
    event:AddAction(Priest.CastGuardianSpirit)
end

-- Copyright (c) meiso

function Priest.Init(location)
    local loc = location or Location(4200., 200.)
    local items = { "ARMOR_ITEM", "ATTACK_ITEM", "HP_ITEM" }
    local items_spells = { "ARMOR_500", "ATTACK_1500", "HP_90K" }

    Priest.hero = Unit(GetLocalPlayer(), PRIEST, loc, 90.)

    EquipSystem.RegisterItems(items, items_spells)
    --EquipSystem.AddItemsToUnit(Priest.hero, items)

    Priest.hero:SetLevel(80)

    Priest.hero:SetLife(100)
    Priest.hero:SetBaseMana(3863)
    Priest.hero:SetMaxMana(5000, true)

    Priest.hero:AddAbilities(
            FLASH_HEAL,
            RENEW,
            CIRCLE_OF_HEALING,
            PRAYER_OF_MENDING,
            POWER_WORD_SHIELD,
            GUARDIAN_SPIRIT,
            SPELLBOOK_PRIEST
    )
    Priest.hero:AddSpellbook(SPELLBOOK_PRIEST)

    Priest.InitFlashHeal()
    Priest.InitRenew()
    Priest.InitCircleOfHealing()
    Priest.InitPrayerOfMending()
    Priest.InitPowerWordShield()
    Priest.InitGuardianSpirit()
    Priest.InitPrayerOfFortitude()
end

-- Copyright (c) meiso

function Priest.RemovePowerWordShield(unit)
    if BuffSystem.IsBuffOnHero(unit, power_word_shield) then
        BuffSystem.RemoveBuffFromHero(unit, power_word_shield)
    end
end

function Priest.CastPowerWordShield()
    local unit = Unit(GetSpellTargetUnit())
    local event = EventsUnit(unit)
    local absorb = 2230
    local model = "Abilities\\Spells\\Human\\ManaShield\\ManaShieldCaster.mdx"

    BuffSystem.RegisterHero(unit)

    --ничего не делаем, если есть дебаф на повтор
    if BuffSystem.IsBuffOnHero(unit, weakened_soul) then
        return
    end
    --проверяем есть ли щит, если да - сбрасываем и обновляем
    if BuffSystem.IsBuffOnHero(unit, power_word_shield) then
        BuffSystem.RemoveBuffFromHeroByFunc(unit, power_word_shield)
    end

    local timer = CreateTimer()
    local debuff_timer = CreateTimer()
    local pws_effect = Effect(unit, model, "origin")
    event:RegisterDamaged()

    local remove_buff = function()
        Priest.RemovePowerWordShield(unit)
        DestroyTimer(timer)
        event:Destroy()
        pws_effect:Destroy()
    end

    local remove_debuff = function()
        BuffSystem.RemoveBuffFromHero(unit, weakened_soul)
        DestroyTimer(debuff_timer)
    end

    local function Shield()
        local damage = GetEventDamage()
        if damage == 0 then return end
        absorb = absorb - damage
        if 0. <= absorb and absorb < damage then
            BlzSetEventDamage(absorb)
            remove_buff()
        else
            BlzSetEventDamage(0.)
        end
    end

    local function UsingShield()
        return absorb > 0.
    end

    BuffSystem.AddBuffToHero(unit, power_word_shield, remove_buff)
    --фиксируем дебаф на юните
    BuffSystem.AddBuffToHero(unit, weakened_soul, remove_debuff, true)
    TimerStart(timer, 30., false, remove_buff)
    --сбрасываем сам дебаф через 15 сек
    TimerStart(debuff_timer, 15., false, remove_debuff)

    event:AddCondition(UsingShield)
    event:AddAction(Shield)
end

function Priest.IsPowerWordShield()
    return power_word_shield:SpellCasted()
end

function Priest.InitPowerWordShield()
    power_word_shield:Init()
    Priest.hero:SetAbilityManacost(power_word_shield:GetId(), 23)
    Priest.hero:SetAbilityCooldown(power_word_shield:GetId(), 4.)

    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Priest.IsPowerWordShield)
    event:AddAction(Priest.CastPowerWordShield)
end

-- Copyright (c) meiso

function Priest.SetPrayerOfFortitude()
    --TODO: пока что даём как есть. потом отскалируем
    local items = { "PRAYER_OF_FORTITUDE_ITEM" }
    local items_spells = { "HP_165_POF" }

    EquipSystem.RegisterItems(items, items_spells)

    local function act()
        local u = Unit(GetEnumUnit())
        EquipSystem.RemoveItemsToUnit(u, items)
        if u:HasBuff(PRAYER_OF_FORTITUDE_BUFF) then
            EquipSystem.AddItemsToUnit(u, items)
        end
    end

    Priest.hero:UseSpellFunc {
        location = Priest.hero:GetLoc(),
        --а здесь наоборот должна быть больше
        radius = 30,
        func = act
    }
end

function Priest.InitPrayerOfFortitude()
    --эта кастомная аура по сути перманентна
    prayer_of_fortitude:Init()

    local set_buff = EventsUnit(Priest.hero)
    --здесь дистанция прока ауры должна быть меньше чем задана в редакторе,
    --иначе ивент не будет цеплять юнитов на краю зоны ауры
    set_buff:RegisterWithinRange(19.)
    set_buff:AddAction(Priest.SetPrayerOfFortitude)
end

-- Copyright (c) meiso

function Priest.RemovePrayerOfMending(unit, timer)
    if BuffSystem.IsBuffOnHero(unit, prayer_of_mending) then
        BuffSystem.RemoveBuffFromHero(unit, prayer_of_mending)
    end
    DestroyTimer(timer)
end

function Priest.CastPrayerOfMending()
    local unit = GetSpellTargetUnit()
    local last_unit
    local event
    local cured = false
    local POM_JUMP_COUNT = 5

    --при повторном наложении сбрасываем со всех
    if BuffSystem.IsBuffOnHero(unit, prayer_of_mending) then
        BuffSystem.RemoveBuffFromUnits(prayer_of_mending)
        POM_JUMP_COUNT = 5
    end

    while POM_JUMP_COUNT > -1 do
        TriggerSleepAction(0.)
        if unit ~= last_unit then
            POM_JUMP_COUNT = POM_JUMP_COUNT - 1
            last_unit = unit

            if event then event:Destroy() end
            BuffSystem.RegisterHero(unit)
            event = EventsUnit(unit)
            event:RegisterDamaged()

            local timer = CreateTimer()
            local remove_buff = function()
                Priest.RemovePrayerOfMending(unit, timer)
            end

            BuffSystem.AddBuffToHero(unit, prayer_of_mending, remove_buff)
            --баф снимется сам через 30 сек
            TimerStart(timer, 30., remove_buff)

            event:AddCondition(function()
                return BuffSystem.IsBuffOnHero(unit, prayer_of_mending)
            end)
            event:AddAction(function()
                local heal = 1043
                heal = BuffSystem.ImproveSpell(unit, heal)
                Unit(unit):GainLife { life = heal, show = true }
                cured = true
                Priest.RemovePrayerOfMending(unit, timer)
            end)
        end
        if cured and last_unit == unit then
            cured = false
            if event then event:Destroy() end
            local group = GroupUnitsInRangeOfLocUnit(400, Unit(last_unit):GetLoc())
            for _ = 1, CountUnitsInGroup(group) do
                TriggerSleepAction(0.)
                local temp = GroupPickRandomUnit(group)
                if IsUnitAlly(temp, GetOwningPlayer(GetTriggerUnit())) and
                        temp ~= last_unit then
                    unit = temp
                end
                GroupRemoveUnit(group, temp)
            end
            BuffSystem.RemoveBuffFromHero(last_unit, prayer_of_mending)
            DestroyGroup(group)
        end
    end
    unit = nil
    last_unit = nil
end

function Priest.IsPrayerOfMending()
    return prayer_of_mending:SpellCasted()
end

function Priest.InitPrayerOfMending()
    prayer_of_mending:Init()
    Priest.hero:SetAbilityManacost(prayer_of_mending:GetId(), 15)
    Priest.hero:SetAbilityCooldown(prayer_of_mending:GetId(), 10.)

    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Priest.IsPrayerOfMending)
    event:AddAction(Priest.CastPrayerOfMending)
end

-- Copyright (c) Kodpi, meiso

function Priest.CastRenew()
    --Прибавка каждые 3 секунды в течение 15 сек
    local heal = 280
    local unit = Unit(GetSpellTargetUnit())

    if not Priest.hero:LoseMana { percent = 17 } then
        return
    end
    for _ = 1, 5 do
        heal = BuffSystem.ImproveSpell(unit, heal)
        unit:GainLife { life = heal, show = true }
        TriggerSleepAction(3.)
    end
end

function Priest.IsRenew()
    return renew:SpellCasted()
end

function Priest.InitRenew()
    renew:Init()
    Priest.hero:SetAbilityManacost(renew:GetId(), 17)
    Priest.hero:SetAbilityCooldown(renew:GetId(), 1.5)

    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Priest.IsRenew)
    event:AddAction(Priest.CastRenew)
end

-- Copyright (c) meiso

function DeathKnight.Init(location)
    local loc = location or Location(4000., 150.)
    local items_list = {"ARMOR_ITEM", "ATTACK_ITEM", "HP_ITEM"}
    local items_spells_list = {"ARMOR_500", "ATTACK_1500", "HP_90K"}

    DeathKnight.hero = Unit(GetLocalPlayer(), DEATH_KNIGHT, loc)

    --EquipSystem.RegisterItems(items_list, items_spells_list)
    --EquipSystem.AddItemsToUnit(DeathKnight.hero, items_list)

    DeathKnight.hero:SetLevel(80)

    DeathKnight.Runes()
end

-- Copyright (c) meiso

function DeathKnight.Runes()
    local runes = Frame("Runes")
    runes:SetAbsPoint(FRAMEPOINT_CENTER, 0.4, 0.155)
end


-- Точка входа для инициализации всего
function EntryPoint()
    -- Загрузка шаблонов фреймов
    loadTOCFile("templates.toc")

    -- Механики
    BattleSystem.Init()

    -- Боссы
    LordMarrowgar.Init()
    LadyDeathwhisper.Init()

    -- Персонажи
    Priest.Init()
    Paladin.Init()

    -- Манекены
    --DummyForHealing()
end


-- Точка входа для инициализации всего
function TestEntryPoint()
    -- Загрузка шаблонов фреймов
    loadTOCFile("templates.toc")
    --HeroSelector.Init()
    BuffSystem.LoadFrame()

    -- Механики
    BattleSystem.Init()

    --SaveSystem.InitNewHeroEvent()
    SaveSystem.gamecache = InitGameCache("savesystem")
    SaveSystem.map_number = 1
    SaveSystem.InitSaveEvent()
    SaveSystem.InitLoadEvent()

    -- Персонажи
    Priest.Init(Location(300., -490.))
    Paladin.Init(Location(-400., -490.))
    --DeathKnight.Init(Location(-400., -520.))

    -- Манекены
    --DummyForHealing(Location(300., 200.))
    DummyForDPS(Location(-400., 200.))

end

--CUSTOM_CODE
function Trig_EntryPoint_Actions()
        TestEntryPoint()
end

function InitTrig_EntryPoint()
    gg_trg_EntryPoint = CreateTrigger()
    TriggerAddAction(gg_trg_EntryPoint, Trig_EntryPoint_Actions)
end

function Trig_RespawnHero_Actions()
        SaveSystem.UnitsRespawn()
        BuffSystem.RemoveAllBuffs(GetTriggerUnit())
end

function InitTrig_RespawnHero()
    gg_trg_RespawnHero = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_RespawnHero, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddAction(gg_trg_RespawnHero, Trig_RespawnHero_Actions)
end

function InitCustomTriggers()
    InitTrig_EntryPoint()
    InitTrig_RespawnHero()
end

function RunInitializationTriggers()
    ConditionalTriggerExecute(gg_trg_EntryPoint)
end

function InitCustomPlayerSlots()
    SetPlayerStartLocation(Player(0), 0)
    SetPlayerColor(Player(0), ConvertPlayerColor(0))
    SetPlayerRacePreference(Player(0), RACE_PREF_HUMAN)
    SetPlayerRaceSelectable(Player(0), true)
    SetPlayerController(Player(0), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(1), 1)
    SetPlayerColor(Player(1), ConvertPlayerColor(1))
    SetPlayerRacePreference(Player(1), RACE_PREF_ORC)
    SetPlayerRaceSelectable(Player(1), true)
    SetPlayerController(Player(1), MAP_CONTROL_USER)
end

function InitCustomTeams()
    SetPlayerTeam(Player(0), 0)
    SetPlayerTeam(Player(1), 0)
end

function InitAllyPriorities()
    SetStartLocPrioCount(0, 1)
    SetStartLocPrio(0, 0, 1, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(1, 1)
    SetStartLocPrio(1, 0, 0, MAP_LOC_PRIO_HIGH)
end

function main()
    SetCameraBounds(-1280.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), -1536.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM), 1280.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), 1024.0 - GetCameraMargin(CAMERA_MARGIN_TOP), -1280.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), 1024.0 - GetCameraMargin(CAMERA_MARGIN_TOP), 1280.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), -1536.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM))
    SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl", "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
    NewSoundEnvironment("Default")
    SetAmbientDaySound("LordaeronSummerDay")
    SetAmbientNightSound("LordaeronSummerNight")
    SetMapMusic("Music", true, 0)
    InitBlizzard()
    InitGlobals()
    InitCustomTriggers()
    RunInitializationTriggers()
end

function config()
    SetMapName("TRIGSTR_215")
    SetMapDescription("TRIGSTR_217")
    SetPlayers(2)
    SetTeams(2)
    SetGamePlacement(MAP_PLACEMENT_TEAMS_TOGETHER)
    DefineStartLocation(0, 0.0, -1152.0)
    DefineStartLocation(1, 0.0, -1152.0)
    InitCustomPlayerSlots()
    SetPlayerSlotAvailable(Player(0), MAP_CONTROL_USER)
    SetPlayerSlotAvailable(Player(1), MAP_CONTROL_USER)
    InitGenericPlayerSlots()
    InitAllyPriorities()
end

