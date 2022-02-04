
include "common/spells.j"

void ShieldOfRighteousness()
{
    // 42% от силы + 520 ед. урона дополнительно
    real damage = GetHeroStr( GetTriggerUnit(), true ) * 1.42 + 520.
    sBJDebugMsg("%r", damage)
    UnitDamageTarget( GetTriggerUnit(), GetSpellTargetUnit(), damage, true, false, \
                      ATTACK_TYPE_MAGIC, DAMAGE_TYPE_LIGHTNING, WEAPON_TYPE_WHOKNOWS )
}

bool IsShieldOfRighteousness()
{
    return GetSpellAbilityId() == SHIELD_OF_RIGHTEOUSNESS
}

void Init_ShieldOfRighteousness()
{
    trigger trigger_ability = new trigger

    TriggerRegisterPlayerUnitEvent( trigger_ability, Player(0), EVENT_PLAYER_UNIT_SPELL_CAST, null )
    TriggerAddCondition( trigger_ability, function IsShieldOfRighteousness )
    TriggerAddAction( trigger_ability, function ShieldOfRighteousness )
}