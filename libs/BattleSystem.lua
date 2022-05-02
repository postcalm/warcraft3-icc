
BattleSystem = {is_fight = false}

function BattleSystem.Init()
    local combat = CreateTrigger()
    TriggerRegisterPlayerUnitEvent(combat, PLAYER_1, EVENT_PLAYER_UNIT_DAMAGING, nil)
    TriggerRegisterPlayerUnitEvent(combat, PLAYER_1, EVENT_PLAYER_UNIT_DAMAGED, nil)
    TriggerRegisterPlayerUnitEvent(combat, PLAYER_2, EVENT_PLAYER_UNIT_DAMAGING, nil)
    TriggerRegisterPlayerUnitEvent(combat, PLAYER_2, EVENT_PLAYER_UNIT_DAMAGED, nil)
    TriggerRegisterPlayerUnitEvent(combat, LICH_KING, EVENT_PLAYER_UNIT_DAMAGING, nil)
    TriggerRegisterPlayerUnitEvent(combat, LICH_KING, EVENT_PLAYER_UNIT_DAMAGED, nil)

    local function check_combat()
        local damage = GetEventDamage()
        --print(GetEventDamageSource(), GetEventDamage())
        if damage then
            BattleSystem.is_fight = true
        else
            BattleSystem.is_fight = false
        end
    end

    TriggerAddAction(combat, check_combat)
end

function BattleSystem.Status()
    return BattleSystem.is_fight
end