-- Copyright (c) meiso

function Priest.RemovePrayerOfMending(unit, timer)
    if BuffSystem.IsBuffOnHero(unit, prayer_of_mending) then
        BuffSystem.RemoveBuffFromHero(unit, prayer_of_mending)
    end
    DestroyTimer(timer)
end

function Priest.CastPrayerOfMending()
    local unit = GetSpellTargetUnit()
    local last_unit
    local event
    local cured = false
    local POM_JUMP_COUNT = 5

    --при повторном наложении сбрасываем со всех
    if BuffSystem.IsBuffOnHero(unit, prayer_of_mending) then
        BuffSystem.RemoveBuffFromUnits(prayer_of_mending)
        POM_JUMP_COUNT = 5
    end

    while POM_JUMP_COUNT > -1 do
        TriggerSleepAction(0.)
        if unit ~= last_unit then
            POM_JUMP_COUNT = POM_JUMP_COUNT - 1
            last_unit = unit

            if event then event:Destroy() end
            BuffSystem.RegisterHero(unit)
            event = EventsUnit(unit)
            event:RegisterDamaged()

            local timer = CreateTimer()
            local remove_buff = function()
                Priest.RemovePrayerOfMending(unit, timer)
            end

            BuffSystem.AddBuffToHero(unit, prayer_of_mending, remove_buff)
            --баф снимется сам через 30 сек
            TimerStart(timer, 30., remove_buff)

            event:AddCondition(function()
                return BuffSystem.IsBuffOnHero(unit, prayer_of_mending)
            end)
            event:AddAction(function()
                local heal = 1043
                heal = BuffSystem.ImproveSpell(unit, heal)
                Unit(unit):GainLife { life = heal, show = true }
                cured = true
                Priest.RemovePrayerOfMending(unit, timer)
            end)
        end
        if cured and last_unit == unit then
            cured = false
            if event then event:Destroy() end
            local group = GroupUnitsInRangeOfLocUnit(400, Unit(last_unit):GetLoc())
            for _ = 1, CountUnitsInGroup(group) do
                TriggerSleepAction(0.)
                local temp = GroupPickRandomUnit(group)
                if IsUnitAlly(temp, GetOwningPlayer(GetTriggerUnit())) and
                        temp ~= last_unit then
                    unit = temp
                end
                GroupRemoveUnit(group, temp)
            end
            BuffSystem.RemoveBuffFromHero(last_unit, prayer_of_mending)
            DestroyGroup(group)
        end
    end
    unit = nil
    last_unit = nil
end

function Priest.IsPrayerOfMending()
    return prayer_of_mending:SpellCasted()
end

function Priest.InitPrayerOfMending()
    prayer_of_mending:Init()
    Priest.hero:SetAbilityManacost(prayer_of_mending:GetId(), 15)
    Priest.hero:SetAbilityCooldown(prayer_of_mending:GetId(), 10.)

    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Priest.IsPrayerOfMending)
    event:AddAction(Priest.CastPrayerOfMending)
end
