
function ManaShield()
    local event = EventsUnit(LADY_DEATHWHISPER)
    event:RegisterDamaged()

    local function ManaShield()
        local damage = GetEventDamage()

        if damage == 0 then
            event:DestroyTrigger()
            return
        end

        local mana_shield = AddSpecialEffectTarget("Abilities\\Spells\\Human\\ManaShield\\ManaShieldCaster.mdx",
                LADY_DEATHWHISPER, "origin")
        TriggerSleepAction(1.5)
        SetUnitState(LADY_DEATHWHISPER, UNIT_STATE_LIFE,
                GetUnitState(LADY_DEATHWHISPER, UNIT_STATE_LIFE) + damage)
        SetUnitState(LADY_DEATHWHISPER, UNIT_STATE_MANA,
                GetUnitState(LADY_DEATHWHISPER, UNIT_STATE_MANA) - damage)
        DestroyEffect(mana_shield)
        event:DestroyTrigger()
    end

    local function UsingManaShield()
        if GetUnitState(LADY_DEATHWHISPER, UNIT_STATE_MANA) >= 10. then
            return true
        end
        event:DestroyTrigger()
        return false
    end

    event:AddCondition(UsingManaShield)
    event:AddAction(ManaShield)
end

function Init_ManaShield()
    local event = EventsUnit(LADY_DEATHWHISPER)
    event:RegisterAttacked()
    event:AddCondition(UsingManaShield)
    event:AddAction(ManaShield)
end

