-- Copyright (c) meiso

function LordMarrowgar.BoneSpike()
    TriggerSleepAction(GetRandomReal(14., 17.))
    local gr = GroupHeroesInArea(gg_rct_areaLM, GetOwningPlayer(GetAttacker()))
    local target_enemy = GetUnitInArea(gr)
    local target_enemy_health = GetUnitState(target_enemy, UNIT_STATE_MAX_LIFE)

    if LordMarrowgar.bonespike_effect then
        -- призываем шип в позиции атакованной цели
        local bone_spike_obj = Unit(LICH_KING, BONE_SPIKE_OBJ, GetUnitLoc(target_enemy)):GetId()

        SetUnitAnimation(bone_spike_obj, "Stand Lumber")
        SetUnitFlyHeight(target_enemy, 150., 0.)

        PauseUnit(target_enemy, true)
        PauseUnit(bone_spike_obj, true)

        -- сразу 9к
        SetUnitState(target_enemy, UNIT_STATE_LIFE, GetUnitState(target_enemy, UNIT_STATE_LIFE) - 9000.)

        while true do
            SetUnitState(target_enemy, UNIT_STATE_LIFE, GetUnitState(target_enemy, UNIT_STATE_LIFE) - (target_enemy_health * 0.10))
            TriggerSleepAction(3.)

            -- TODO: поменять время разложения
            -- если шип уничтожен - выходим и сбрасываем игрока
            if GetUnitState(bone_spike_obj, UNIT_STATE_LIFE) <= 0 then
                SetUnitAnimation(bone_spike_obj, "Decay")
                SetUnitFlyHeight(target_enemy, 0., 0.)
                PauseUnit(target_enemy, false)
                RemoveUnit(bone_spike_obj)
                LordMarrowgar.bonespike_effect = false
                break
            -- если игрок умер - сбрасываем шип
            elseif GetUnitState(target_enemy, UNIT_STATE_LIFE) <= 0 then
                RemoveUnit(bone_spike_obj)
                LordMarrowgar.bonespike_effect = false
                break
            end
        end
    end
end

-- если шип не призван
function LordMarrowgar.StartBoneSpike()
    if not LordMarrowgar.bonespike_effect then
        LordMarrowgar.bonespike_effect = true
        return true
    end
    return false
end

function LordMarrowgar.InitBoneSpike()
    local event = EventsUnit(LordMarrowgar.unit)
    event:RegisterAttacked()
    event:AddCondition(LordMarrowgar.StartBoneSpike)
    event:AddAction(LordMarrowgar.BoneSpike)
end

