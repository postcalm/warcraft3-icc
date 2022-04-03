--- Created by Kodpi.

function RemoveHeal(unit,HP)
    print("heal", HP)
    SetUnitState(unit, UNIT_STATE_LIFE, GetUnitState(unit, UNIT_STATE_LIFE) + HP)
end

function CastRenew()
    --Прибавка каждые 3 секунды
    local HP = 280

    local unit = GetSpellTargetUnit()
    for _ = 1, 5 do
        RemoveHeal(unit, HP)
        TriggerSleepAction(3.)
    end

    local mana = GetUnitState(PRIEST, UNIT_STATE_MANA) * 0.17
    SetUnitState(PRIEST, UNIT_STATE_MANA, GetUnitState(PRIEST, UNIT_STATE_MANA) - mana)
    print("mana = ", mana)
end

function IsRenew()
    return GetSpellAbilityId() == RENEW
end

function Init_Renew()
    local trigger_ability = CreateTrigger()
    TriggerRegisterPlayerUnitEvent(trigger_ability, Player(0), EVENT_PLAYER_UNIT_SPELL_CAST, nil)
    TriggerAddCondition(trigger_ability, Condition(IsRenew))
    TriggerAddAction(trigger_ability, CastRenew)
end