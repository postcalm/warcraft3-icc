
BattleSystem = {target = nil,
                target_event = nil,
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
    if BlzGetMouseFocusUnit() then
        BattleSystem.target = Unit(BlzGetMouseFocusUnit())
    end
    if BattleSystem.target_event then
        BattleSystem.target_event:Destroy()
    end
    if IsPlayerEnemy(GetLocalPlayer(), BattleSystem.target:GetOwner()) then
        BattleSystem.target_event = EventsUnit(BattleSystem.target)
        BattleSystem.target_event:RegisterDamaged()
        BattleSystem.target_event:AddAction(BattleSystem.ShowDamage)
    end
end

function BattleSystem.ShowDamage()
    local unit = GetTriggerUnit()
    local damage = I2S(R2I(GetEventDamage()))
    TextTag(damage, unit):Preset("damage")
end
