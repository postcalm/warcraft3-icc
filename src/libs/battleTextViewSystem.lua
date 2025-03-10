---@author meiso

BattleTextViewSystem = {
    ---@param target Unit Текущая цель игрока для которой отображается урон
    target = nil,
    ---@param target_event Event Текущее событие на отображение урона
    target_event = nil,
    ---@param disable boolean Отключить отображение урона
    disable = false,
}

function BattleTextViewSystem.Init()
    local damaged = EventsPlayer()
    local settarget = EventsPlayer()
    damaged:RegisterUnitDamaged()
    settarget:RegisterPlayerMouseDown()

    damaged:AddAction(BattleTextViewSystem.ShowDamage)
    settarget:AddCondition(BattleTextViewSystem.IsRightButton)
    settarget:AddAction(BattleTextViewSystem.SetTarget)
end

function BattleTextViewSystem.IsRightButton()
    return BlzGetTriggerPlayerMouseButton() == MOUSE_BUTTON_TYPE_RIGHT
end

function BattleTextViewSystem.SetTarget()
    if BlzGetMouseFocusUnit() then
        BattleTextViewSystem.target = Unit(BlzGetMouseFocusUnit())
    end
    if BattleTextViewSystem.target_event then
        BattleTextViewSystem.target_event:Destroy()
    end
    if IsPlayerEnemy(GetLocalPlayer(), BattleTextViewSystem.target:GetOwner()) then
        BattleTextViewSystem.target_event = EventsUnit(BattleTextViewSystem.target)
        BattleTextViewSystem.target_event:RegisterDamaged()
        BattleTextViewSystem.target_event:AddAction(BattleTextViewSystem.ShowDamage)
    end
end

function BattleTextViewSystem.ShowDamage()
    local unit = GetTriggerUnit()
    local damage = GetEventDamage()
    -- если урона 0, то игра может крашнуть из-за частого срабатывания
    if damage ~= 0. and not BattleTextViewSystem.disable then
        TextTag(damage, unit):Preset("damage")
    end
end
