
AttackSystem = {target = nil,
                target_event = nil,
}

function AttackSystem.Init()
    local damaged = EventsPlayer()
    local settarget = EventsPlayer()
    damaged:RegisterUnitDamaged()
    settarget:RegisterPlayerMouseDown()

    damaged:AddAction(AttackSystem.ShowDamage)
    settarget:AddCondition(AttackSystem.IsRightButton)
    settarget:AddAction(AttackSystem.SetTarget)
end

function AttackSystem.IsRightButton()
    return BlzGetTriggerPlayerMouseButton() == MOUSE_BUTTON_TYPE_RIGHT
end

function AttackSystem.SetTarget()
    if BlzGetMouseFocusUnit() then
        AttackSystem.target = Unit(BlzGetMouseFocusUnit())
    end
    if AttackSystem.target_event then
        AttackSystem.target_event:Destroy()
    end
    if IsPlayerEnemy(GetLocalPlayer(), AttackSystem.target:GetOwner()) then
        AttackSystem.target_event = EventsUnit(AttackSystem.target)
        AttackSystem.target_event:RegisterDamaged()
        AttackSystem.target_event:AddAction(AttackSystem.ShowDamage)
    end
end

function AttackSystem.ShowDamage()
    local unit = GetTriggerUnit()
    local damage = I2S(R2I(GetEventDamage()))
    local zOffset = GetRandomInt(20, 40)
    local text = TextTag(damage, unit, zOffset, 10, 255, 0, 0, 20)
    text:Permanent(false)
    text:SetVelocity(50, GetRandomInt(50, 130))
    text:SetLifespan(2.)
end
