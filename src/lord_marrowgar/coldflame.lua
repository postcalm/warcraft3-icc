
function LordMarrowgar.Coldflame()
    TriggerSleepAction(GetRandomReal(2., 3.))

    local target = Unit(GetUnitInArea(GroupHeroesInArea(gg_rct_areaLM,
            GetOwningPlayer(GetAttacker()))))
    local lord_location = LordMarrowgar.unit:GetLoc()
    local target_location = target:GetLoc()

    if LordMarrowgar.coldflame_effect then
        -- призываем дамми-юнита и направляем его в сторону игрока
        local coldflame_obj = Unit(GetTriggerPlayer(), DUMMY, lord_location)
        coldflame_obj:SetMoveSpeed(0.6)
        coldflame_obj:SetPathing(false)

        -- через 9 сек дамми-юнит должен умереть
        coldflame_obj:ApplyTimedLife(9.)

        while true do
            coldflame_obj:MoveToLoc(target_location)
            -- другим дамми-юнитом кастуем flame strike, иммитируя coldflame
            LordMarrowgar.coldflame:CastToTarget("flamestrike", coldflame_obj)
            TriggerSleepAction(0.03)
            if coldflame_obj:GetCurrentLife() <= 0 then break end
        end
        LordMarrowgar.coldflame_effect = false
    end
end

function LordMarrowgar.StartColdflame()
    if not LordMarrowgar.coldflame_effect then
        LordMarrowgar.coldflame_effect = true
        return true
    end
    return false
end

function LordMarrowgar.InitColdflame()
    local event = EventsUnit(LordMarrowgar.unit)
    event:RegisterAttacked()
    event:AddCondition(LordMarrowgar.StartColdflame)
    event:AddAction(LordMarrowgar.Coldflame)
end
