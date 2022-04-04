
mana_is_full = true

function ManaShield()
    local mana_shield
    local damage = GetEventDamage()

    mana_shield = AddSpecialEffectTarget("Abilities\\Spells\\Human\\ManaShield\\ManaShieldCaster.mdx",
                                         LADY_DEATHWHISPER, "origin")

    TriggerSleepAction(1.5)
    SetUnitState(LADY_DEATHWHISPER, UNIT_STATE_LIFE,
                 GetUnitState(LADY_DEATHWHISPER, UNIT_STATE_LIFE) + damage)
    SetUnitState(LADY_DEATHWHISPER, UNIT_STATE_MANA,
                 GetUnitState(LADY_DEATHWHISPER, UNIT_STATE_MANA) - damage)

    if GetUnitState(LADY_DEATHWHISPER, UNIT_STATE_MANA) <= 10. then
        mana_is_full = false
    end

    DestroyEffect(mana_shield)
end

function UsingManaShield()
    if mana_is_full then return true end
    return false
end

function Init_ManaShield()
    local event = EventsUnit(LADY_DEATHWHISPER)
    event:RegisterDamaged()
    event:AddCondition(UsingManaShield)
    event:AddAction(ManaShield)
end

