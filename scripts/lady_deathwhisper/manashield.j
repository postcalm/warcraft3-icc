
bool manaIsFull = true

void Actions_ManaShield()
{
    effect manaShield = null
    real damage = GetEventDamage()
    sBJDebugMsg("Damage - %s", R2S(damage))
    
    manaShield = AddSpecialEffectTarget("Abilities\\Spells\\Human\\ManaShield\\ManaShieldCaster.mdx", \
                                        LADY_DEATHWHISPER, "origin")
    
    TriggerSleepAction(1.5)
    SetUnitState( LADY_DEATHWHISPER, UNIT_STATE_LIFE, \
                  GetUnitState( LADY_DEATHWHISPER, UNIT_STATE_LIFE ) + damage )
    SetUnitState( LADY_DEATHWHISPER, UNIT_STATE_MANA, \
                  GetUnitState( LADY_DEATHWHISPER, UNIT_STATE_MANA ) - damage )
    
    if( GetUnitState(LADY_DEATHWHISPER, UNIT_STATE_MANA) <= 10. )
    {
        manaIsFull = false
    }
    
    DestroyEffect(manaShield)
    manaShield = null
}

bool UsingManaShield()
{
    if(manaIsFull) { return true }
    return false
}

void Init_ManaShield()
{
    trigger triggerManaShield = new trigger
    
    TriggerRegisterUnitEvent( triggerManaShield, LADY_DEATHWHISPER, EVENT_UNIT_DAMAGED )
    TriggerAddCondition( triggerManaShield, Condition( function UsingManaShield ) )
    TriggerAddAction( triggerManaShield, function Actions_ManaShield )
    
    triggerManaShield = null
}

