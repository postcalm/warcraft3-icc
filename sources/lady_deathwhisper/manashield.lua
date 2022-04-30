
function LadyDeathwhisper.ManaShield()
    local event = EventsUnit(LadyDeathwhisper.unit)
    local model = "Abilities\\Spells\\Human\\ManaShield\\ManaShieldCaster.mdx"
    local effect

    event:RegisterDamaged()

    print(BattleSystem.Status())

    if not LadyDeathwhisper.mana_shield and not LadyDeathwhisper.mana_is_over then
        effect = AddSpecialEffectTarget(model, LadyDeathwhisper.unit, "origin")
        LadyDeathwhisper.mana_shield = true
    end

    local function ManaShield()
        local damage = GetEventDamage()

        if damage == 0 then
            event:DestroyTrigger()
            return
        end

        TriggerSleepAction(1.5)
        SetUnitState(LadyDeathwhisper.unit, UNIT_STATE_LIFE,
                     GetUnitState(LadyDeathwhisper.unit, UNIT_STATE_LIFE) + damage)
        SetUnitState(LadyDeathwhisper.unit, UNIT_STATE_MANA,
                     GetUnitState(LadyDeathwhisper.unit, UNIT_STATE_MANA) - damage)
        event:DestroyTrigger()
    end

    local function UsingManaShield()
        if GetUnitState(LadyDeathwhisper.unit, UNIT_STATE_MANA) >= 10. then
            return true
        end
        LadyDeathwhisper.mana_is_over = true
        DestroyEffect(effect)
        event:DestroyTrigger()
        return false
    end

    event:AddCondition(UsingManaShield)
    event:AddAction(ManaShield)

    --local function destroy_effect()
    --    DestroyEffect(effect)
    --    DestroyTimer(GetExpiredTimer())
    --end
    --
    --if not BattleSystem.Status() then
    --    local timer = CreateTimer()
    --    TimerStart(timer, 5., false, destroy_effect)
    --end
end

function LadyDeathwhisper.InitManaShield()
    local event = EventsUnit(LadyDeathwhisper.unit)
    event:RegisterAttacked()
    event:AddAction(LadyDeathwhisper.ManaShield)
end

