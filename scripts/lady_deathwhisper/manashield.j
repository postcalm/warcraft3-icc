
bool mana_is_full = true

void Actions_ManaShield()
{
    effect mana_shield = null
    real damage = GetEventDamage()
    sBJDebugMsg("Damage - %s", R2S(damage))
    
    mana_shield = AddSpecialEffectTarget("Abilities\\Spells\\Human\\ManaShield\\ManaShieldCaster.mdx", \
                                        LADY_DEATHWHISPER, "origin")
    
    TriggerSleepAction(1.5)
    SetUnitState( LADY_DEATHWHISPER, UNIT_STATE_LIFE, \
                  GetUnitState( LADY_DEATHWHISPER, UNIT_STATE_LIFE ) + damage )
    SetUnitState( LADY_DEATHWHISPER, UNIT_STATE_MANA, \
                  GetUnitState( LADY_DEATHWHISPER, UNIT_STATE_MANA ) - damage )
    
    if( GetUnitState(LADY_DEATHWHISPER, UNIT_STATE_MANA) <= 10. )
    {
        mana_is_full = false
    }
    
    DestroyEffect(mana_shield)
    mana_shield = null
}

bool UsingManaShield()
{
    if(mana_is_full) { return true }
    return false
}

void Init_ManaShield()
{
    trigger trigger_ability = new trigger
    
    TriggerRegisterUnitEvent( trigger_ability, LADY_DEATHWHISPER, EVENT_UNIT_DAMAGED )
    TriggerAddCondition( trigger_ability, Condition( function UsingManaShield ) )
    TriggerAddAction( trigger_ability, function Actions_ManaShield )
}

