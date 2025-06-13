---@author meiso

---@class BuffSystem
BuffSystem = {
    ---@type table<Unit, table[Buff]>
    buffs = {},
    ---@type Frame
    main_frame_buff = nil,
    ---@type Frame
    main_frame_debuff = nil,
    ---@type Logger
    logger = Logger("buffsys"),
}

function BuffSystem.LoadFrame()
    BuffSystem.logger:Info("Initialize BuffSystem")

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
---@param hero Unit Экземпляр класса Unit
---@return nil
function BuffSystem.RegisterHero(hero)
    BuffSystem.logger:Info("Register hero", hero:GetName())
    if BuffSystem.IsHeroInSystem(hero) then
        BuffSystem.logger:Info(hero:GetName(), "already registered")
        return
    end
    BuffSystem.buffs[hero] = {}
    BuffSystem.logger:Info(hero:GetName(), "successfully added")
end

--- Добавляет герою баф
---@param hero Unit Экземпляр класса Unit
---@param buff Ability Название бафа
---@param func function Функция, снимающая баф
---@param is_debuff boolean Является баф дебафом
---@return nil
function BuffSystem.AddBuffToHero(hero, buff, func, is_debuff)
    BuffSystem.logger:Info("Add a", buff.tooltip, "to", hero:GetName())

    if BuffSystem.IsBuffOnHero(hero, buff) then
        BuffSystem.logger:Info(buff.tooltip, "is already on", hero:GetName())
        return
    end

    table.insert(BuffSystem.buffs[hero], Buff(buff, func, Frame("BSIconTemp"), is_debuff))

    BuffSystem.CheckingBuffsExceptions(hero, buff)
    if is_debuff then
        BuffSystem.logger:Info("Show debuff frame...")
        BuffSystem.main_frame_debuff:Show()
        BuffSystem._ShowDebuffs(hero)
        BuffSystem.logger:Info("...ok")
    else
        BuffSystem.logger:Info("Show buff frame...")
        BuffSystem.main_frame_buff:Show()
        BuffSystem._ShowBuffs(hero)
        BuffSystem.logger:Info("...ok")
    end
end

--- Проверяет есть ли герой в системе бафов
---@param hero Unit Экземпляр класса Unit
---@return boolean
function BuffSystem.IsHeroInSystem(hero)
    BuffSystem.logger:Info("Checking for a hero in the system...")
    for name, _ in pairs(BuffSystem.buffs) do
        if name == hero then
            BuffSystem.logger:Info("...founded")
            return true
        end
    end
    BuffSystem.logger:Info("...not found")
    return false
end

--- Проверяет есть ли на герое баф
---@param hero Unit Экземпляр класса Unit
---@param buff Ability Название бафа
---@return boolean
function BuffSystem.IsBuffOnHero(hero, buff)
    BuffSystem.logger:Info("Check the", buff.tooltip, "on", hero:GetName())
    if not BuffSystem.IsHeroInSystem(hero) then
        BuffSystem.logger:Info(hero:GetName(), "is not registered")
        return false
    end
    if #BuffSystem.buffs[hero] == 0 then
        BuffSystem.logger:Info("No buffs")
        return false
    end
    BuffSystem.CheckingBuffsExceptions(hero, buff)
    for i = 1, #BuffSystem.buffs[hero] do
        local b = BuffSystem._getBuff(hero, i)
        if b == nil then
            BuffSystem.logger:Info("Not found buff")
            return false
        end
        BuffSystem.logger:Info("checking", b.buff.tooltip, "...")
        if BuffSystem._getBuff(hero, i):IsBuff(buff) or
                BuffSystem._getBuff(hero, i):IsDebuff(buff) then
            BuffSystem.logger:Info("buff on hero")
            return true
        end
    end
    BuffSystem.logger:Info("There's nothing")
    return false
end

--- Удаляет у героя баф
---@param hero Unit Экземпляр класса Unit
---@param buff Ability Название бафа
---@return nil
function BuffSystem.RemoveBuffFromHero(hero, buff)
    BuffSystem.logger:Info("Remove", buff.tooltip, "from", hero:GetName())
    for i = 1, #BuffSystem.buffs[hero] do
        if BuffSystem._getBuff(hero, i):IsBuff(buff) or
                BuffSystem._getBuff(hero, i):IsDebuff(buff) then
            BuffSystem._getBuff(hero, i).frame:Destroy()
            BuffSystem.buffs[hero][i] = nil
        end
    end
    BuffSystem._ShowBuffs(hero)
    BuffSystem._ShowDebuffs(hero)
    BuffSystem.logger:Info("Remove successfully")
end

--- Использует функцию для удаления бафа
---@param hero Unit Экземпляр класса Unit
---@param buff ability Название бафа
---@return nil
function BuffSystem.RemoveBuffFromHeroByFunc(hero, buff)
    BuffSystem.logger:Info("Remove", buff.tooltip, "from", hero:GetName(), "by func")
    for i = 1, #BuffSystem.buffs[hero] do
        if BuffSystem.buffs[hero][i] == nil then
            return
        end

        if BuffSystem._getBuff(hero, i):IsBuff(buff) or
                BuffSystem._getBuff(hero, i):IsDebuff(buff) then
            BuffSystem._getBuff(hero, i).frame:Destroy()
            BuffSystem._getBuff(hero, i).func()
            BuffSystem.buffs[hero][i] = nil
        end
    end
    BuffSystem._ShowBuffs(hero)
    BuffSystem._ShowDebuffs(hero)
    BuffSystem.logger:Info("Remove successfully")
end

--- Проверяет относится ли баф к группе однотипных бафов
---@param hero Unit Экземпляр класса Unit
---@param buff Ability Название бафа
---@return nil
function BuffSystem.CheckingBuffsExceptions(hero, buff)
    BuffSystem.logger:Info("Check buffs exceptions")
    local buffs_exceptions = {
        paladin = {
            Spells.paladin.blessing_of_kings,
            Spells.paladin.blessing_of_wisdom,
            Spells.paladin.blessing_of_sanctuary,
            Spells.paladin.blessing_of_might
        },
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
---@param hero Unit Экземпляр класса Unit
---@return nil
function BuffSystem.RemoveAllBuffs(hero)
    for i = 1, #BuffSystem.buffs[hero] do
        BuffSystem.RemoveBuffFromHeroByFunc(hero, BuffSystem._getBuff(hero, i).buff)
    end
end

--- Удалить баф со всех юнитов
---@param buff Ability Название бафа
---@return nil
function BuffSystem.RemoveBuffFromUnits(buff)
    for u, _ in pairs(BuffSystem.buffs) do
        for i = 1, #BuffSystem.buffs[u] do
            if BuffSystem._getBuff(u, i) == nil then
                return
            end
            if BuffSystem._getBuff(u, i):IsBuff(buff) or
                    BuffSystem._getBuff(u, i):IsDebuff(buff) then
                BuffSystem._getBuff(u, i).frame:Destroy()
                BuffSystem.buffs[u][i] = nil
            end
        end
        BuffSystem._ShowBuffs(u)
        BuffSystem._ShowDebuffs(u)
    end
end

--- Удаляет героя из системы бафов
---@param hero Unit Экземпляр класса Unit
---@return nil
function BuffSystem.RemoveHero(hero)
    BuffSystem.logger:Info("Remove", hero:GetName(), "from system")
    --TODO: корректно удалять все бафы и фреймы!!
    BuffSystem.buffs[hero] = nil
end

--- Усилить воздействие способности на цель в зависимости от наличия определенного бафа
---@param hero Unit Юнит, на которого воздействуют спеллом
---@param value integer Количество урона/исцеления воздействующее на цель
---@return real
function BuffSystem.ImproveSpell(hero, value)
    local improving_buffs = {
        Spells.priest.guardian_spirit,
    }
    if not BuffSystem.IsHeroInSystem(hero) then
        return value
    end
    for i = 1, #BuffSystem.buffs[hero] do
        for _, buff in pairs(improving_buffs) do
            if BuffSystem._getBuff(hero, i) == nil then
                return value
            end
            if BuffSystem._getBuff(hero, i):IsBuff(buff) then
                return value * 1.4
            end
        end
    end
    return value
end

--- Расширяет основной фрейм с бафа/дебафами
---@private
function BuffSystem._ResizeMainFrame(main_frame, icon_frame, count)
    BuffSystem.logger:Info("Resize main frame...")
    --расположение иконки бафа по X
    --расстояние между иконками + суммарный размер всех иконок + граница справа от фона
    local x = 0.005 + (count * icon_frame:GetWidth()) + (0.0025 * count)
    --на сколько расширить фон
    --(ширина иконки * 2 + расстояние между иконками) * количество всех бафов
    local _add = (icon_frame:GetWidth() * 2 + 0.005) * count
    --0.03 - базовая ширина фона
    main_frame:SetWidth(0.03 + _add)
    icon_frame:SetPoint(FRAMEPOINT_LEFT, main_frame, FRAMEPOINT_LEFT, x, 0.0)
    BuffSystem.logger:Info("...resized")
end

--- Задать иконку бафу
---@private
function BuffSystem._SetIcon(icon)
    BuffSystem.logger:Info("Set icon")
    local buff_icon = Frame(Frame:GetFrameByName("BSIcon"))
    buff_icon:SetTexture(icon)
end

---@private
---@param u Unit Id юнита
function BuffSystem._ShowBuffs(u)
    BuffSystem.logger:Debug("_ShowBuffs start")
    local count = 0
    BuffSystem.logger:Info("buff count", tostring(#BuffSystem.buffs[u]))
    for i = 1, #BuffSystem.buffs[u] do
        local buff = BuffSystem._getBuff(u, i)
        if buff and not buff.is_debuff then
            count = count + 1
            BuffSystem.logger:Info("buff", buff.buff.tooltip)
            BuffSystem.logger:Info("icon", buff.buff.icon)
            BuffSystem._ResizeMainFrame(
                    BuffSystem.main_frame_buff,
                    buff.frame,
                    count - 1
            )
            BuffSystem._SetIcon(buff.buff.icon)
            BuffSystem.logger:Info("Set tooltip")
            buff.frame:SetTooltip(buff.buff.buff_tooltip, buff.buff.buff_desc)
        end
    end
    if count == 0 then
        BuffSystem.main_frame_buff:Hide()
    end
    BuffSystem.logger:Debug("_ShowBuffs end")
end

---@private
---@param u Unit Id юнита
function BuffSystem._ShowDebuffs(u)
    BuffSystem.logger:Debug("_ShowDebuffs start")
    local count = 0
    BuffSystem.logger:Info("debuff count", tostring(#BuffSystem.buffs[u]))
    for i = 1, #BuffSystem.buffs[u] do
        local debuff = BuffSystem._getBuff(u, i)
        if debuff and debuff.is_debuff then
            count = count + 1
            BuffSystem.logger:Info("debuff", debuff.buff.tooltip)
            BuffSystem.logger:Info("icon", debuff.buff.icon)
            BuffSystem._ResizeMainFrame(
                    BuffSystem.main_frame_debuff,
                    debuff.frame,
                    count - 1
            )
            BuffSystem._SetIcon(debuff.buff.icon)
            BuffSystem.logger:Info("Set tooltip")
            debuff.frame:SetTooltip(debuff.buff.buff_tooltip, debuff.buff.buff_desc)
        end
    end
    if count == 0 then
        BuffSystem.main_frame_debuff:Hide()
    end
    BuffSystem.logger:Debug("_ShowDebuffs end")
end

--- Возвращает баф юнита
---@private
---@param u Unit Юнит
---@param i number Индекс бафа
---@return Buff
function BuffSystem._getBuff(u, i)
    return BuffSystem.buffs[u][i]
end
