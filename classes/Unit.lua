
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
    local face_ = face or 0
    self.unit = CreateUnit(player, unit_id, x, y, face_)
end

--- Нанести физический урон.
--- Урон снижает как от количества, так и от типа защиты
function Unit:DealPhysicalDamage(target, damage, attack_type)
    local t = attack_type or ATTACK_TYPE_MELEE
    local u = target
    if type(target) == "table" then u = target:GetUnit() end
    UnitDamageTargetBJ(self.unit, u, damage, t, DAMAGE_TYPE_NORMAL)
end

--- Нанести физический урон, проходящий через защиту.
--- Урон снижается только от типа защиты
function Unit:DealUniversalDamage(target, damage, attack_type)
    local t = attack_type or ATTACK_TYPE_MELEE
    local u = target
    if type(target) == "table" then u = target:GetUnit() end
    UnitDamageTargetBJ(self.unit, u, damage, t, DAMAGE_TYPE_UNIVERSAL)
end

--- Нанести магической урон.
--- Урон снижается "сопротивлением от магии"
function Unit:DealMagicDamage(target, damage)
    local u = target
    if type(target) == "table" then u = target:GetUnit() end
    UnitDamageTargetBJ(self.unit, u, damage, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC)
end

--- Нанести магический урон, проходящий через иммунитет к магии.
--- Урон игнорирует иммунитет к магии, но снижается "сопротивляемостью к магии"
function Unit:DealUniversalMagicDamage(target, damage)
    local u = target
    if type(target) == "table" then u = target:GetUnit() end
    UnitDamageTargetBJ(self.unit, u, damage, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL)
end

--- Нанести смешанный урон.
--- Урон снижается и от защиты, и от сопротивления к магии
function Unit:DealMixedDamage(target, damage)
    local u = target
    if type(target) == "table" then u = target:GetUnit() end
    UnitDamageTargetBJ(self.unit, u, damage, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL)
end

--- Нанести чистый урон.
--- Не снижается защитой
function Unit:DealCleanDamage(target, damage)
    local u = target
    if type(target) == "table" then u = target:GetUnit() end
    UnitDamageTargetBJ(self.unit, u, damage, ATTACK_TYPE_CHAOS, DAMAGE_TYPE_UNIVERSAL)
end

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

--- Установить уровень юнита
function Unit:SetLevel(lvl)
    SetHeroLevel(self.unit, lvl, false)
end

--- Потратить указанное количество маны
---@param mana real
---@param percent real
---@param check boolean Проверять ли текущее количество маны
---@return boolean
function Unit:LoseMana(arg)
    local m = self:GetPercentManaOfMax(arg.percent) or arg.mana
    if arg.check == nil then arg.check = true end
    if m > self:GetCurrentMana() and arg.check then
        --TODO: печатать отдельно игроку
        print("Недостаточно маны")
        return false
    end
    self:SetMana(self:GetCurrentMana() - m)
    return true
end

--- Потратить указанное количество хп
---@param life real
---@param percent real
function Unit:LoseLife(arg)
    local l = self:GetPercentLifeOfMax(arg.percent) or arg.life
    self:SetLife(self:GetCurrentLife() - l)
end

--- Получить ману количественно или в процентах от максимума
---@param mana real
---@param percent real
function Unit:GainMana(arg)
    local m = self:GetPercentManaOfMax(arg.percent) or arg.mana
    self:SetMana(self:GetCurrentMana() + m)
end

--- Получить хп количественно или в процентах от максимума
---@param life real
---@param percent real
function Unit:GainLife(arg)
    local l = self:GetPercentLifeOfMax(arg.percent) or arg.life
    self:SetLife(self:GetCurrentLife() + l)
end

--- Получить процент маны от максимума
---@param percent real
---@return real
function Unit:GetPercentManaOfMax(percent)
    if percent == nil then return nil end
    return GetUnitState(self.unit, UNIT_STATE_MAX_MANA) * (percent / 100)
end

--- Получить процент хп от максимума
---@param percent real
---@return real
function Unit:GetPercentLifeOfMax(percent)
    if percent == nil then return nil end
    return GetUnitState(self.unit, UNIT_STATE_MAX_LIFE) * (percent / 100)
end

--- Установить текущее количество маны
---@param value real
function Unit:SetMana(value)
    SetUnitState(self.unit, UNIT_STATE_MANA, value)
end

--- Установить текущее количество хп
---@param value real
function Unit:SetLife(value)
    SetUnitState(self.unit, UNIT_STATE_LIFE, value)
end

--- Получить текущее количество маны юнита
---@return real
function Unit:GetCurrentMana()
    return GetUnitState(self.unit, UNIT_STATE_MANA)
end

--- Получить текущее количество хп юнита
---@return real
function Unit:GetCurrentLife()
    return GetUnitState(self.unit, UNIT_STATE_LIFE)
end

--- Вернуть ближайших врагов
---@param radius real Радиус, в котором выбираются враги. Необязательный аргумент
---@return group
function Unit:GetNearbyEnemies(radius, filter)
    local group = CreateGroup()
    local r = radius or 500
    local location = self:GetLoc()
    local f = Condition(filter) or nil
    GroupEnumUnitsInRangeOfLoc(group, location, r, f)
    DestroyBoolExpr(f)
    return group
end

--- Получить текущее местоположение юнита
---@return location
function Unit:GetLoc()
    return GetUnitLoc(self.unit)
end

--- Проверяет мертв ли юнит
---@return boolean
function Unit:IsDied()
    return GetDyingUnit() == self.unit
end

--- Получить идентификатор созданного юнита
---@return unitid
function Unit:GetUnit()
    return self.unit
end

--- Получить игрока, владеющего юнитом
function Unit:GetOwner()
    return GetOwningPlayer(self.unit)
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

--- Удалить юнита
function Unit:Remove()
    RemoveUnit(self.unit)
end
