
BONE_SPIKE_EXIST = false

function BoneSpike()
    local whoPlayer = GetOwningPlayer(GetAttacker())
    TriggerSleepAction(GetRandomReal(14., 17.))
    local gr = GroupHeroesInArea(AREA_LM, whoPlayer)
    local targetEnemy = GetUnitInArea(gr)
    local targetEnemyHealth = GetUnitState(targetEnemy, UNIT_STATE_MAX_LIFE)

    if BONE_SPIKE_EXIST then
        -- призываем шип в позиции атакованной цели
        local boneSpikeObj = CreateUnit(whoPlayer, BONE_SPIKE_OBJ,
                                        GetLocationX(GetUnitLoc(targetEnemy)),
                                        GetLocationY(GetUnitLoc(targetEnemy)), 0.)

        SetUnitAnimation(boneSpikeObj, "Stand Lumber")
        SetUnitFlyHeight(targetEnemy, 150., 0.)

        PauseUnit(targetEnemy, true)
        PauseUnit(boneSpikeObj, true)
        
        -- сразу 9к
        SetUnitState(targetEnemy, UNIT_STATE_LIFE, GetUnitState(targetEnemy, UNIT_STATE_LIFE) - 9000.)

        while true do
            SetUnitState(targetEnemy, UNIT_STATE_LIFE, GetUnitState(targetEnemy, UNIT_STATE_LIFE) - (targetEnemyHealth * 0.10))
            TriggerSleepAction(3.)

            -- TODO: поменять время разложения
            -- если шип уничтожен - выходим и сбрасываем игрока
            if GetUnitState(boneSpikeObj, UNIT_STATE_LIFE) <= 0  then
                SetUnitAnimation(boneSpikeObj, "Decay")
                SetUnitFlyHeight(targetEnemy, 0., 0.)
                PauseUnit(targetEnemy, false)
                RemoveUnit(boneSpikeObj)
                BONE_SPIKE_EXIST = false
                break
            -- если игрок умер - сбрасываем шип
            elseif GetUnitState(targetEnemy, UNIT_STATE_LIFE) <= 0 then
                RemoveUnit(boneSpikeObj)
                BONE_SPIKE_EXIST = false
                break
            end
        end
    end
end

-- если шип не призван
function StartBoneSpike()
    if not BONE_SPIKE_EXIST then
        BONE_SPIKE_EXIST = true
        return BONE_SPIKE_EXIST
    end
    return false
end

function Init_BoneSpike()
    local triggerAbility = CreateTrigger()
    TriggerRegisterUnitEvent(triggerAbility, LORD_MARROWGAR, EVENT_UNIT_ATTACKED)
    TriggerAddCondition(triggerAbility, Condition(StartBoneSpike))
    TriggerAddAction(triggerAbility, BoneSpike)
end

