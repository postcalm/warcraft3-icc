---@author meiso

---@class Unit Класс создания юнита
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

-- Характеристики

--- Выставить базовый урон
---@param value integer Урон
---@param index integer Номер атаки. 0 (первая) или 1 (вторая)
---@return nil
function Unit:SetBaseDamage(value, index)
    local i = index or 0
    BlzSetUnitBaseDamage(self.unit, value, i)
end

--- Получить базовый урон
---@param index integer Номер атаки. 0 (первая) или 1 (вторая)
---@return integer
function Unit:GetBaseDamage(index)
    index = index or 0
    return BlzGetUnitBaseDamage(self.unit, index)
end

--- Добавить брони
---@param armor real Количество брони в абсолютных величинах
---@return nil
function Unit:AddArmor(armor)
    BlzSetUnitArmor(self.unit, self:GetArmor() + armor)
end

--- Установить значение брони
---@param armor real Количество брони в абсолютных величинах
---@return nil
function Unit:SetArmor(armor)
    BlzSetUnitArmor(self.unit, armor)
end

--- Получить текущее значение брони
---@return integer
function Unit:GetArmor()
    return BlzGetUnitArmor(self.unit)
end

--- Добавить силы
---@param value integer Значение силы
---@param permanent boolean Перманентно
---@return nil
function Unit:AddStr(value, permanent)
    permanent = permanent or false
    self:SetStr(self:GetStr() + value, permanent)
end

--- Добавить ловкости
---@param value integer Значение ловкости
---@param permanent boolean Перманентно
---@return nil
function Unit:AddAgi(value, permanent)
    permanent = permanent or false
    self:SetAgi(self:GetAgi() + value, permanent)
end

--- Добавить интеллекта
---@param value integer Значение интеллекта
---@param permanent boolean Перманентно
---@return nil
function Unit:AddInt(value, permanent)
    permanent = permanent or false
    self:SetInt(self:GetInt() + value, permanent)
end

--- Задать значение силы
---@param value integer Значение силы
---@param permanent boolean Перманентно
---@return nil
function Unit:SetStr(value, permanent)
    permanent = permanent or false
    SetHeroStr(self.unit, value, permanent)
end

--- Задать значение ловкости
---@param value integer Значение ловкости
---@param permanent boolean Перманентно
---@return nil
function Unit:SetAgi(value, permanent)
    permanent = permanent or false
    SetHeroAgi(self.unit, value, permanent)
end

--- Задать значение интеллекта
---@param value integer Значение интеллекта
---@param permanent boolean Перманентно
---@return nil
function Unit:SetInt(value, permanent)
    permanent = permanent or false
    SetHeroInt(self.unit, value, permanent)
end

--- Получить текущее значение силы
---@param include_bonuses boolean Учитывать ли бонусы
---@return integer
function Unit:GetStr(include_bonuses)
    include_bonuses = include_bonuses or false
    return GetHeroStr(self.unit, include_bonuses)
end

--- Получить текущее значение ловкости
---@param include_bonuses boolean Учитывать ли бонусы
---@return integer
function Unit:GetAgi(include_bonuses)
    include_bonuses = include_bonuses or false
    return GetHeroAgi(self.unit, include_bonuses)
end

--- Получить текущее значение интеллекта
---@param include_bonuses boolean Учитывать ли бонусы
---@return integer
function Unit:GetInt(include_bonuses)
    include_bonuses = include_bonuses or false
    return GetHeroInt(self.unit, include_bonuses)
end

-- Всё, что связано с нанесением урона

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
    local abilities = ...
    if type(...) ~= "table" then
        abilities = table.pack(...)
    end
    for _, ability in ipairs(abilities) do
        if isTable(ability) then
            ability = ability:GetId()
        end
        UnitAddAbility(self.unit, ability)
    end
end

--- Удалить у юнита указанные способности
---@param ability ability Список способностей (через запятую)
---@return nil
function Unit:RemoveAbilities(...)
    local abilities = ...
    if type(...) ~= "table" then
        abilities = table.pack(...)
    end
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
---@param ability string Строковое ID способности
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

--- Отключить способность
---@param ability ability Идентификатор способности
---@return nil
function Unit:DisableAbility(ability)
    BlzUnitDisableAbility(self.unit, ability, true, false)
end

--- Активировать способность
---@param ability ability Идентификатор способности
---@return nil
function Unit:EnableAbility(ability)
    BlzUnitDisableAbility(self.unit, ability, false, false)
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
---@param name string Имя юнита
---@return nil
function Unit:SetName(name)
    if self:IsHero() then
        BlzSetHeroProperName(self.unit, name)
    else
        BlzSetUnitName(self.unit, name)
    end
end

--- Получить имя юнита
---@return string
function Unit:GetName()
    if self:IsHero() then
        return GetHeroProperName(self.unit)
    end
    return GetUnitName(self.unit)
end

--- Активировать/деактивировать юнита
---@param flag boolean true or false
---@return nil
function Unit:Pause(flag)
    PauseUnit(self.unit, flag)
end

--- Отобразить юнита
---@return nil
function Unit:Show()
    ShowUnitShow(self.unit)
end

--- Скрыть юнита
---@return nil
function Unit:Hide()
    ShowUnitHide(self.unit)
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
