---@author meiso

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
            BuffSystem.buffs[u][i].frame_:Destroy()
            BuffSystem.main_frame_buff:Destroy()
            BuffSystem.main_frame_debuff:Destroy()
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

--- Расширяет основной фрейм с бафа/дебафами
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
