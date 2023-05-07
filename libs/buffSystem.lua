-- Copyright (c)  meiso

BuffSystem = {
    --- Таблица содержащая всех героев с бафами
    ---Формат:
    ---{ unit = { buff, debuff, func, frame } }
    buffs = {},
    debuffs = {},
    main_frame_buff = nil,
}

function BuffSystem.LoadFrame()
    BuffSystem.main_frame_buff = Frame("BSBuff")
    BuffSystem.main_frame_buff:SetAbsPoint(FRAMEPOINT_CENTER, 0., 0.18)
    BuffSystem.main_frame_buff:Hide()
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
        table.insert(BuffSystem.buffs[u], { buff_ = "", debuff_ = buff, func_ = func })
    else
        table.insert(BuffSystem.buffs[u], { buff_ = buff, debuff_ = "", func_ = func })
    end
    BuffSystem.CheckingBuffsExceptions(hero, buff)
    BuffSystem.main_frame_buff:Show()
    if is_debuff then
        BuffSystem._SetDebuffToFrame()
    else
        BuffSystem._SetBuffToFrame(u)
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
function BuffSystem.RemoveBuffToHero(hero, buff)
    if isTable(hero) then hero = hero:GetId() end
    local u = I2S(GetHandleId(hero))
    for i = 1, #BuffSystem.buffs[u] do
        if BuffSystem.buffs[u][i].buff_ == buff or
                BuffSystem.buffs[u][i].debuff_ == buff then
            BuffSystem.buffs[u][i] = nil
        end
    end
end

--- Использует лямбда-функцию для удаления бафа
---@param hero unit Id героя
---@param buff ability Название бафа
---@return nil
function BuffSystem.RemoveBuffToHeroByFunc(hero, buff)
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

--- Проверят относится ли баф к группе однотипных бафов
---@param hero unit Юнит
---@param buff ability Название бафа
---@return nil
function BuffSystem.CheckingBuffsExceptions(hero, buff)
    if isTable(hero) then hero = hero:GetId() end
    local buffs_exceptions = {
        paladin = { BLESSING_OF_KINGS, BLESSING_OF_WISDOM, BLESSING_OF_SANCTUARY, BLESSING_OF_MIGHT },
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
            BuffSystem.RemoveBuffToHeroByFunc(hero, buff_)
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
        BuffSystem.RemoveBuffToHeroByFunc(hero, BuffSystem.buffs[u][i].buff_)
        BuffSystem.RemoveBuffToHeroByFunc(hero, BuffSystem.buffs[u][i].debuff_)
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
                BuffSystem.buffs[unit][i] = nil
            end
        end
    end
end

--- Удаляет героя из системы бафов
---@param hero unit Id героя
---@return nil
function BuffSystem.RemoveHero(hero)
    if isTable(hero) then hero = hero:GetId() end
    local u = I2S(GetHandleId(hero))
    BuffSystem.buffs[u] = nil
end

--- Усилить воздействие способности на цель взависимости от наличия определенного бафа
---@param hero unit Юнит, на которого воздействуют спеллом
---@param value integer Количество урона/исцеления воздействующее на цель
---@return real
function BuffSystem.ImproveSpell(hero, value)
    if isTable(hero) then hero = hero:GetId() end
    local improving_buffs = {
        GUARDIAN_SPIRIT,
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

function BuffSystem._SetBuffToFrame(u)
    local frame = Frame("BSIconTemp")
    local count = 0
    for i = 1, #BuffSystem.buffs[u] do
        if BuffSystem.buffs[u][i].buff_ ~= "" then
            count = count + 1
        end
    end
    count = count - 1
    --расположение иконки бафа по X
    --расстояние между иконками + суммарный размер всех иконок + граница справа от фона
    local x = 0.005 + (count * frame:GetWidth()) + (0.0025 * count)
    --на сколько расширить фон
    --(ширина иконки * 2 + расстояние между иконками) * количество всех бафов
    local _add = (frame:GetWidth() * 2 + 0.005) * count
    --0.06 - размер фона ровно на одну иконку
    BuffSystem.main_frame_buff:SetWidth(0.06 + _add)
    frame:SetPoint(FRAMEPOINT_LEFT, BuffSystem.main_frame_buff, FRAMEPOINT_LEFT, x, 0.0)
    local buff_icon = Frame(Frame:GetFrameByName("BSIcon"))
    buff_icon:SetTexture(blessing_of_kings_tex)
end

function BuffSystem._SetDebuffToFrame()

end
