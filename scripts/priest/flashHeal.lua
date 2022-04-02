--- Created by meiso.

function CastFlashHeal()
    local target = GetSpellTargetUnit()
    local heal = GetRandomInt(1887, 2193)
    local mana = GetUnitState(PRIEST, UNIT_STATE_MANA) * 0.18
    SetUnitState(PRIEST, UNIT_STATE_MANA, GetUnitState(PRIEST, UNIT_STATE_MANA) - mana)
    SetUnitState(target, UNIT_STATE_LIFE, GetUnitState(target, UNIT_STATE_LIFE) + heal)
end

function IsFlashHeal()
    return GetSpellAbilityId() == FLASH_HEAL
end

function Init_Flash_Heal()
    local trigger_ability = CreateTrigger()
    TriggerRegisterPlayerUnitEvent(trigger_ability, Player(0), EVENT_PLAYER_UNIT_SPELL_CAST, nil)
    TriggerAddCondition(trigger_ability, Condition(IsFlashHeal))
    TriggerAddAction(trigger_ability, CastFlashHeal)
end