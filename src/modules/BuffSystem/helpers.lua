---@author meiso


---@private
---@param hero Unit
function BuffSystem._AddHero(hero)
    local player_id = playerIdByUnit(hero:GetId())
    if BuffSystem.buffs[player_id] == nil then
        BuffSystem.buffs[player_id] = {}
    end
    if BuffSystem.buffs[player_id][hero] == nil then
        BuffSystem.buffs[player_id][hero] = {}
    end
end

---@private
---@param hero Unit
---@param buff Buff
function BuffSystem._AddBuff(hero, buff)
    BuffSystem.logger:Info("add buff...")
    local player_id = playerIdByUnit(hero:GetId())
    table.insert(BuffSystem.buffs[player_id][hero], buff)
    BuffSystem.logger:Info("...success. Current count", #BuffSystem._GetBuffs(hero))
end

---@private
---@param hero Unit
function BuffSystem._GetBuffs(hero)
    local buffs = BuffSystem.buffs[playerIdByUnit(hero:GetId())]
    if buffs == nil then
        return {}
    end
    return buffs[hero]
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
    return buff_icon
end

---@private
---@param u Unit Id юнита
function BuffSystem._ShowBuffs(u)
    BuffSystem.logger:Debug("_ShowBuffs start")
    local count = 0
    local buffs = BuffSystem._GetBuffs(u)
    BuffSystem.logger:Info("effects count", tostring(#buffs))
    for i = 1, #buffs do
        local buff = BuffSystem._GetBuff(u, i)
        if buff and not buff.is_debuff then
            count = count + 1
            BuffSystem.logger:Info("buff", buff.buff.tooltip)
            BuffSystem.logger:Info("icon", buff.buff.icon)
            if BuffSystem._IsLocalPlayer(u) then
                BuffSystem._ResizeMainFrame(
                        BuffSystem.main_frame_buff,
                        buff.frame,
                        count - 1
                )
            end
            local icon_frame = BuffSystem._SetIcon(buff.buff.icon)
            if not BuffSystem._IsLocalPlayer(u) then
                icon_frame:Hide()
                buff.frame:Hide()
            end
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
    local buffs = BuffSystem._GetBuffs(u)
    BuffSystem.logger:Info("effects count", tostring(#buffs))
    for i = 1, #buffs do
        local debuff = BuffSystem._GetBuff(u, i)
        if debuff and debuff.is_debuff then
            count = count + 1
            BuffSystem.logger:Info("debuff", debuff.buff.tooltip)
            BuffSystem.logger:Info("icon", debuff.buff.icon)
            if BuffSystem._IsLocalPlayer(u) then
                BuffSystem._ResizeMainFrame(
                        BuffSystem.main_frame_debuff,
                        debuff.frame,
                        count - 1
                )
            end
            local icon_frame = BuffSystem._SetIcon(debuff.buff.icon)
            if not BuffSystem._IsLocalPlayer(u) then
                icon_frame:Hide()
                debuff.frame:Hide()
            end
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
function BuffSystem._GetBuff(u, i)
    return BuffSystem._GetBuffs(u)[i]
end

function BuffSystem._IsLocalPlayer(u)
    return Unit(u):GetOwner() == GetLocalPlayer()
end
