---@author meiso

--- Система отслеживания положительных и отрицательных эффектов.
--- Снизу по краям отрисовываются основные фреймы, в которых отрисовываются
--- иконки положительных (слева) и отрицательных (справа) эффектов.
--- Изначально основные фреймы скрыты и появляются только при наложении эффектов.
--- Основные фреймы расширяются в зависимости от количества соответствующих эффектов.

---@class BuffSystem
BuffSystem = {
    ---@type table<integer<Unit, table[Buff]>>
    buffs = {},
    ---@type Frame
    main_frame_buff = nil,
    ---@type Frame
    main_frame_debuff = nil,
    ---@type Logger
    logger = Logger("buffsys"),
}

--- Инициализирует фрейм
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
    BuffSystem._AddHero(hero)
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

    BuffSystem.CheckingBuffsExceptions(hero, buff)

    BuffSystem._AddBuff(hero, Buff(buff, func, Frame("BSIconTemp"), is_debuff))

    if is_debuff then
        BuffSystem.logger:Info("Show debuff frame...")
        if BuffSystem.main_frame_debuff ~= nil then
            if BuffSystem._IsLocalPlayer(hero) then
                BuffSystem.main_frame_debuff:Show()
            end
            BuffSystem._ShowDebuffs(hero)
        end
        BuffSystem.logger:Info("...ok")
    else
        BuffSystem.logger:Info("Show buff frame...")
        if BuffSystem.main_frame_buff ~= nil then
            if BuffSystem._IsLocalPlayer(hero) then
                BuffSystem.main_frame_buff:Show()
            end
            BuffSystem._ShowBuffs(hero)
        end
        BuffSystem.logger:Info("...ok")
    end
end

--- Проверяет есть ли герой в системе бафов
---@param hero Unit Экземпляр класса Unit
---@return boolean
function BuffSystem.IsHeroInSystem(hero)
    BuffSystem.logger:Info("Checking for a hero in the system...")
    local buffs = BuffSystem._GetBuffs(hero)
    for name, _ in pairs(buffs) do
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
    local buffs = BuffSystem._GetBuffs(hero)
    if #buffs == 0 then
        BuffSystem.logger:Info("No buffs")
        return false
    end
    BuffSystem.CheckingBuffsExceptions(hero, buff)
    for i = 1, #buffs do
        local b = BuffSystem._GetBuff(hero, i)
        if b == nil then
            BuffSystem.logger:Info("Not found buff")
            return false
        end
        BuffSystem.logger:Info("checking", b.buff.tooltip, "...")
        if BuffSystem._GetBuff(hero, i):IsBuff(buff) or
                BuffSystem._GetBuff(hero, i):IsDebuff(buff) then
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
    local buffs = BuffSystem._GetBuffs(hero)
    for i = 1, #buffs do
        if BuffSystem._GetBuff(hero, i):IsBuff(buff) or
                BuffSystem._GetBuff(hero, i):IsDebuff(buff) then
            BuffSystem._GetBuff(hero, i).frame:Destroy()
            local player_id = playerIdByUnit(hero:GetId())
            BuffSystem.buffs[player_id][hero][i] = nil
            BuffSystem.logger:Info("Remove successfully")
        end
    end
    if BuffSystem.main_frame_buff ~= nil and BuffSystem.main_frame_debuff ~= nil then
        BuffSystem._ShowBuffs(hero)
        BuffSystem._ShowDebuffs(hero)
    end
    BuffSystem.logger:Info("There's nothing")
end

--- Использует функцию для удаления бафа
---@param hero Unit Экземпляр класса Unit
---@param buff ability Название бафа
---@return nil
function BuffSystem.RemoveBuffFromHeroByFunc(hero, buff)
    BuffSystem.logger:Info("Remove", buff.tooltip, "from", hero:GetName(), "by func")
    local buffs = BuffSystem._GetBuffs(hero)
    local player_id = playerIdByUnit(hero:GetId())
    for i = 1, #buffs do
        if buffs[i] == nil then
            return
        end

        if BuffSystem._GetBuff(hero, i):IsBuff(buff) or
                BuffSystem._GetBuff(hero, i):IsDebuff(buff) then
            BuffSystem._GetBuff(hero, i).frame:Destroy()
            BuffSystem._GetBuff(hero, i).func()
            BuffSystem.buffs[player_id][hero][i] = nil
            BuffSystem.logger:Info("Remove successfully")
        end
    end
    if BuffSystem.main_frame_buff ~= nil and BuffSystem.main_frame_debuff ~= nil then
        BuffSystem._ShowBuffs(hero)
        BuffSystem._ShowDebuffs(hero)
    end
    BuffSystem.logger:Info("There's nothing")
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
        BuffSystem.logger:Info("check buffs exceptions...")
        for class, buffs in pairs(buffs_exceptions) do
            for i in pairs(buffs) do
                if buffs[i] == buff then
                    BuffSystem.logger:Info("founded buffs exceptions")
                    return buffs_exceptions[class]
                end
            end
        end
        BuffSystem.logger:Info("check debuffs exceptions...")
        for class, buffs in pairs(debuffs_exceptions) do
            for i in pairs(buffs) do
                if buffs[i] == buff then
                    BuffSystem.logger:Info("founded debuffs exceptions")
                    return debuffs_exceptions[class]
                end
            end
        end
        BuffSystem.logger:Info("not found")
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
    local buffs = BuffSystem._GetBuffs(hero)
    for i = 1, #buffs do
        BuffSystem.RemoveBuffFromHeroByFunc(hero, BuffSystem._GetBuff(hero, i).buff)
    end
end

--- Удалить баф со всех юнитов
---@param buff Ability Название бафа
---@return nil
function BuffSystem.RemoveBuffFromUnits(buff)
    for player, buffs in pairs(BuffSystem.buffs) do
        for u, _ in pairs(buffs) do
            for i = 1, #BuffSystem.buffs[player][u] do
                if BuffSystem._GetBuff(u, i) == nil then
                    return
                end
                if BuffSystem._GetBuff(u, i):IsBuff(buff) or
                        BuffSystem._GetBuff(u, i):IsDebuff(buff) then
                    BuffSystem._GetBuff(u, i).frame:Destroy()
                    BuffSystem.buffs[player][u][i] = nil
                end
            end
            if BuffSystem.main_frame_buff ~= nil then
                BuffSystem._ShowBuffs(u)
            end
            if BuffSystem.main_frame_debuff ~= nil then
                BuffSystem._ShowDebuffs(u)
            end
        end
    end
end

--- Удаляет героя из системы бафов
---@param hero Unit Экземпляр класса Unit
---@return nil
function BuffSystem.RemoveHero(hero)
    BuffSystem.logger:Info("Remove", hero:GetName(), "from system")
    local player_id = playerIdByUnit(hero:GetId())
    --TODO: корректно удалять все бафы и фреймы!!
    BuffSystem.buffs[player_id][hero] = nil
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
    local buffs = BuffSystem._GetBuffs(hero)
    for i = 1, #buffs do
        for _, buff in pairs(improving_buffs) do
            if BuffSystem._GetBuff(hero, i) == nil then
                return value
            end
            if BuffSystem._GetBuff(hero, i):IsBuff(buff) then
                return value * 1.4
            end
        end
    end
    return value
end
