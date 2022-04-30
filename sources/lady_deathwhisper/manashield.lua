
LD_MANA_SHIELD = false
LD_MANA_IS_OFF = false

function ManaShield()
    local event = EventsUnit(LADY_DEATHWHISPER)
    local model = "Abilities\\Spells\\Human\\ManaShield\\ManaShieldCaster.mdx"
    local effect

    event:RegisterDamaged()

    print(BattleSystem.Status())

    if not LD_MANA_SHIELD and not LD_MANA_IS_OFF then
        effect = AddSpecialEffectTarget(model, LADY_DEATHWHISPER, "origin")
        LD_MANA_SHIELD = true
    end

    local function ManaShield()
        local damage = GetEventDamage()

        if damage == 0 then
            event:DestroyTrigger()
            return
        end

        TriggerSleepAction(1.5)
        SetUnitState(LADY_DEATHWHISPER, UNIT_STATE_LIFE,
                     GetUnitState(LADY_DEATHWHISPER, UNIT_STATE_LIFE) + damage)
        SetUnitState(LADY_DEATHWHISPER, UNIT_STATE_MANA,
                     GetUnitState(LADY_DEATHWHISPER, UNIT_STATE_MANA) - damage)
        event:DestroyTrigger()
    end

    local function UsingManaShield()
        if GetUnitState(LADY_DEATHWHISPER, UNIT_STATE_MANA) >= 10. then
            return true
        end
        LD_MANA_IS_OFF = true
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

function Init_ManaShield()
    local event = EventsUnit(LADY_DEATHWHISPER)
    event:RegisterAttacked()
    event:AddAction(ManaShield)
end

