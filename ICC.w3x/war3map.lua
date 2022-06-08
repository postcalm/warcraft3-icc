udg_My_hero = {}
udg_My_y = __jarray(0.0)
udg_My_index = 0
udg_My_x = __jarray(0.0)
udg_My_type = __jarray(0)
udg_SaveUnit_ability = __jarray(0)
udg_SaveUnit_y = 0.0
udg_SaveUnit_g1 = 0
udg_SaveUnit_g2 = 0
udg_SaveUnit_gamecache = nil
udg_SaveUnit_map_number = 0
udg_SaveUnit_hero_ability = __jarray(0)
udg_SaveUnit_unit = nil
udg_SaveUnit_user_data = __jarray(0)
udg_SaveUnit_x = 0.0
udg_SaveUnit_bool = false
udg_SaveUnit_author = 0
udg_SaveUnit_data = __jarray(0)
udg_SaveUnit_directory = ""
udg_cache = nil
gg_rct_RespawZone = nil
gg_rct_areaLD = nil
gg_rct_areaLM = nil
gg_trg_Battle = nil
gg_trg_Init_LordMarrowgar = nil
gg_trg_Init_LadyDeathwhisper = nil
gg_trg_Init_Priest = nil
gg_trg_Init_Paladin = nil
gg_trg_INIT = nil
gg_trg_UNIT_DEATH = nil
gg_trg_Cmd_new = nil
gg_trg_Init = nil
gg_trg_Save_unit_hero_ability = nil
gg_trg_SaveUnit_load = nil
gg_trg_SaveUnit_save = nil
function InitGlobals()
    local i = 0
    i = 0
    while (true) do
        if ((i > 1)) then break end
        udg_My_y[i] = 0.0
        i = i + 1
    end
    udg_My_index = 0
    i = 0
    while (true) do
        if ((i > 1)) then break end
        udg_My_x[i] = 0.0
        i = i + 1
    end
    i = 0
    while (true) do
        if ((i > 1)) then break end
        udg_My_type[i] = 0
        i = i + 1
    end
    udg_SaveUnit_y = 0.0
    udg_SaveUnit_g1 = 0
    udg_SaveUnit_g2 = 0
    udg_SaveUnit_map_number = 0
    i = 0
    while (true) do
        if ((i > 1)) then break end
        udg_SaveUnit_user_data[i] = 0
        i = i + 1
    end
    udg_SaveUnit_x = 0.0
    udg_SaveUnit_bool = false
    udg_SaveUnit_author = 0
    i = 0
    while (true) do
        if ((i > 1)) then break end
        udg_SaveUnit_data[i] = 0
        i = i + 1
    end
    udg_SaveUnit_directory = ""
end

function CreateUnitsForPlayer0()
    local p = Player(0)
    local u
    local unitID
    local t
    local life
    u = CreateUnit(p, FourCC("Hpal"), 4454.3, 139.3, 110.510)
    u = CreateUnit(p, FourCC("Hpal"), 4291.2, -2880.6, 52.820)
    SetHeroLevel(u, 80, false)
    u = CreateUnit(p, FourCC("Hpal"), 4096.3, -8835.7, 171.755)
    u = CreateUnit(p, FourCC("Hpal"), 4062.6, -5020.2, 109.900)
end

function CreateUnitsForPlayer10()
    local p = Player(10)
    local u
    local unitID
    local t
    local life
    u = CreateUnit(p, FourCC("ugho"), 3156.8, 32.8, 49.649)
    u = CreateUnit(p, FourCC("ugho"), 3273.6, -75.0, 73.424)
    u = CreateUnit(p, FourCC("ugho"), 3427.4, -101.2, 268.250)
    u = CreateUnit(p, FourCC("ugho"), 3227.7, -3737.3, 12.610)
    u = CreateUnit(p, FourCC("ugho"), 3214.7, -3584.5, 263.720)
    u = CreateUnit(p, FourCC("ugho"), 3371.0, -3728.6, 246.840)
end

function CreatePlayerBuildings()
end

function CreatePlayerUnits()
    CreateUnitsForPlayer0()
    CreateUnitsForPlayer10()
end

function CreateAllUnits()
    CreatePlayerBuildings()
    CreatePlayerUnits()
end

function CreateRegions()
    local we
    gg_rct_RespawZone = Rect(3936.0, -3616.0, 4256.0, -3168.0)
    gg_rct_areaLD = Rect(2944.0, -128.0, 5248.0, 1984.0)
    gg_rct_areaLM = Rect(3040.0, -2688.0, 5184.0, -1056.0)
end

--CUSTOM_CODE

--Paladin
JUDGEMENT_OF_LIGHT_BUFF = FourCC('B002')
JUDGEMENT_OF_WISDOM_BUFF = FourCC('B003')



Items = {}
Items["ARMOR_ITEM"]              = FourCC('I001')
Items["ATTACK_ITEM"]             = FourCC('I000')
Items["HP_ITEM"]                 = FourCC('I002')
Items["MAGICARMOR_ITEM"]         = FourCC('I003')
Items["DEC_DMG_ITEM"]            = FourCC('I004')
Items["BLESSING_OF_WISDOM_ITEM"] = FourCC('I005')
Items["MP_ITEM"]                 = FourCC('I006')

ItemsSpells = {}
ItemsSpells["ARMOR_500"]          = { int = FourCC('A008'), str = 'A008' }
ItemsSpells["ATTACK_1500"]        = { int = FourCC('A007'), str = 'A007' }
ItemsSpells["HP_90K"]             = { int = FourCC('A00D'), str = 'A00D' }
ItemsSpells["MAGICARMOR_500"]     = { int = FourCC('A00I'), str = 'A00I' }
ItemsSpells["DECREASE_DMG"]       = { int = FourCC('A00K'), str = 'A00K' }
ItemsSpells["BLESSING_OF_WISDOM"] = { int = FourCC('A00F'), str = 'A00F' }
ItemsSpells["MP_50K"]             = { int = FourCC('A00W'), str = 'A00W' }


--Lord Marrowgar
BONE_SPIKE_OBJ = FourCC('h000')

--Common
DUMMY       = FourCC('h002')
SPELL_DUMMY = FourCC('h001')
DUMMY_EQUIP = FourCC('e000')


PLAYER_1   = Player(0)
PLAYER_2   = Player(1)
LICH_KING = Player(10)

COMMON_TIMER = FourCC('BTLF')
METER = 20
ARROW_MODEL = "Abilities\\Spells\\Other\\Aneu\\AneuCaster.mdl"


Paladin          = {hero = nil}
Priest           = {hero = nil}

LordMarrowgar    = {unit = nil,
                    coldflame = nil,
                    coldflame_effect = false,
                    bonespike_effect = false,
                    whirlwind_effect = false,
}
LadyDeathwhisper = {unit = nil,
                    mana_shield = false,
                    mana_is_over = false,
                    dominate_mind_effect = false,
                    death_and_decay_effect = false,
                    phase = 1,
}

CultAdherent     = {unit = nil,
                    summoned = false,
                    morphed = false,
}
CultFanatic      = {unit = nil,
                    summoned = false,
                    morphed = false,
}


--Lord Marrowgar
COLDFLAME               = FourCC("A001")
WHIRLWIND               = FourCC("A005")

--Paladin
DIVINE_SHIELD           = FourCC("AHds")
CONSECRATION            = FourCC("A009")
CONSECRATION_TR         = FourCC("A00A")
HAMMER_RIGHTEOUS        = FourCC("A00B")
BLESSING_OF_KINGS       = FourCC("A00C")
BLESSING_OF_SANCTUARY   = FourCC("A00H")
BLESSING_OF_WISDOM      = FourCC("A00G")
BLESSING_OF_MIGHT       = FourCC("A00M")
CRUSADER_AURA           = FourCC("A00J")
DEVOTION_AURA           = FourCC("AHhb")
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

-- Copyright (c) 2022 meiso

--- Аналог python функции zip().
--- Объединяет в таблицы элементы из последовательностей переданных в качестве аргументов
function zip(...)
    local args = table.pack(...)
    local array = {}
    local len = #args[1]

    --опеределяем самую маленькую последовательность
    for i = 1, args.n do
        if #args[i] < len then len = #args[i] end
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

function meters()
    
end

--- Округляет число
---@param number number
---@return number
function round(number)
    return number >= 0 and math.floor(number + 0.5) or math.ceil(number - 0.5)
end

function convertLength(len)
    return round(round(len) / 100)
end


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
DEATH_KNIGHT        = nil
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

--- Created by meiso.

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

--- Базовый класс событий
function Events:_init()
    self.trigger = CreateTrigger()
end

--- Добавляет условие для события
---@param func function Функция, возвращающая bool или boolexpr
function Events:AddCondition(func)
    TriggerAddCondition(self.trigger, Condition(func))
end

--- Добавляет действие для события
---@param func function Функция, запускающаяся после срабатывания события
function Events:AddAction(func)
    TriggerAddAction(self.trigger, func)
end

--- Отключает триггер
function Events:DisableTrigger()
    DisableTrigger(self.trigger)
end

--- Включает триггер
function Events:EnableTrigger()
    EnableTrigger(self.trigger)
end

--- Уничтожает триггер
function Events:Destroy()
    DestroyTrigger(self.trigger)
end

--- Created by meiso.

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

function EventsPlayer:_init(player)
    Events._init(self)
    self.player = player or 0
end

function EventsPlayer:RegisterUnitAttacked()
    TriggerRegisterPlayerUnitEvent(self.trigger, self.player, EVENT_PLAYER_UNIT_ATTACKED, nil)
end

--- Регистриует событие каста способности юнитом игрока
function EventsPlayer:RegisterUnitSpellCast()
    TriggerRegisterPlayerUnitEvent(self.trigger, self.player, EVENT_PLAYER_UNIT_SPELL_CAST, nil)
end

--- Регистриует событие нанесения урона юнитом игрока
function EventsPlayer:RegisterUnitDamaging()
    TriggerRegisterPlayerUnitEvent(self.trigger, self.player, EVENT_PLAYER_UNIT_DAMAGING, nil)
end

--- Регистриует событие получения урона юнитом игрока
function EventsPlayer:RegisterUnitDamaged()
    TriggerRegisterPlayerUnitEvent(self.trigger, self.player, EVENT_PLAYER_UNIT_DAMAGED, nil)
end

--- Регистриует событие смерти юнита игрока
function EventsPlayer:RegisterUnitDeath()
    TriggerRegisterPlayerUnitEvent(self.trigger, self.player, EVENT_PLAYER_UNIT_DEATH, nil)
end

--- Регистриует собыие призыва юнита игрока
function EventsPlayer:RegisterUnitSummon()
    TriggerRegisterPlayerUnitEvent(self.trigger, self.player, EVENT_PLAYER_UNIT_SUMMON, nil)
end

-- далее идут бессмысленные обёртки над методами родителя
-- и нужны только для того, чтобы методы показывались в IDE

--- Добавляет условие для события
---@param func function Функция, возвращающая bool или boolexpr
function EventsPlayer:AddCondition(func)
    Events.AddCondition(self, func)
end

--- Добавляет действие для события
---@param func function Функция, запускающаяся после срабатывания события
function EventsPlayer:AddAction(func)
    Events.AddAction(self, func)
end

--- Отключает триггер
function EventsPlayer:DisableTrigger()
    Events.DisableTrigger(self)
end

--- Включает триггер
function EventsPlayer:EnableTrigger()
    Events.EnableTrigger(self)
end

--- Уничтожает триггер
function EventsPlayer:Destroy()
    Events.Destroy(self)
end


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

function EventsUnit:_init(unit)
    Events._init(self)
    self.unit = unit
    if type(unit) == "table" then self.unit = unit:GetId() end
end

--- Регистриует событие получения урона юнитом
function EventsUnit:RegisterDamaged()
    TriggerRegisterUnitEvent(self.trigger, self.unit, EVENT_UNIT_DAMAGED)
end

--- Регистриует событие нанесения урона юнитом
function EventsUnit:RegisterDamaging()
    TriggerRegisterUnitEvent(self.trigger, self.unit, EVENT_UNIT_DAMAGING)
end

--- Регистриует событие, когда юнита атакуют или он атакует
function EventsUnit:RegisterAttacked()
    TriggerRegisterUnitEvent(self.trigger, self.unit, EVENT_UNIT_ATTACKED)
end

-- далее идут бессмысленные обёртки над методами родителя
-- и нужны только для того, чтобы методы показывались в IDE

--- Добавляет условие для события
---@param func function Функция, возвращающая bool или boolexpr
function EventsUnit:AddCondition(func)
    Events.AddCondition(self, func)
end

--- Добавляет действие для события
---@param func function Функция, запускающаяся после срабатывания события
function EventsUnit:AddAction(func)
    Events.AddAction(self, func)
end

--- Отключает триггер
function EventsUnit:DisableTrigger()
    Events.DisableTrigger(self)
end

--- Включает триггер
function EventsUnit:EnableTrigger()
    Events.EnableTrigger(self)
end

--- Уничтожает триггер
function EventsUnit:Destroy()
    Events.Destroy(self)
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
        if slope == 0 then y = 0
        else y = ydiff * (i / quantity) end

        if slope == 0 then x = xdiff * (i / quantity)
        else x = y / slope end

        points = Point(round(x) + self.point1.X,
                       round(y) + self.point1.Y)
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


--- Created by meiso.

Point = {}
Point.__index = Point

setmetatable(Point, {
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
    end,
})

function Point:_init(X, Y, Z)
    self.X = X or 0
    self.Y = Y or 0
    self.Z = Z or 0
end

function Point:get2DPoint()
    return { self.X, self.Y }
end

function Point:get3DPoint()
    return { self.X, self.Y, self.Z }
end

function Point:atPoint(point)
    local inaccuracy = 30.
    if math.abs(self.X - point.X) <= inaccuracy and
            math.abs(self.Y - point.Y) <= inaccuracy then
        return true
    end
    return false
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

---@param player player
---@param unit_id unit
---@param location location
---@param face real
function Unit:_init(player, unit_id, location, face)
    local x = GetLocationX(location)
    local y = GetLocationY(location)
    local f = face or 0
    self.unit = CreateUnit(player, unit_id, x, y, f)
end

-- Damage

--- Выставить базовый урон
---@param value integer Урон
---@param index integer Номер атаки. 0 (первая) или 1 (вторая)
function Unit:SetBaseDamage(value, index)
    local i = index or 0
    BlzSetUnitBaseDamage(self.unit, value, i)
end

--- Нанести физический урон.
--- Урон снижает как от количества, так и от типа защиты
---@param target unit
---@param damage real
---@param attack_type attacktype
function Unit:DealPhysicalDamage(target, damage, attack_type)
    local t = attack_type or ATTACK_TYPE_MELEE
    local u = target
    if type(target) == "table" then u = target:GetId() end
    UnitDamageTargetBJ(self.unit, u, damage, t, DAMAGE_TYPE_NORMAL)
end

--- Нанести физический урон, проходящий через защиту.
--- Урон снижается только от типа защиты
---@param target unit
---@param damage real
---@param attack_type attacktype
function Unit:DealUniversalDamage(target, damage, attack_type)
    local t = attack_type or ATTACK_TYPE_MELEE
    local u = target
    if type(target) == "table" then u = target:GetId() end
    UnitDamageTargetBJ(self.unit, u, damage, t, DAMAGE_TYPE_UNIVERSAL)
end

--- Нанести магической урон.
--- Урон снижается "сопротивлением от магии"
---@param target unit
---@param damage real
function Unit:DealMagicDamage(target, damage)
    local u = target
    if type(target) == "table" then u = target:GetId() end
    UnitDamageTargetBJ(self.unit, u, damage, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC)
end

--- Нанести магической урон по площади.
--- Урон снижается "сопротивлением от магии"
---@param damage real
---@param location location
---@param radius real Радиус в метрах
function Unit:DealMagicDamageLoc(damage, location, radius)
    local meters = METER * radius
    UnitDamagePointLoc(self.unit, 0, meters, location, damage, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC)
end

--- Нанести магический урон, проходящий через иммунитет к магии.
--- Урон игнорирует иммунитет к магии, но снижается "сопротивляемостью к магии"
---@param target unit
---@param damage real
function Unit:DealUniversalMagicDamage(target, damage)
    local u = target
    if type(target) == "table" then u = target:GetId() end
    UnitDamageTargetBJ(self.unit, u, damage, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL)
end

--- Нанести смешанный урон.
--- Урон снижается и от защиты, и от сопротивления к магии
---@param target unit
---@param damage real
function Unit:DealMixedDamage(target, damage)
    local u = target
    if type(target) == "table" then u = target:GetId() end
    UnitDamageTargetBJ(self.unit, u, damage, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL)
end

--- Нанести чистый урон.
--- Не снижается защитой
---@param target unit
---@param damage real
function Unit:DealCleanDamage(target, damage)
    local u = target
    if type(target) == "table" then u = target:GetId() end
    UnitDamageTargetBJ(self.unit, u, damage, ATTACK_TYPE_CHAOS, DAMAGE_TYPE_UNIVERSAL)
end

-- Ability

--- Выдать юниту указанные способности
---@param ability ability
function Unit:AddAbilities(...)
    local abilities = table.pack(...)
    for _, ability in ipairs(abilities) do
        UnitAddAbility(self.unit, ability)
    end
end

--- Выдать книгу заклинаний
---@param spellbook spellbook
function Unit:AddSpellbook(spellbook)
    local p = GetOwningPlayer(self.unit)
    UnitAddAbility(self.unit, spellbook)
    UnitMakeAbilityPermanent(self.unit, true, spellbook)
    SetPlayerAbilityAvailable(p, spellbook, true)
end

--- Применить способность
---@param ability string
function Unit:UseAbility(ability)
    IssueImmediateOrder(self.unit, ability)
end

--- Использовать заклинание по цели
---@param spell string Id приказа
---@param target unitid
function Unit:CastToTarget(spell, target)
    local u = target
    if type(target) == "table" then u = target:GetId() end
    IssueTargetOrder(self.unit, spell, u)
end

-- Mana

--- Потратить указанное количество маны
---@param mana real Количество маны в абсолютных единицах
---@param percent real Количество маны в процентах
---@param check boolean Проверять ли текущее количество маны
---@return boolean
function Unit:LoseMana(arg)
    local m = self:GetPercentManaOfMax(arg.percent) or arg.mana
    if arg.check == nil then arg.check = true end
    if m > self:GetCurrentMana() and arg.check then
        --TODO: печатать конкретному игроку
        print("Недостаточно маны")
        return false
    end
    self:SetMana(self:GetCurrentMana() - m)
    return true
end

--- Получить ману количественно или в процентах от максимума
---@param mana real Количество маны в абсолютных единицах
---@param percent real Количество маны в процентах
function Unit:GainMana(arg)
    local m = self:GetPercentManaOfMax(arg.percent) or arg.mana
    self:SetMana(self:GetCurrentMana() + m)
end

--- Получить процент маны от максимума
---@param percent real Количество маны в процентах
---@return real
function Unit:GetPercentManaOfMax(percent)
    if percent == nil then return nil end
    local factor = 100
    if percent <= 1 then factor = 1 end
    return GetUnitState(self.unit, UNIT_STATE_MAX_MANA) * (percent / factor)
end

--- Установить текущее количество маны
---@param value real
function Unit:SetMana(value)
    SetUnitState(self.unit, UNIT_STATE_MANA, value)
end

--- Установить максимальное значение маны
---@param value real
---@param full boolean
function Unit:SetMaxMana(value, full)
    --SetUnitState(self.unit, UNIT_STATE_MAX_MANA, value)
    local f = full or false
    BlzSetUnitMaxMana(self.unit, value)
    if f then self:SetMana(self:GetMaxLife()) end
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

-- Health

--- Потратить указанное количество хп
---@param life real Количество хп в абсолютных единицах
---@param percent real Количество хп в процентах
function Unit:LoseLife(arg)
    local l = self:GetPercentLifeOfMax(arg.percent) or arg.life
    self:SetLife(self:GetCurrentLife() - l)
end

--- Получить хп количественно или в процентах от максимума
---@param life real Количество хп в абсолютных единицах
---@param percent real Количество хп в процентах
function Unit:GainLife(arg)
    local l = self:GetPercentLifeOfMax(arg.percent) or arg.life
    self:SetLife(self:GetCurrentLife() + l)
end

--- Получить процент хп от максимума
---@param percent real Количество хп в процентах
---@return real
function Unit:GetPercentLifeOfMax(percent)
    if percent == nil then return nil end
    local factor = 100
    if percent <= 1 then factor = 1 end
    return GetUnitState(self.unit, UNIT_STATE_MAX_LIFE) * (percent / factor)
end

--- Установить текущее количество хп
---@param value real
function Unit:SetLife(value)
    SetUnitState(self.unit, UNIT_STATE_LIFE, value)
end

--- Установить максимальное значение хп
---@param value real
---@param full boolean
function Unit:SetMaxLife(value, full)
    --SetUnitState(self.unit, UNIT_STATE_MAX_LIFE, value)
    local f = full or false
    BlzSetUnitMaxHP(self.unit, value)
    if f then self:SetLife(self:GetMaxLife()) end
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

--

--- Вернуть ближайших врагов
---@param radius real Радиус в метрах, в котором выбираются враги. Необязательный аргумент
---@param filter function
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

--- Получить идентификатор созданного юнита
---@return unitid
function Unit:GetId()
    return self.unit
end

--- Получить игрока, владеющего юнитом
function Unit:GetOwner()
    return GetOwningPlayer(self.unit)
end

--- Установить уровень юнита
function Unit:SetLevel(lvl)
    SetHeroLevel(self.unit, lvl, false)
end

--- Установить скорость передвижения юнита
---@param movespeed real
function Unit:SetMoveSpeed(movespeed)
    SetUnitMoveSpeed(self.unit, movespeed)
end

--- Получить скорость передвижения юнита
function Unit:GetMoveSpeed()
    return GetUnitMoveSpeed(self.unit)
end

--- Проверяет является ли юнит союзником
---@param unit Unit Юнит от класса Unit
---@return boolean
function Unit:IsAlly(unit)
    return IsPlayerAlly(self:GetOwner(), unit:GetOwner())
end

--- Проверяет является ли юнит противником
---@param unit Unit Юнит от класса Unit
---@return boolean
function Unit:IsEnemy(unit)
    return IsPlayerEnemy(self:GetOwner(), unit:GetOwner())
end

function Unit:ApplyTimedLife(time)
    UnitApplyTimedLife(self.unit, COMMON_TIMER, time)
end

--- Удалить юнита
function Unit:Remove()
    RemoveUnit(self.unit)
end


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

function UnitSpell:_init(owner, location)
    local loc = location or GetUnitLoc(owner)
    local face = GetUnitFacing(owner)
    self.unit = Unit(GetOwningPlayer(owner), SPELL_DUMMY, loc, face):GetId()
    SetUnitMoveSpeed(self.unit, 512.)
end

function UnitSpell:MoveToUnit(unit)
    local loc
    if type(unit) == "table" then loc = unit:GetLoc()
    else loc = GetUnitLoc(unit) end
    IssuePointOrderLoc(self.unit, "move", loc)
end

function UnitSpell:NearTarget(target)
    local loc
    if type(target) == "table" then loc = target:GetLoc()
    else loc = GetUnitLoc(target) end
    local target_point = Point(GetLocationX(loc), GetLocationY(loc))
    local unit_loc = self:GetLoc()
    local unit_point = Point(GetLocationX(unit_loc), GetLocationY(unit_loc))
    return target_point:atPoint(unit_point)
end

---@author Vlod | WWW.XGM.RU
---@author meiso | WWW.XGM.RU

--- Область, за которой следует номер карты
SCOPE_MAP        = 2
--- Область, за которой следуют данные о ресурсах игрока
SCOPE_RESOURCES  = 3
--- Область, за которой следуют данные о юните (положение, хп, мана)
SCOPE_HERO_DATA  = 4
--- Область, за которой следуют данные о количестве skill points
SCOPE_HERO_SKILL = 5
--- Область, за которой следуют данные о характеристиках
SCOPE_STATE      = 6
--- Область, за которой следуют данные о способностях героя
SCOPE_ABILITIES  = 7
--- Область, за которой следуют данные об имеющихся предметах
SCOPE_ITEMS      = 8

-- Числа, расшифровать смысл которых, так и не получилось
MAGIC_NUMBER_ONE   = 18259200
MAGIC_NUMBER_TWO   = 44711
MAGIC_NUMBER_THREE = 259183
MAGIC_NUMBER_FOUR  = 129593
MAGIC_NUMBER_FIVE  = 259200
MAGIC_NUMBER_SIX   = 54773
MAGIC_NUMBER_SEVEN = 7141
MAGIC_NUMBER_EIGHT = 421
MAGIC_NUMBER_NINE  = 259199

--- Возрождает юнита
function UnitsRespawn()
    local u = GetTriggerUnit()
    if IsUnitType(u, UNIT_TYPE_HERO) == true then
        TriggerSleepAction(5)
        ReviveHero(u, udg_SaveUnit_x, udg_SaveUnit_y, false)
    end
end

--- Сохраняет способности героя
function SaveHeroAbilities()
    udg_SaveUnit_hero_ability[1] = DEVOTION_AURA
    udg_SaveUnit_hero_ability[2] = DIVINE_SHIELD
    udg_SaveUnit_hero_ability[3] = CONSECRATION
    udg_SaveUnit_hero_ability[4] = CONSECRATION_TR
    udg_SaveUnit_hero_ability[5] = HAMMER_RIGHTEOUS
    udg_SaveUnit_hero_ability[6] = JUDGEMENT_OF_LIGHT_TR
    udg_SaveUnit_hero_ability[7] = JUDGEMENT_OF_WISDOM_TR
    udg_SaveUnit_hero_ability[8] = SHIELD_OF_RIGHTEOUSNESS
    udg_SaveUnit_hero_ability[9] = SPELLBOOK_PALADIN
end

--- Выдает герою способности
function AddHeroAbilities()
    SaveHeroAbilities()
    local hero_s = udg_My_hero[GetConvertedPlayerId(GetTriggerPlayer())]
    for i = 1, 9 do
        UnitAddAbility(hero_s, udg_SaveUnit_hero_ability[i])
    end
    UnitAddAbility(hero_s, SPELLBOOK_PALADIN)
    UnitMakeAbilityPermanent(hero_s, true, SPELLBOOK_PALADIN)
    SetPlayerAbilityAvailable(GetTriggerPlayer(), SPELLBOOK_PALADIN, true)
    SetHeroLevel(hero_s, 80, false)
end

---
function generation1()
    udg_SaveUnit_g1 = udg_SaveUnit_g1 * MAGIC_NUMBER_SEVEN + MAGIC_NUMBER_SIX
    udg_SaveUnit_g1 = math.fmod(udg_SaveUnit_g1, MAGIC_NUMBER_FIVE)
    return udg_SaveUnit_g1
end

---
function generation2()
    udg_SaveUnit_g2 = udg_SaveUnit_g2 * MAGIC_NUMBER_EIGHT + MAGIC_NUMBER_SIX
    udg_SaveUnit_g2 = math.fmod(udg_SaveUnit_g2, MAGIC_NUMBER_FIVE)
    return udg_SaveUnit_g2
end

--- Получает ключ игрока
---@return int Ключ игрока
function GetUserKey()
    if udg_SaveUnit_author > 0 then
        Preloader("save\\"..udg_SaveUnit_directory.."\\".."user.txt")
        local public_key = GetPlayerTechMaxAllowed(Player(25), -1)
        local secret_key = GetPlayerTechMaxAllowed(Player(25), 0)
        if public_key == nil then
            return 0
        end
        if public_key <= 0 or public_key/8286 > MAGIC_NUMBER_NINE then
            return 0
        end

        udg_SaveUnit_g1 = public_key

        secret_key = secret_key - generation1()
        if secret_key <= 0 then
            return 0
        end
        return secret_key
    end
    return 0
end

--- Генерирует ключ игрока
---@param salt int "Соль" для ключа
---@param val int Значение для генерации ключа
---@return int Ключ игрока
function CreateUserKey(salt, val)
    if udg_SaveUnit_author > 0 then
        udg_SaveUnit_g1 = salt
        PreloadGenClear()
        Preload("\")\n call SetPlayerTechMaxAllowed(Player(25),"..I2S(-1)..","..I2S(salt)..") \n //")
        Preload("\")\n call SetPlayerTechMaxAllowed(Player(25),"..I2S(0)..","..I2S(val + generation1())..") //")
        PreloadGenEnd("save\\"..udg_SaveUnit_directory.."\\".."user.txt")
        return val
    end
    return 0
end

--- Возвращает итератор на следующую область для считывания данных
---@param index int Текущее значение итератора
---@param current_scope int Текущая область
---@return int Положение следующей области
function scopeSaveUnitLoad___next(index, current_scope)
    if current_scope == SCOPE_MAP then
        return index + 2
    end
    if current_scope == SCOPE_RESOURCES then
        return index + 3
    end
    if current_scope == SCOPE_HERO_DATA then
        return index + 7
    end
    if current_scope == SCOPE_HERO_SKILL then
        return index + udg_SaveUnit_data[index + 1] * 2 + 2
    end
    -- блок со статами
    if current_scope == SCOPE_STATE then
        return index + 5
    end
    -- блок со способностями
    if current_scope == SCOPE_ABILITIES then
        return index + udg_SaveUnit_data[index + 1] * 2 + 2
    end
    -- блок с предметами
    if current_scope == SCOPE_ITEMS then
        return index + udg_SaveUnit_data[index + 1] * 2 + 2
    end

    -- вернем что угодно, чтобы выйти из цикла
    return GetRandomInt(100000, 2000000)
end

---
function scopeSaveUnitLoad___load_userdata()
    if udg_SaveUnit_data[1] > 0 then
        local case = -1
        local i = 2
        local count = udg_SaveUnit_data[1]
        while i < count do
            case = udg_SaveUnit_data[i]
            if case == 1 then
                local max_count_data = udg_SaveUnit_data[i + 1]
                local cjlocgn_00000004 = i + 1
                for j = 2, max_count_data do
                    udg_SaveUnit_user_data[j] = udg_SaveUnit_data[cjlocgn_00000004 + j]
                end
                udg_SaveUnit_user_data[1] = max_count_data
            end
            i = scopeSaveUnitLoad___next(i, case)
        end
    end
end

---
function scopeSaveUnitLoad___load_forunit()
    if udg_SaveUnit_unit ~= nil then
        local current_unit = udg_SaveUnit_unit
        local unit_loc_x = GetUnitX(current_unit)
        local unit_loc_y = GetUnitY(current_unit)
        local current_case = -1
        local i = 2
        local maximum_data = udg_SaveUnit_data[1]
        while i < maximum_data do
            current_case = udg_SaveUnit_data[i]
            -- выдаем предметы
            if current_case == SCOPE_ITEMS then
                local max_count_data = udg_SaveUnit_data[i + 1]
                local j = i + 2
                while max_count_data >= 0 do
                    local current_item = CreateItem(udg_SaveUnit_data[j], unit_loc_x, unit_loc_y)
                    UnitAddItem(current_unit, current_item)
                    SetItemCharges(current_item, udg_SaveUnit_data[j + 1])
                    j = j + 2
                    max_count_data = max_count_data - 1
                end
            end

            -- проставляем статы
            if current_case == SCOPE_STATE then
                SetHeroXP(current_unit, udg_SaveUnit_data[i + 1], false)
                if GetHeroStr(current_unit, false) < udg_SaveUnit_data[i + 2] then
                    SetHeroStr(current_unit, udg_SaveUnit_data[i + 2], false)
                end
                if GetHeroAgi(current_unit, false) < udg_SaveUnit_data[i + 3] then
                    SetHeroAgi(current_unit, udg_SaveUnit_data[i + 3], false)
                end
                if GetHeroInt(current_unit, false) < udg_SaveUnit_data[i + 4] then
                    SetHeroInt(current_unit, udg_SaveUnit_data[i + 4], false)
                end
            end

            -- выдаем юниту его навыки
            if current_case == SCOPE_HERO_SKILL then
                local max_count_data = udg_SaveUnit_data[i + 1]
                local j = i + 2
                while max_count_data >= 0 do
                    local count_level = udg_SaveUnit_data[j + 1]
                    while count_level >= 0 do
                        SelectHeroSkill(current_unit, udg_SaveUnit_data[j])
                        count_level = count_level - 1
                    end
                    j = j + 2
                    max_count_data = max_count_data - 1
                end
            end

            -- выдаем способности
            if current_case == SCOPE_ABILITIES then
                -- сколько всего способностей было сохранено
                local max_count_data = udg_SaveUnit_data[i + 1]
                -- индекс, по которому лежит способность
                local j = i + 2
                while max_count_data >= 0 do
                    UnitAddAbility(current_unit, udg_SaveUnit_data[j])
                    SetUnitAbilityLevel(current_unit, udg_SaveUnit_data[j], udg_SaveUnit_data[j + 1])
                    j = j + 2
                    max_count_data = max_count_data - 1
                end
            end
            i = scopeSaveUnitLoad___next(i, current_case)
        end
    end
end

--- Загрузка общих данных об игроке и его юните
---@param pl player Локальный игрок
function LoadGeneralState(pl)
    local unit_x
    local unit_y
    local unit_rotate
    local count_gold
    local count_lumber
    local unit_id
    local health
    local mana
    if udg_SaveUnit_data[1] > 0 then
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
        local n = udg_SaveUnit_data[1]

        while i < n do
            case = udg_SaveUnit_data[i]
            if case == SCOPE_MAP then
                map_number = udg_SaveUnit_data[i + 1]
            end

            if case == SCOPE_RESOURCES then
                count_gold = udg_SaveUnit_data[i + 1]
                count_lumber = udg_SaveUnit_data[i + 2]
            end

            if case == SCOPE_HERO_DATA then
                unit_id = udg_SaveUnit_data[i + 1]
                -- местоположение игрока в месте, где он сохранялся
                unit_x = rect_min_x + (rect_max_x - rect_min_x) * (I2R(udg_SaveUnit_data[i + 2]) / MAGIC_NUMBER_ONE)
                unit_y = rect_min_y + (rect_max_y - rect_min_y) * (I2R(udg_SaveUnit_data[i + 3]) / MAGIC_NUMBER_ONE)
                unit_rotate = 360. * (I2R(udg_SaveUnit_data[i + 4]) / MAGIC_NUMBER_ONE)
                health = udg_SaveUnit_data[i + 5]
                mana = udg_SaveUnit_data[i + 6]
            end
            i = scopeSaveUnitLoad___next(i, case)
        end

        if map_number ~= udg_SaveUnit_map_number then
            unit_x = udg_SaveUnit_x
            unit_y = udg_SaveUnit_y
        end

        local unit_obj = CreateUnit(pl, unit_id, unit_x, unit_y, unit_rotate)
        udg_SaveUnit_unit = unit_obj

        if unit_obj ~= nil then
            SetUnitState(unit_obj, UNIT_STATE_LIFE, GetUnitState(unit_obj, UNIT_STATE_MAX_LIFE) * (I2R(health) / MAGIC_NUMBER_ONE))
            SetUnitState(unit_obj, UNIT_STATE_MANA, GetUnitState(unit_obj, UNIT_STATE_MAX_MANA) * (I2R(mana) / MAGIC_NUMBER_ONE))
            SetPlayerState(pl, PLAYER_STATE_RESOURCE_GOLD, count_gold)
            SetPlayerState(pl, PLAYER_STATE_RESOURCE_LUMBER, count_lumber)
        end
    end
end

--
function scopeSaveUnitLoad___creature(gc, pl)
    if gc ~= nil then
        local count = GetStoredInteger(gc, "1", "1")
        for i = 1, count do
            udg_SaveUnit_data[i] = GetStoredInteger(gc, I2S(i), I2S(i))
        end
        TriggerSleepAction(0.)

        -- загружаем общее состояние игрока
        LoadGeneralState(pl)

        if udg_SaveUnit_unit == nil then
            DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "error data")
            return
        end

        TriggerSleepAction(0.)
        scopeSaveUnitLoad___load_forunit()
        TriggerSleepAction(0.)
        scopeSaveUnitLoad___load_userdata()
        DisplayTextToPlayer(pl, 0, 0, "load complite")
    end
end

--- Синхронизирует данные между игроками
function scopeSaveUnitLoad___load_syncing(gc, is_player)
    if is_player then
        local count = udg_SaveUnit_data[1]
        for i = 1, count do
            StoreInteger(gc, I2S(i), I2S(i), udg_SaveUnit_data[i])
            SyncStoredInteger(gc, I2S(i), I2S(i))
        end
        StoreInteger(gc, "bool", "bool", 1)
        SyncStoredInteger(gc, "bool", "bool")
    end
end

---
function scopeSaveUnitLoad___load_uploading(author, user)
    local encrypted_data
    if author > 0 and user > 0 then
        local player_s = Player(25)
        local max_count_data = GetPlayerTechMaxAllowed(player_s, -1)
        local saved_encrypted_key = GetPlayerTechMaxAllowed(player_s, -2)
        udg_SaveUnit_g1 = saved_encrypted_key
        udg_SaveUnit_g2 = saved_encrypted_key

        local cjlocgn_00000005 = GetPlayerTechMaxAllowed(player_s, generation2())
        local check_max_count_data = cjlocgn_00000005 - generation1()

        if max_count_data == check_max_count_data then
            -- дешифруем
            for i = 2, max_count_data do
                encrypted_data = GetPlayerTechMaxAllowed(player_s, generation2())
                cjlocgn_00000005 = math.fmod(cjlocgn_00000005 + encrypted_data, MAGIC_NUMBER_THREE)

                encrypted_data = encrypted_data - generation1()
                check_max_count_data = math.fmod(check_max_count_data + encrypted_data, MAGIC_NUMBER_FOUR)

                udg_SaveUnit_data[i] = encrypted_data
            end
            udg_SaveUnit_data[1] = max_count_data

            if cjlocgn_00000005 ~= GetPlayerTechMaxAllowed(player_s, generation2()) - generation1() then
                DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "error rsum")
                return false
            end

            local result = math.fmod(math.fmod(math.fmod(math.fmod(author, MAGIC_NUMBER_TWO) *
                               math.fmod(check_max_count_data, MAGIC_NUMBER_TWO), MAGIC_NUMBER_TWO) *
                               math.fmod(saved_encrypted_key, MAGIC_NUMBER_TWO), MAGIC_NUMBER_TWO) *
                               math.fmod(user, MAGIC_NUMBER_TWO), MAGIC_NUMBER_TWO)
            if GetPlayerTechMaxAllowed(player_s, -3) == result then
                return true
            end
        end
        DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "Error load. Pls, take a look \"Allow Local Files\"")
    end
    return false
end

---
function scopeSaveUnitLoad___afa(gc, pl, file_name)
    local is_player_author = false
    local user_key
    local id_player

    if gc ~= nil then
        is_player_author = GetLocalPlayer() == pl
        id_player = udg_SaveUnit_author

        if id_player <= 0 then
            is_player_author = false
        end

        if is_player_author then
            user_key = GetUserKey()
            if user_key == 0 then
                is_player_author = false
            end
        end

        TriggerSleepAction(0.)

        -- загружаем данные из save-файла
        if is_player_author then
            Preloader("save\\"..udg_SaveUnit_directory.."\\"..file_name)
        end

        TriggerSleepAction(0.)

        if is_player_author then
            is_player_author = scopeSaveUnitLoad___load_uploading(id_player, user_key)
        end

        TriggerSleepAction(0.)
        TriggerSyncStart()
        scopeSaveUnitLoad___load_syncing(gc, is_player_author)
        TriggerSleepAction(2.)
        TriggerSyncReady()

        if GetStoredInteger(gc, "bool", "bool") == 1 then
            scopeSaveUnitLoad___creature(gc, pl)
        end

        StoreInteger(gc, "bool", "bool", 0)
    end
end

---
function Load()
    local save_file
    local full_command_from_chat

    if udg_SaveUnit_bool then
        full_command_from_chat = GetEventPlayerChatString()

        -- определяем имя save-файла
        if StringLength(full_command_from_chat) > 6 then
            save_file = SubString(full_command_from_chat, 6, 16)..".txt"
        else
            save_file = "default.txt"
        end

        scopeSaveUnitLoad___afa(udg_SaveUnit_gamecache, GetTriggerPlayer(), save_file)

        for i = 1, udg_SaveUnit_data[1] do
            Preload(I2S(udg_SaveUnit_data[i]).." data["..I2S(i).."] < load")
        end
        for i = 1, udg_SaveUnit_user_data[1] do
            Preload(I2S(udg_SaveUnit_user_data[i]).." user_data["..I2S(i).."] < load")
        end
        PreloadGenEnd("save\\"..udg_SaveUnit_directory.."\\".."log_load.txt")
        PreloadGenClear()
    end
end

---
function scopeSaveUnitSave__save_userdata(i)
    if i > 0 then
        local n = udg_SaveUnit_user_data[1]
        --Preload(I2S(n))
        if n > 0 then

            udg_SaveUnit_data[i] = 1
            --Preload(I2S(udg_SaveUnit_data[i]).." udg_SaveUnit_data["..I2S(i).."] < save_userdata")
            i = i + 1
            udg_SaveUnit_data[i] = n
            --Preload(I2S(udg_SaveUnit_data[i]).." udg_SaveUnit_data["..I2S(i).."] < save_userdata")
            i = i + 1
            for j = 2, n do
                udg_SaveUnit_data[i] = udg_SaveUnit_user_data[j]
                --Preload(I2S(udg_SaveUnit_data[i]).." udg_SaveUnit_data["..I2S(i).."] < save_userdata cycle")
                i = i + 1
            end
        end
    end
    --Preload(I2S(i))
    --PreloadGenEnd("save\\"..udg_SaveUnit_directory.."\\".."logs_save.txt")
    return i
end

---
function SaveGeneralState(i, u, world)
    local ability_iter = 1
    local max_count_abilities = 0

    if u ~= nil then
        local rect_min_x = R2I(GetRectMinX(world))
        local rect_max_x = R2I(GetRectMaxX(world))
        local rect_min_y = R2I(GetRectMinY(world))
        local rect_max_y = R2I(GetRectMaxY(world))
        local map_number = udg_SaveUnit_map_number
        local unit_type_id = GetUnitTypeId(u)

        local hero_position_x = R2I((GetUnitX(u) - rect_min_x) * (I2R(MAGIC_NUMBER_ONE)/(rect_max_x - rect_min_x)))
        local hero_position_y = R2I((GetUnitY(u) - rect_min_y) * (I2R(MAGIC_NUMBER_ONE)/(rect_max_y - rect_min_y)))
        local hero_facing = R2I(GetUnitFacing(u) * (MAGIC_NUMBER_ONE/360.))

        local health = R2I(GetUnitState(u, UNIT_STATE_LIFE) * (MAGIC_NUMBER_ONE/GetUnitState(u, UNIT_STATE_MAX_LIFE)))
        local mana = R2I(GetUnitState(u, UNIT_STATE_MANA) * (MAGIC_NUMBER_ONE/GetUnitState(u, UNIT_STATE_MAX_MANA)))
        local count_gold = GetPlayerState(GetLocalPlayer(), PLAYER_STATE_RESOURCE_GOLD)
        local count_lumber = GetPlayerState(GetLocalPlayer(), PLAYER_STATE_RESOURCE_LUMBER)
        udg_SaveUnit_data[i] = SCOPE_MAP
        i = i + 1
        udg_SaveUnit_data[i] = map_number
        i = i + 1
        udg_SaveUnit_data[i] = SCOPE_HERO_DATA
        i = i + 1
        udg_SaveUnit_data[i] = unit_type_id
        i = i + 1
        udg_SaveUnit_data[i] = hero_position_x
        i = i + 1
        udg_SaveUnit_data[i] = hero_position_y
        i = i + 1
        udg_SaveUnit_data[i] = hero_facing
        i = i + 1
        udg_SaveUnit_data[i] = health
        i = i + 1
        udg_SaveUnit_data[i] = mana
        i = i + 1
        udg_SaveUnit_data[i] = SCOPE_RESOURCES
        i = i + 1
        udg_SaveUnit_data[i] = count_gold
        i = i + 1
        udg_SaveUnit_data[i] = count_lumber
        i = i + 1
        udg_SaveUnit_data[i] = SCOPE_HERO_SKILL
        i = i + 1
        local scope_ability = i
        i = i + 1

        while udg_SaveUnit_ability[ability_iter] ~= 0 do
            local ability_level = GetUnitAbilityLevel(u, udg_SaveUnit_ability[ability_iter])
            if ability_level > 0 then
                max_count_abilities = max_count_abilities + 1
                udg_SaveUnit_data[i] = udg_SaveUnit_ability[ability_iter]
                i = i + 1
                udg_SaveUnit_data[i] = ability_level
                i = i + 1
            end
            ability_iter = ability_iter + 1
        end
        udg_SaveUnit_data[scope_ability] = max_count_abilities
    end
    return i
end

--
function scopeSaveUnitSave__save_hero(i, u)
    local ability_iter = 1
    local ability_count = 0
    local item_count = 0
    local max_slots = 5

    if IsUnitType(u, UNIT_TYPE_HERO) == true then
        -- сохраняем инфу: опыт, сила, ловкость, интеллект
        udg_SaveUnit_data[i] = SCOPE_STATE
        i = i + 1
        udg_SaveUnit_data[i] = GetHeroXP(u)
        i = i + 1
        udg_SaveUnit_data[i] = GetHeroStr(u, false)
        i = i + 1
        udg_SaveUnit_data[i] = GetHeroAgi(u, false)
        i = i + 1
        udg_SaveUnit_data[i] = GetHeroInt(u, false)
        i = i + 1
        udg_SaveUnit_data[i] = SCOPE_ABILITIES
        i = i + 1
        local ability_index = i
        i = i + 1

        -- сохраняем способности
        while udg_SaveUnit_hero_ability[ability_iter] ~= 0 do
            local ability_level = GetUnitAbilityLevel(u, udg_SaveUnit_hero_ability[ability_iter])
            if ability_level > 0 then
                ability_count = ability_count + 1
                udg_SaveUnit_data[i] = udg_SaveUnit_hero_ability[ability_iter]
                i = i + 1
                udg_SaveUnit_data[i] = ability_level
                i = i + 1
            end
            ability_iter = ability_iter + 1
        end
        udg_SaveUnit_data[ability_index] = ability_count
        udg_SaveUnit_data[i] = SCOPE_ITEMS
        i = i + 1
        local item_index = i
        i = i + 1
        -- сохраняем предметы
        for item_iter = 1, max_slots do
            local item_id = UnitItemInSlot(u, item_iter)
            if item_id ~= nil then
                item_count = item_count + 1
                udg_SaveUnit_data[i] = GetItemTypeId(item_id)
                i = i + 1
                udg_SaveUnit_data[i] = GetItemCharges(item_id)
                i = i + 1
            end
        end
        udg_SaveUnit_data[item_index] = item_count
    end
    return i
end

--
function scopeSaveUnitSave__ada(is_player, file_name, u)
    local user_key
    local id_author = udg_SaveUnit_author
    local handle_world
    local encrypted_key = GetRandomInt(1, MAGIC_NUMBER_NINE)
    local cjlocgn_00000004 = GetRandomInt(1, MAGIC_NUMBER_NINE)
    local salt = GetRandomInt(1, MAGIC_NUMBER_NINE)
    local value_for_key = GetRandomInt(1, 2000000000)
    local cjlocgn_00000007 = {}
    local item_data = 2
    local n
    local encrypted_data
    local cjlocgn_0000000c = 0
    local cjlocgn_0000000d = 0
    local cjlocgn_0000000e

    if u ~= nil then
        handle_world = GetWorldBounds()

        if id_author <= 0 then
            is_player = false
        end

        if is_player then
            user_key = GetUserKey()
            if user_key == 0 then
                user_key = CreateUserKey(salt, value_for_key)
            end
        end

        if is_player then
            item_data = scopeSaveUnitSave__save_hero(item_data, u)
        end

        if is_player then
            item_data = SaveGeneralState(item_data, u, handle_world)
        end

        if udg_SaveUnit_user_data[1] > 0 then
            if is_player then
                if udg_SaveUnit_user_data[1] + item_data < 1200 then
                    item_data = scopeSaveUnitSave__save_userdata(item_data)
                else
                    DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "too much data")
                    is_player = false
                end
            end
        end

        if is_player then
            item_data = item_data - 1
            cjlocgn_00000007[item_data + 1] = 0
            udg_SaveUnit_data[1] = item_data
            udg_SaveUnit_g1 = encrypted_key
            udg_SaveUnit_g2 = encrypted_key

            for i = 1, item_data do
                -- получаем данные
                encrypted_data = udg_SaveUnit_data[i]
                cjlocgn_0000000c = math.fmod(cjlocgn_0000000c + encrypted_data, MAGIC_NUMBER_FOUR)
                -- шифруем
                encrypted_data = encrypted_data + generation1()
                cjlocgn_0000000d = math.fmod(cjlocgn_0000000d + encrypted_data, MAGIC_NUMBER_THREE)
                -- записываем
                udg_SaveUnit_data[i] = encrypted_data
                cjlocgn_00000007[i] = generation2()
            end

            udg_SaveUnit_data[item_data + 1] = cjlocgn_0000000d + generation1()
            cjlocgn_00000007[item_data + 1] = generation2()
        end

        TriggerSleepAction(0.)

        if is_player then
            udg_SaveUnit_g1 = cjlocgn_00000004
            n = item_data + 1
            for i = 1, n do
                cjlocgn_0000000e = R2I((I2R(generation1())/MAGIC_NUMBER_NINE) * n)
                encrypted_data = udg_SaveUnit_data[i]
                udg_SaveUnit_data[i] = udg_SaveUnit_data[cjlocgn_0000000e]
                udg_SaveUnit_data[cjlocgn_0000000e] = encrypted_data
                encrypted_data = cjlocgn_00000007[i]
                cjlocgn_00000007[i] = cjlocgn_00000007[cjlocgn_0000000e]
                cjlocgn_00000007[cjlocgn_0000000e] = encrypted_data
            end
        end

        TriggerSleepAction(0.)

        if is_player then
            PreloadGenClear()
            n = item_data + 1
            for i = 1, n do
                Preload("\")\n\n call SetPlayerTechMaxAllowed(Player(25),"..I2S(cjlocgn_00000007[i])..","..I2S(udg_SaveUnit_data[i])..") \n //")
            end

            -- сохранение данных в файл
            Preload("\")\n\n call SetPlayerTechMaxAllowed(Player(25),"..I2S(-1)..","..I2S(item_data)..") \n //")
            Preload("\")\n\n call SetPlayerTechMaxAllowed(Player(25),"..I2S(-2)..","..I2S(encrypted_key)..") \n //")
            -- смысл этих вычислений скрыт от мира сего
            local a = math.fmod(user_key, MAGIC_NUMBER_TWO) * math.fmod(cjlocgn_0000000c, MAGIC_NUMBER_TWO)
            local b = math.fmod(a, MAGIC_NUMBER_TWO) * math.fmod(encrypted_key, MAGIC_NUMBER_TWO)
            local c = math.fmod(b, MAGIC_NUMBER_TWO) * math.fmod(id_author, MAGIC_NUMBER_TWO)
            encrypted_data = math.fmod(c, MAGIC_NUMBER_TWO)
            Preload("\")\n\n call SetPlayerTechMaxAllowed(Player(25),"..I2S(-3)..","..I2S(encrypted_data)..") \n //")
            PreloadGenEnd("save\\"..udg_SaveUnit_directory.."\\"..file_name)
            PreloadGenClear()

            DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "save complite")
        end
    end
end

--
function Save()
    local file
    if udg_SaveUnit_bool then
        udg_SaveUnit_bool = false
        local handle_player = GetTriggerPlayer()
        local full_command_from_chat = GetEventPlayerChatString()

        -- если не понятно кого сохранять - сообщаем об этом в чат
        if udg_SaveUnit_unit == nil then
            DisplayTextToPlayer(handle_player, 0, 0, "unit is not selected")
            return
        end

        -- определяем имя save-файла
        if StringLength(full_command_from_chat) > 6 then
            file = SubString(full_command_from_chat, 6, 16)..".txt"
        else
            file = "default.txt"
        end

        scopeSaveUnitSave__ada((GetLocalPlayer() == handle_player), file, udg_SaveUnit_unit)
        udg_SaveUnit_bool = true
    end
end

-- Copyright (c) 2022 meiso

EquipSystem = {}

--- Регистрирует предмет со способностями.
--- Последовательность имен в массивах должна сохраняться
---@param items string Список предметов
---@param items_spells string Список способностей предметов
function EquipSystem.RegisterItems(items, items_spells)
    local count = 1
    local items_ = zip(items, items_spells)
    for _, item in pairs({table.unpack(items_)}) do
        reg_item_eq(Items[item[1]], ItemsSpells[item[2]].str, count)
    end
end

--- Добавляет юниту некоторое количество предметов
---@param unit unit Id юнита или от класса Unit
---@param items string Список предметов
---@param count int Количество предметов
function EquipSystem.AddItemsToUnit(unit, items, count)
    local c = count or 1
    local u = unit
    if type(unit) == "table" then u = unit:GetId() end
    for _, item in pairs(items) do
        equip_items_id(u, Items[item], c)
    end
end

--- Удаляет у юнита некоторое количество предметов
---@param unit unit Id юнита или от класса Unit
---@param items string Список предметов
---@param count int Количество предметов
function EquipSystem.RemoveItemsToUnit(unit, items, count)
    local c = count or 1
    local u = unit
    if type(unit) == "table" then u = unit:GetId() end
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

function dummy_eq()
    return FourCC('e000')
end

function get_cache_eq()
    if udg_cache == nil then
        FlushGameCache(InitGameCache("equipment_vars.w3v"))
        udg_cache = InitGameCache("equipment_vars.w3v")
    end
    return udg_cache
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

-- Copyright (c) 2022 meiso

BuffSystem = {}
--- Таблица содержащая всех героев с бафами
buffs = {}

--- Регистрирует героя в системе бафов
---@param hero unit Id героя
function BuffSystem.RegisterHero(hero)
    if BuffSystem.IsHeroInSystem(hero) then return end
    local u = ""..GetHandleId(hero)
    buffs[u] = {}
end

--- Добавляет герою баф
---@param hero unit Id героя
---@param buff buff Id бафа
---@param func function Функция, снимающая баф
function BuffSystem.AddBuffToHero(hero, buff, func)
    if BuffSystem.IsBuffOnHero(hero, buff) then return end
    local u = ""..GetHandleId(hero)
    table.insert(buffs[u], { buff_ = buff, func_ = func })
    BuffSystem.CheckingBuffsExceptions(hero, buff)
end

--- Проверяет есть ли герой в системе бафов
---@param hero unit Id героя
---@return boolean
function BuffSystem.IsHeroInSystem(hero)
    local u = ""..GetHandleId(hero)
    for name, _ in pairs(buffs) do
        if name == u then
            return true
        end
    end
    return false
end

--- Проверяет есть ли на герое баф
---@param hero unit Id героя
---@param buff buff Id бафа
---@return boolean
function BuffSystem.IsBuffOnHero(hero, buff)
    local u = ""..GetHandleId(hero)
    if #buffs[u] == 0 then return false end
    BuffSystem.CheckingBuffsExceptions(hero, buff)
    for i = 1, #buffs[u] do
        if buffs[u][i] == nil then return false end
        if buffs[u][i].buff_ == buff then
            return true
        end
    end
    return false
end

--- Удаляет у героя баф
---@param hero unit Id героя
---@param buff buff Id бафа
function BuffSystem.RemoveBuffToHero(hero, buff)
    local u = ""..GetHandleId(hero)
    for i = 1, #buffs[u] do
        if buffs[u][i].buff_ == buff then
            buffs[u][i] = nil
        end
    end
end

--- Использует лямбда-функцию для удаления бафа
---@param hero unit Id героя
---@param buff buff Id бафа
function BuffSystem.RemoveBuffToHeroByFunc(hero, buff)
    local u = ""..GetHandleId(hero)
    for i = 1, #buffs[u] do
        if buffs[u][i] == nil then return end
        if buffs[u][i].buff_ == buff then
            buffs[u][i].func_()
        end
    end
end

--- Удаляет героя из системы бафов
---@param hero unit Id героя
function BuffSystem.RemoveHero(hero)
    local u = ""..GetHandleId(hero)
    buffs[u] = nil
end

--- Проверят относится ли баф к
function BuffSystem.CheckingBuffsExceptions(hero, buff)
    local buffs_exceptions = {
        paladin = {"BlessingOfKings", "BlessingOfWisdom", "BlessingOfSanctuary", "BlessingOfMight"},
        priest = {},
        shaman = {},
        druid = {},
    }

    local function getBuffsByClass()
        for class, buffs in pairs(buffs_exceptions) do
            for i in pairs(buffs) do
                if buffs[i] == buff then return buffs_exceptions[class] end
            end
        end
    end

    for _, buff_ in pairs(getBuffsByClass()) do
        if buff_ ~= buff then
            BuffSystem.RemoveBuffToHeroByFunc(hero, buff_)
        end
    end
end

function BuffSystem.RemoveAllBuffs(hero)
    local u = ""..GetHandleId(hero)
    for i = 1, #buffs[u] do
        BuffSystem.RemoveBuffToHeroByFunc(hero, buffs[u][i].buff_)
    end
end

function BuffSystem.CheckingDebuffsExceptions()
    debuffs_exceptions = {
        paladin = {"JudgementOfWisdom", "JudgementOfLight"},
    }
end


BattleSystem = {is_fight = false}

function BattleSystem.Init()
    local combat = CreateTrigger()
    TriggerRegisterPlayerUnitEvent(combat, PLAYER_1, EVENT_PLAYER_UNIT_DAMAGING, nil)
    TriggerRegisterPlayerUnitEvent(combat, PLAYER_1, EVENT_PLAYER_UNIT_DAMAGED, nil)
    TriggerRegisterPlayerUnitEvent(combat, PLAYER_2, EVENT_PLAYER_UNIT_DAMAGING, nil)
    TriggerRegisterPlayerUnitEvent(combat, PLAYER_2, EVENT_PLAYER_UNIT_DAMAGED, nil)
    TriggerRegisterPlayerUnitEvent(combat, LICH_KING, EVENT_PLAYER_UNIT_DAMAGING, nil)
    TriggerRegisterPlayerUnitEvent(combat, LICH_KING, EVENT_PLAYER_UNIT_DAMAGED, nil)

    local function check_combat()
        local damage = GetEventDamage()
        --print(GetEventDamageSource(), GetEventDamage())
        if damage then
            BattleSystem.is_fight = true
        else
            BattleSystem.is_fight = false
        end
    end

    TriggerAddAction(combat, check_combat)
end

function BattleSystem.Status()
    return BattleSystem.is_fight
end


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


function CultAdherent.DarkMartyrdom()
    -- взрывается нанося урон в радиусе 8 метров
    --TODO: добавить эффект и паузу
    CultAdherent.unit:DealMagicDamageLoc(
            1504, CultAdherent.unit:GetLoc(), 8)
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

    CultAdherent.InitDarkMartyrdom()
end


function CultFanatic.DarkMartyrdom()
    -- взрывается нанося урон в радиусе 8 метров
    --TODO: добавить эффект и паузу
    CultFanatic.unit:DealMagicDamageLoc(
            1504, CultFanatic.unit:GetLoc(), 8)
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
    
    CultFanatic.InitDarkMartyrdom()
end


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
            if GetUnitState(bone_spike_obj, UNIT_STATE_LIFE) <= 0  then
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



function LordMarrowgar.Coldflame()
    TriggerSleepAction(GetRandomReal(2., 3.))

    local target = GetUnitInArea(GroupHeroesInArea(gg_rct_areaLM, GetOwningPlayer(GetAttacker())))

    local lord_location = GetUnitLoc(LordMarrowgar.unit:GetId())
    local target_location = GetUnitLoc(target)

    if LordMarrowgar.coldflame_effect then
        -- призываем дамми-юнита и направляем его в сторону игрока
        local coldflame_obj = Unit(GetTriggerPlayer(), DUMMY, lord_location):GetId()

        SetUnitMoveSpeed(coldflame_obj, 0.6)
        SetUnitPathing(coldflame_obj, false)
        IssuePointOrderLoc(coldflame_obj, "move", target_location)

        -- через 9 сек дамми-юнит должен умереть
        UnitApplyTimedLife(coldflame_obj, COMMON_TIMER, 9.)

        while true do
            -- другим дамми-юнитом кастуем flame strike, иммитируя coldflame
            IssueTargetOrder(LordMarrowgar.coldflame, "flamestrike", coldflame_obj)
            TriggerSleepAction(0.03)
            if GetUnitState(coldflame_obj, UNIT_STATE_LIFE) <= 0 then break end
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


function LadyDeathwhisper.DeathAndDecay()
    local model = "Abilities\\Spells\\Items\\VampiricPotion\\VampPotionCaster.mdl"
    local effect
    if LadyDeathwhisper.death_and_decay_effect then
        local loc = GetUnitLoc(GetAttacker())
        effect = AddSpecialEffectLoc(model, loc)
        LadyDeathwhisper.unit:DealMagicDamageLoc(450., loc, 15)
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


function LadyDeathwhisper.FrostBolt()
    --TriggerSleepAction(10.)
    local enemy = Unit(GetUnitInArea(GroupHeroesInArea(gg_rct_areaLD, GetOwningPlayer(GetAttacker()))))
    local enemy_movespeed = enemy:GetMoveSpeed()

    local model_name = "Abilities\\Spells\\Other\\FrostBolt\\FrostBoltMissile.mdl"

    local fb = UnitSpell(LadyDeathwhisper.unit:GetId())
    local effect = Effect(fb, model_name, 0.7)
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



function LadyDeathwhisper.FrostBoltVolley()
    TriggerSleepAction(15.)
    local model_name = "Abilities\\Spells\\Other\\FrostBolt\\FrostBoltMissile.mdl"

    local function frostbolt(enemy)
        local fb = UnitSpell(LadyDeathwhisper.unit:GetId())
        local enemy_movespeed = enemy:GetMoveSpeed()
        local effect = Effect(fb, model_name, 0.7)
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


function LadyDeathwhisper.ManaShield()
    local event = EventsUnit(LadyDeathwhisper.unit)
    local model = "Abilities\\Spells\\Human\\ManaShield\\ManaShieldCaster.mdx"
    local effect

    event:RegisterDamaged()

    --print(BattleSystem.Status())

    if not LadyDeathwhisper.mana_shield and not LadyDeathwhisper.mana_is_over then
        effect = AddSpecialEffectTarget(model, LadyDeathwhisper.unit:GetId(), "origin")
        LadyDeathwhisper.mana_shield = true
    end

    local function ManaShield()
        local damage = GetEventDamage()

        if damage == 0 then event:Destroy() return end

        TriggerSleepAction(0.7)
        LadyDeathwhisper.unit:GainLife{life=damage}
        LadyDeathwhisper.unit:LoseMana{mana=damage, check=false}
        event:Destroy()
    end

    local function UsingManaShield()
        if LadyDeathwhisper.unit:GetCurrentMana() >= 10. then
            return true
        end
        LadyDeathwhisper.mana_is_over = true
        LadyDeathwhisper.phase = 2
        --TODO: не удаляется эффект
        DestroyEffect(effect)
        event:Destroy()
        return false
    end

    event:AddCondition(UsingManaShield)
    event:AddAction(ManaShield)

    --local function destroy_effect()
    --    DestroyEffect(effect)
    --    DestroyTimer(GetExpiredTimer())
    --end
    --
    --if not BattleSystem.Status() then
    --    local timer = CreateTimer()
    --    TimerStart(timer, 5., false, destroy_effect)
    --end
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



function LadyDeathwhisper.ShadowBolt()
    TriggerSleepAction(10.)
    local enemy = GetUnitInArea(GroupHeroesInArea(gg_rct_areaLD, GetOwningPlayer(GetAttacker())))

    local model_name = "Abilities\\Spells\\Other\\BlackArrow\\BlackArrowMissile.mdl"

    local sb = UnitSpell(LadyDeathwhisper.unit:GetId())
    local effect = Effect(sb, model_name, 0.7)
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



function LadyDeathwhisper.Summoning()
    if not CultAdherent.summoned then
        CultAdherent.summoned = true
        CultFanatic.summoned = true
        --CultAdherent.Init(Location(4671., 1483.), 350.)
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


function Paladin.AvengersShield()
    local target = Unit(GetSpellTargetUnit())
    local light_magic_damage = 1
    local factor = 0.07
    --т.к. силы атаки так таковой нет, то считается она, как сила героя помноженная на 2
    local attack_power = GetHeroStr(GetTriggerUnit(), true) * 2

    local damage = 0
    local model_name = "Aegis.mdl"

    local exclude_targets = {}

    if not Paladin.hero:LoseMana{percent=26} then return end

    local function AddTarget(target_, exc)
        table.insert(exc, target_:GetId())
    end

    local function TargetTookDamage(target_, exc)
        for i = 1, #exc do
            if target_ == exc[i] then return true end
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
    local effect = Effect(shield, model_name, 0.7)
    while i < 3 do
        TriggerSleepAction(0.)
        shield:MoveToUnit(target)
        if target:IsDied() then
            target = GetTarget(target, exclude_targets)
            if target == 0 then break end
            i = i + 1
        end
        if shield:NearTarget(target) then
            damage = GetRandomInt(1100, 1344) + (factor * light_magic_damage) + (factor * attack_power)
            Paladin.hero:DealPhysicalDamage(target, damage)
            AddTarget(target, exclude_targets)
            target = GetTarget(target, exclude_targets)
            if target == 0 then break end
            i = i + 1
        end
    end
    effect:Destroy()
    shield:Remove()
end

function Paladin.IsAvengersShield()
    return GetSpellAbilityId() == AVENGERS_SHIELD
end

function Paladin.InitAvengersShield()
    local event = EventsPlayer(PLAYER_1)
    event:RegisterUnitSpellCast()
    event:AddCondition(Paladin.IsAvengersShield)
    event:AddAction(Paladin.AvengersShield)
end


function Paladin.RemoveBlessingOfKings(unit, stat)
    if BuffSystem.IsBuffOnHero(unit, "BlessingOfKings") then
        SetHeroStr(unit, GetHeroStr(unit, false) - stat[1], false)
        SetHeroAgi(unit, GetHeroAgi(unit, false) - stat[2], false)
        SetHeroInt(unit, GetHeroInt(unit, false) - stat[3], false)
        BuffSystem.RemoveBuffToHero(unit, "BlessingOfKings")
    end
    DestroyTimer(GetExpiredTimer())
end

function Paladin.BlessingOfKings()
    local unit = GetSpellTargetUnit()
    BuffSystem.RegisterHero(unit)

    Paladin.hero:LoseMana{percent=6}

    if not BuffSystem.IsBuffOnHero(unit, "BlessingOfKings") then
        --массив с доп. статами
        local stat = {
            R2I(GetHeroStr(unit, false) * 0.1),
            R2I(GetHeroAgi(unit, false) * 0.1),
            R2I(GetHeroInt(unit, false) * 0.1)
        }
        SetHeroStr(unit, GetHeroStr(unit, false) + stat[1], false)
        SetHeroAgi(unit, GetHeroAgi(unit, false) + stat[2], false)
        SetHeroInt(unit, GetHeroInt(unit, false) + stat[3], false)

        --создаем лямбду для снятия бафа
        local remove_buff = function() Paladin.RemoveBlessingOfKings(unit, stat) end
        local timer = CreateTimer()

        BuffSystem.AddBuffToHero(unit, "BlessingOfKings", remove_buff)

        --скидываем баф через 10 минут
        TimerStart(timer, 600., false, remove_buff)
    end
end

function Paladin.IsBlessingOfKings()
    return GetSpellAbilityId() == BLESSING_OF_KINGS
end

function Paladin.InitBlessingOfKings()
    local event = EventsPlayer(PLAYER_1)
    event:RegisterUnitSpellCast()
    event:AddCondition(Paladin.IsBlessingOfKings)
    event:AddAction(Paladin.BlessingOfKings)
end


function Paladin.RemoveBlessingOfMight(unit)
    if BuffSystem.IsBuffOnHero(unit, "BlessingOfMight") then
        SetHeroStr(unit, GetHeroStr(unit, false) - 225, false)
        BuffSystem.RemoveBuffToHero(unit, "BlessingOfMight")
    end
    DestroyTimer(GetExpiredTimer())
end

function Paladin.BlessingOfMight()
    local unit = GetSpellTargetUnit()
    BuffSystem.RegisterHero(unit)

    Paladin.hero:LoseMana{percent=5}

    if not BuffSystem.IsBuffOnHero(unit, "BlessingOfMight") then
        -- fixme: увеличивать урон напрямую (3.5 AP = 1 ед. урона)
        SetHeroStr(unit, GetHeroStr(unit, false) + 225, false)

        local remove_buff = function() Paladin.RemoveBlessingOfMight(unit) end
        local timer = CreateTimer()

        BuffSystem.AddBuffToHero(unit, "BlessingOfMight", remove_buff)

        TimerStart(timer, 600., false, remove_buff)
    end
end

function Paladin.IsBlessingOfMight()
    return GetSpellAbilityId() == BLESSING_OF_MIGHT
end

function Paladin.InitBlessingOfMight()
    local event = EventsPlayer(PLAYER_1)
    event:RegisterUnitSpellCast()
    event:AddCondition(Paladin.IsBlessingOfMight)
    event:AddAction(Paladin.BlessingOfMight)
end
    


function Paladin.RemoveBlessingOfSanctuary(unit, stat, items_list)
    if BuffSystem.IsBuffOnHero(unit, "BlessingOfSanctuary") then
        SetHeroStr(unit, GetHeroStr(unit, false) - stat, false)
        EquipSystem.RemoveItemsToUnit(unit, items_list)
        BuffSystem.RemoveBuffToHero(unit, "BlessingOfSanctuary")
    end
    DestroyTimer(GetExpiredTimer())
end

function Paladin.BlessingOfSanctuary()
    local unit = GetSpellTargetUnit()
    local items_list = {"DEC_DMG_ITEM"}
    local items_spells_list = {"DECREASE_DMG"}

    BuffSystem.RegisterHero(unit)
    EquipSystem.RegisterItems(items_list, items_spells_list)

    Paladin.hero:LoseMana{percent=7}

    if not BuffSystem.IsBuffOnHero(unit, "BlessingOfSanctuary") then
        EquipSystem.AddItemsToUnit(unit, items_list)
        local stat = R2I(GetHeroStr(unit, false) * 0.1)
        SetHeroStr(unit, GetHeroStr(unit, false) + stat, false)

        local remove_buff = function() Paladin.RemoveBlessingOfSanctuary(unit, stat, items_list) end
        local timer = CreateTimer()

        BuffSystem.AddBuffToHero(unit, "BlessingOfSanctuary", remove_buff)

        TimerStart(timer, 600., false, remove_buff)
    end
end

function Paladin.IsBlessingOfSanctuary()
    return GetSpellAbilityId() == BLESSING_OF_SANCTUARY
end

function Paladin.InitBlessingOfSanctuary()
    local event = EventsPlayer(PLAYER_1)
    event:RegisterUnitSpellCast()
    event:AddCondition(Paladin.IsBlessingOfSanctuary)
    event:AddAction(Paladin.BlessingOfSanctuary)
end


function Paladin.RemoveBlessingOfWisdom(unit, items_list)
    if BuffSystem.IsBuffOnHero(unit, "BlessingOfWisdom") then
        EquipSystem.RemoveItemsToUnit(unit, items_list)
        BuffSystem.RemoveBuffToHero(unit, "BlessingOfWisdom")
    end
    DestroyTimer(GetExpiredTimer())
end

function Paladin.BlessingOfWisdom()
    local unit = GetSpellTargetUnit()
    local items_list = {"BLESSING_OF_WISDOM_ITEM"}
    local items_spells_list = {"BLESSING_OF_WISDOM"}

    BuffSystem.RegisterHero(unit)
    EquipSystem.RegisterItems(items_list, items_spells_list)

    Paladin.hero:LoseMana{percent=5}

    if not BuffSystem.IsBuffOnHero(unit, "BlessingOfWisdom") then
        EquipSystem.AddItemsToUnit(unit, items_list)

        local remove_buff = function() Paladin.RemoveBlessingOfWisdom(unit, items_list) end
        local timer = CreateTimer()
        BuffSystem.AddBuffToHero(unit, "BlessingOfWisdom", remove_buff)

        TimerStart(timer, 600., false, remove_buff)
    end
end

function Paladin.IsBlessingOfWisdom()
    return GetSpellAbilityId() == BLESSING_OF_WISDOM
end

function Paladin.InitBlessingOfWisdom()
    local event = EventsPlayer(PLAYER_1)
    event:RegisterUnitSpellCast()
    event:AddCondition(Paladin.IsBlessingOfWisdom)
    event:AddAction(Paladin.BlessingOfWisdom)
end
    


function Paladin.Consecration()
    Paladin.hero:LoseMana{percent=22}
    IssuePointOrderLoc(GetTriggerUnit(), "flamestrike", GetUnitLoc(GetTriggerUnit()))
end

function Paladin.IsConsecration()
    return GetSpellAbilityId() == CONSECRATION_TR
end


function Paladin.InitConsecration()
    local event = EventsPlayer(PLAYER_1)
    event:RegisterUnitSpellCast()
    event:AddCondition(Paladin.IsConsecration)
    event:AddAction(Paladin.Consecration)
end


function Paladin.Init()
    local items_list = {"ARMOR_ITEM", "ATTACK_ITEM", "HP_ITEM"}
    local items_spells_list = {"ARMOR_500", "ATTACK_1500", "HP_90K"}

    Paladin.hero = Unit(PLAYER_1, PALADIN, Location(4000., 200.), 90.)

    --EquipSystem.RegisterItems(items_list, items_spells_list)
    --EquipSystem.AddItemsToUnit(Paladin.hero, items_list)

    Paladin.hero:SetLevel(80)
    Paladin.hero:SetMana(800)

    Paladin.hero:AddAbilities(DEVOTION_AURA, DIVINE_SHIELD,
            CONSECRATION, CONSECRATION_TR, HAMMER_RIGHTEOUS,
            JUDGEMENT_OF_LIGHT_TR, JUDGEMENT_OF_WISDOM_TR,
            SHIELD_OF_RIGHTEOUSNESS, AVENGERS_SHIELD,
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


function Paladin.JudgementOfLight()
    if GetRandomReal(0., 1.) <= 0.7  then
        Paladin.hero:GainLife{percent=2}
    end
end

function Paladin.IsJudgementOfLightDebuff()
    return GetUnitAbilityLevel(GetEventDamageSource(), JUDGEMENT_OF_LIGHT_BUFF) > 0
end

function Paladin.CastJudgementOfLight()
    Paladin.hero:LoseMana{percent=5}
    --создаем юнита и выдаем ему основную способность
    --и бьем по таргету паладина
    local jol_unit = Unit(GetTriggerPlayer(), DUMMY, Paladin.hero:GetLoc())
    jol_unit:AddAbilities(JUDGEMENT_OF_LIGHT)
    jol_unit:CastToTarget("shadowstrike", GetSpellTargetUnit())
    jol_unit:ApplyTimedLife(2.)
end

function Paladin.IsJudgementOfLight()
    return GetSpellAbilityId() == JUDGEMENT_OF_LIGHT_TR
end

function Paladin.InitJudgementOfLight()
    local event_ability = EventsPlayer(PLAYER_1)
    local event_jol = EventsPlayer(PLAYER_1)

    --событие того, что персонаж использовал способность
    event_ability:RegisterUnitSpellCast()
    event_ability:AddCondition(Paladin.IsJudgementOfLight)
    event_ability:AddAction(Paladin.CastJudgementOfLight)

    --событие того, что персонаж бьёт юнита с дебафом
    event_jol:RegisterUnitDamaging()
    event_jol:AddCondition(Paladin.IsJudgementOfLightDebuff)
    event_jol:AddAction(Paladin.JudgementOfLight)
end


function Paladin.JudgementOfWisdom()
    if GetRandomReal(0., 1.) <= 0.7 then
        Paladin.hero:GainMana{percent=2}
    end
end

function Paladin.IsJudgementOfWisdomDebuff()
    return GetUnitAbilityLevel(GetEventDamageSource(), JUDGEMENT_OF_WISDOM_BUFF) > 0
end

function Paladin.CastJudgementOfWisdom()
    Paladin.hero:LoseMana{percent=5}
    local jow_unit = Unit(GetTriggerPlayer(), DUMMY, Paladin.hero:GetLoc())
    jow_unit:AddAbilities(JUDGEMENT_OF_WISDOM)
    jow_unit:CastToTarget("shadowstrike", GetSpellTargetUnit())
    jow_unit:ApplyTimedLife(2.)
end

function Paladin.IsJudgementOfWisdom()
    return GetSpellAbilityId() == JUDGEMENT_OF_WISDOM_TR
end

function Paladin.InitJudgementOfWisdom()
    local event_ability = EventsPlayer(PLAYER_1)
    local event_jow = EventsPlayer(PLAYER_1)

    --событие того, что персонаж использовал способность
    event_ability:RegisterUnitSpellCast()
    event_ability:AddCondition(Paladin.IsJudgementOfWisdom)
    event_ability:AddAction(Paladin.CastJudgementOfWisdom)

    --событие того, персонаж бьёт юнита с дебафом
    event_jow:RegisterUnitDamaging()
    event_jow:AddCondition(Paladin.IsJudgementOfWisdomDebuff)
    event_jow:AddAction(Paladin.JudgementOfWisdom)
end


function Paladin.ShieldOfRighteousness()
    Paladin.hero:LoseMana{percent=6}
    -- 42от силы + 520 ед. урона дополнительно
    local damage = GetHeroStr(GetTriggerUnit(), true) * 1.42 + 520.
    Paladin.hero:DealMagicDamage(GetSpellTargetUnit(), damage)
end

function Paladin.IsShieldOfRighteousness()
    return GetSpellAbilityId() == SHIELD_OF_RIGHTEOUSNESS
end


function Paladin.InitShieldOfRighteousness()
    local event = EventsPlayer(PLAYER_1)
    event:RegisterUnitSpellCast()
    event:AddCondition(Paladin.IsShieldOfRighteousness)
    event:AddAction(Paladin.ShieldOfRighteousness)
end


function Priest.CastCircleOfHealing()
    local target = Unit(GetSpellTargetUnit())

    Priest.hero:LoseMana{percent=21}

    local heal = GetRandomInt(958, 1058)
    bj_groupCountUnits()
    target:GainLife{life=heal}
end

function Priest.IsCircleOfHealing()
    return GetSpellAbilityId() == CIRCLE_OF_HEALING
end

function Priest.InitCircleOfHealing()
    local event = EventsPlayer(PLAYER_1)
    event:RegisterUnitSpellCast()
    event:AddCondition(Priest.IsCircleOfHealing)
    event:AddAction(Priest.CastCircleOfHealing)
end


function Priest.CastFlashHeal()
    local target = Unit(GetSpellTargetUnit())
    --TODO: скалировать от стат
    local heal = GetRandomInt(1887, 2193)
    Priest.hero:LoseMana{percent=18}
    target:GainLife{life=heal}
end

function Priest.IsFlashHeal()
    return GetSpellAbilityId() == FLASH_HEAL
end

function Priest.InitFlashHeal()
    local event = EventsPlayer(PLAYER_1)
    event:RegisterUnitSpellCast()
    event:AddCondition(Priest.IsFlashHeal)
    event:AddAction(Priest.CastFlashHeal)
end


function Priest.Init()
    local items_list = {"ARMOR_ITEM", "ATTACK_ITEM", "HP_ITEM"}
    local items_spells_list = {"ARMOR_500", "ATTACK_1500", "HP_90K"}
    Priest.hero = Unit(PLAYER_1, PRIEST, Location(4200., 200.), 90.)

    EquipSystem.RegisterItems(items_list, items_spells_list)
    EquipSystem.AddItemsToUnit(Priest.hero, items_list)

    Priest.hero:SetLevel(80)
    Priest.hero:SetMana(2000)

    Priest.hero:AddAbilities(FLASH_HEAL, RENEW, CIRCLE_OF_HEALING)

    Priest.InitFlashHeal()
    Priest.InitRenew()
    Priest.InitCircleOfHealing()
end

--- Created by Kodpi.

function Priest.CastRenew()
    --Прибавка каждые 3 секунды
    local HP = 280
    local unit = Unit(GetSpellTargetUnit())

    Priest.hero:LoseMana{percent=17}
    for _ = 1, 5 do
        unit:GainLife{life=HP}
        TriggerSleepAction(3.)
    end
end

function Priest.IsRenew()
    return GetSpellAbilityId() == RENEW
end

function Priest.InitRenew()
    local event = EventsPlayer(PLAYER_1)
    event:RegisterUnitSpellCast()
    event:AddCondition(Priest.IsRenew)
    event:AddAction(Priest.CastRenew)
end

--CUSTOM_CODE
function Trig_Battle_Actions()
        BattleSystem.Init()
end

function InitTrig_Battle()
    gg_trg_Battle = CreateTrigger()
    TriggerAddAction(gg_trg_Battle, Trig_Battle_Actions)
end

function Trig_Init_LordMarrowgar_Actions()
        LordMarrowgar.Init()
end

function InitTrig_Init_LordMarrowgar()
    gg_trg_Init_LordMarrowgar = CreateTrigger()
    TriggerAddAction(gg_trg_Init_LordMarrowgar, Trig_Init_LordMarrowgar_Actions)
end

function Trig_Init_LadyDeathwhisper_Actions()
        LadyDeathwhisper.Init()
end

function InitTrig_Init_LadyDeathwhisper()
    gg_trg_Init_LadyDeathwhisper = CreateTrigger()
    TriggerAddAction(gg_trg_Init_LadyDeathwhisper, Trig_Init_LadyDeathwhisper_Actions)
end

function Trig_Init_Priest_Actions()
        Priest.Init()
end

function InitTrig_Init_Priest()
    gg_trg_Init_Priest = CreateTrigger()
    TriggerAddAction(gg_trg_Init_Priest, Trig_Init_Priest_Actions)
end

function Trig_Init_Paladin_Actions()
        Paladin.Init()
end

function InitTrig_Init_Paladin()
    gg_trg_Init_Paladin = CreateTrigger()
    TriggerAddAction(gg_trg_Init_Paladin, Trig_Init_Paladin_Actions)
end

function Trig_INIT_Actions()
    udg_My_type[1] = 0
    udg_My_x[1] = 0.00
    udg_My_y[1] = 0.00
    TriggerSleepAction(0.00)
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_166")
    ForceAddPlayerSimple(Player(1), bj_FORCE_PLAYER[0])
    SetForceAllianceStateBJ(GetPlayersByMapControl(MAP_CONTROL_USER), GetPlayersByMapControl(MAP_CONTROL_USER), bj_ALLIANCE_ALLIED)
    SetForceAllianceStateBJ(bj_FORCE_PLAYER[0], bj_FORCE_PLAYER[0], bj_ALLIANCE_ALLIED)
end

function InitTrig_INIT()
    gg_trg_INIT = CreateTrigger()
    TriggerAddAction(gg_trg_INIT, Trig_INIT_Actions)
end

function Trig_UNIT_DEATH_Actions()
        UnitsRespawn()
        BuffSystem.RemoveAllBuffs(GetTriggerUnit())
end

function InitTrig_UNIT_DEATH()
    gg_trg_UNIT_DEATH = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_UNIT_DEATH, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddAction(gg_trg_UNIT_DEATH, Trig_UNIT_DEATH_Actions)
end

function Trig_Cmd_new_Conditions()
    if (not (udg_My_hero[GetConvertedPlayerId(GetTriggerPlayer())] == nil)) then
        return false
    end
    return true
end

function Trig_Cmd_new_Actions()
    CreateNUnitsAtLoc(1, FourCC("Hpal"), GetTriggerPlayer(), GetRectCenter(gg_rct_RespawZone), GetRandomDirectionDeg())
    udg_My_hero[GetConvertedPlayerId(GetTriggerPlayer())] = GetLastCreatedUnit()
        AddHeroAbilities()
end

function InitTrig_Cmd_new()
    gg_trg_Cmd_new = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_Cmd_new, Player(0), "-new", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Cmd_new, Player(1), "-new", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Cmd_new, Player(2), "-new", true)
    TriggerAddCondition(gg_trg_Cmd_new, Condition(Trig_Cmd_new_Conditions))
    TriggerAddAction(gg_trg_Cmd_new, Trig_Cmd_new_Actions)
end

function Trig_Init_Actions()
        udg_SaveUnit_gamecache = InitGameCache("cache")
    udg_SaveUnit_bool = true
    udg_SaveUnit_data[1] = 0
    udg_SaveUnit_g1 = 0
    udg_SaveUnit_g2 = 0
    udg_SaveUnit_gamecache = udg_SaveUnit_gamecache
    udg_SaveUnit_unit = nil
    udg_SaveUnit_user_data[1] = 0
    udg_SaveUnit_author = 1546
    udg_SaveUnit_directory = "test"
    udg_SaveUnit_map_number = 1
    udg_SaveUnit_x = 4100.00
    udg_SaveUnit_y = -3080.00
end

function InitTrig_Init()
    gg_trg_Init = CreateTrigger()
    TriggerAddAction(gg_trg_Init, Trig_Init_Actions)
end

function Trig_Save_unit_hero_ability_Actions()
        HeroAbilities()
end

function InitTrig_Save_unit_hero_ability()
    gg_trg_Save_unit_hero_ability = CreateTrigger()
    TriggerAddAction(gg_trg_Save_unit_hero_ability, Trig_Save_unit_hero_ability_Actions)
end

function Trig_SaveUnit_load_Conditions()
    if (not (udg_My_hero[GetConvertedPlayerId(GetTriggerPlayer())] == nil)) then
        return false
    end
    return true
end

function Trig_SaveUnit_load_Actions()
        local i = GetConvertedPlayerId(GetTriggerPlayer())
        Load()
        udg_My_index = i
    udg_My_hero[udg_My_index] = udg_SaveUnit_unit
end

function InitTrig_SaveUnit_load()
    gg_trg_SaveUnit_load = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_SaveUnit_load, Player(0), "-load", false)
    TriggerRegisterPlayerChatEvent(gg_trg_SaveUnit_load, Player(1), "-load", false)
    TriggerRegisterPlayerChatEvent(gg_trg_SaveUnit_load, Player(2), "-load", false)
    TriggerAddCondition(gg_trg_SaveUnit_load, Condition(Trig_SaveUnit_load_Conditions))
    TriggerAddAction(gg_trg_SaveUnit_load, Trig_SaveUnit_load_Actions)
end

function Trig_SaveUnit_save_Actions()
    udg_SaveUnit_unit = udg_My_hero[GetConvertedPlayerId(GetTriggerPlayer())]
    udg_SaveUnit_user_data[1] = 1
        Save()
end

function InitTrig_SaveUnit_save()
    gg_trg_SaveUnit_save = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_SaveUnit_save, Player(0), "-save", false)
    TriggerRegisterPlayerChatEvent(gg_trg_SaveUnit_save, Player(1), "-save", false)
    TriggerRegisterPlayerChatEvent(gg_trg_SaveUnit_save, Player(2), "-save", false)
    TriggerAddAction(gg_trg_SaveUnit_save, Trig_SaveUnit_save_Actions)
end

function InitCustomTriggers()
    InitTrig_Battle()
    InitTrig_Init_LordMarrowgar()
    InitTrig_Init_LadyDeathwhisper()
    InitTrig_Init_Priest()
    InitTrig_Init_Paladin()
    InitTrig_INIT()
    InitTrig_UNIT_DEATH()
    InitTrig_Cmd_new()
    InitTrig_Init()
    InitTrig_Save_unit_hero_ability()
    InitTrig_SaveUnit_load()
    InitTrig_SaveUnit_save()
end

function RunInitializationTriggers()
    ConditionalTriggerExecute(gg_trg_Battle)
    ConditionalTriggerExecute(gg_trg_Init_LordMarrowgar)
    ConditionalTriggerExecute(gg_trg_Init_LadyDeathwhisper)
    ConditionalTriggerExecute(gg_trg_Init_Priest)
    ConditionalTriggerExecute(gg_trg_Init_Paladin)
    ConditionalTriggerExecute(gg_trg_INIT)
    ConditionalTriggerExecute(gg_trg_Init)
    ConditionalTriggerExecute(gg_trg_Save_unit_hero_ability)
end

function InitCustomPlayerSlots()
    SetPlayerStartLocation(Player(0), 0)
    SetPlayerColor(Player(0), ConvertPlayerColor(0))
    SetPlayerRacePreference(Player(0), RACE_PREF_RANDOM)
    SetPlayerRaceSelectable(Player(0), true)
    SetPlayerController(Player(0), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(1), 1)
    SetPlayerColor(Player(1), ConvertPlayerColor(1))
    SetPlayerRacePreference(Player(1), RACE_PREF_RANDOM)
    SetPlayerRaceSelectable(Player(1), true)
    SetPlayerController(Player(1), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(2), 2)
    SetPlayerColor(Player(2), ConvertPlayerColor(2))
    SetPlayerRacePreference(Player(2), RACE_PREF_RANDOM)
    SetPlayerRaceSelectable(Player(2), true)
    SetPlayerController(Player(2), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(10), 3)
    ForcePlayerStartLocation(Player(10), 3)
    SetPlayerColor(Player(10), ConvertPlayerColor(10))
    SetPlayerRacePreference(Player(10), RACE_PREF_UNDEAD)
    SetPlayerRaceSelectable(Player(10), false)
    SetPlayerController(Player(10), MAP_CONTROL_COMPUTER)
end

function InitCustomTeams()
    SetPlayerTeam(Player(0), 0)
    SetPlayerState(Player(0), PLAYER_STATE_ALLIED_VICTORY, 1)
    SetPlayerTeam(Player(1), 0)
    SetPlayerState(Player(1), PLAYER_STATE_ALLIED_VICTORY, 1)
    SetPlayerTeam(Player(2), 0)
    SetPlayerState(Player(2), PLAYER_STATE_ALLIED_VICTORY, 1)
    SetPlayerAllianceStateAllyBJ(Player(0), Player(1), true)
    SetPlayerAllianceStateAllyBJ(Player(0), Player(2), true)
    SetPlayerAllianceStateAllyBJ(Player(1), Player(0), true)
    SetPlayerAllianceStateAllyBJ(Player(1), Player(2), true)
    SetPlayerAllianceStateAllyBJ(Player(2), Player(0), true)
    SetPlayerAllianceStateAllyBJ(Player(2), Player(1), true)
    SetPlayerAllianceStateVisionBJ(Player(0), Player(1), true)
    SetPlayerAllianceStateVisionBJ(Player(0), Player(2), true)
    SetPlayerAllianceStateVisionBJ(Player(1), Player(0), true)
    SetPlayerAllianceStateVisionBJ(Player(1), Player(2), true)
    SetPlayerAllianceStateVisionBJ(Player(2), Player(0), true)
    SetPlayerAllianceStateVisionBJ(Player(2), Player(1), true)
    SetPlayerTeam(Player(10), 1)
end

function InitAllyPriorities()
    SetStartLocPrioCount(0, 2)
    SetStartLocPrio(0, 0, 1, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(0, 1, 2, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(1, 2)
    SetStartLocPrio(1, 0, 0, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(1, 1, 2, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(2, 2)
    SetStartLocPrio(2, 0, 0, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(2, 1, 1, MAP_LOC_PRIO_HIGH)
end

function main()
    SetCameraBounds(2048.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), -9216.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM), 6144.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), 2048.0 - GetCameraMargin(CAMERA_MARGIN_TOP), 2048.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), 2048.0 - GetCameraMargin(CAMERA_MARGIN_TOP), 6144.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), -9216.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM))
    SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl", "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
    NewSoundEnvironment("Default")
    SetAmbientDaySound("IceCrownDay")
    SetAmbientNightSound("IceCrownNight")
    SetMapMusic("Music", true, 0)
    CreateRegions()
    CreateAllUnits()
    InitBlizzard()
    InitGlobals()
    InitCustomTriggers()
    RunInitializationTriggers()
end

function config()
    SetMapName("TRIGSTR_003")
    SetMapDescription("TRIGSTR_005")
    SetPlayers(4)
    SetTeams(4)
    SetGamePlacement(MAP_PLACEMENT_TEAMS_TOGETHER)
    DefineStartLocation(0, 4096.0, 192.0)
    DefineStartLocation(1, 6912.0, -9216.0)
    DefineStartLocation(2, 6912.0, -9216.0)
    DefineStartLocation(3, 6912.0, -9216.0)
    InitCustomPlayerSlots()
    InitCustomTeams()
    InitAllyPriorities()
end

