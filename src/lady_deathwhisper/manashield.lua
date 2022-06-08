
function LadyDeathwhisper.ManaShield()
    local event = EventsUnit(LadyDeathwhisper.unit)
    local model = "Abilities\\Spells\\Human\\ManaShield\\ManaShieldCaster.mdx"
    local effect

    event:RegisterDamaged()

    --print(BattleSystem.Status())

    if not LadyDeathwhisper.mana_shield and not LadyDeathwhisper.mana_is_over then
        effect = AddSpecialEffectTarget(model, LadyDeathwhisper.unit:GetId(), "origin")
        LadyDeathwhisper.mana_shield = true
    end

    local function ManaShield()
        local damage = GetEventDamage()

        if damage == 0 then event:Destroy() return end

        TriggerSleepAction(0.7)
        LadyDeathwhisper.unit:GainLife{life=damage}
        LadyDeathwhisper.unit:LoseMana{mana=damage, check=false}
        event:Destroy()
    end

    local function UsingManaShield()
        if LadyDeathwhisper.unit:GetCurrentMana() >= 10. then
            return true
        end
        LadyDeathwhisper.mana_is_over = true
        LadyDeathwhisper.phase = 2
        --TODO: не удаляется эффект
        DestroyEffect(effect)
        event:Destroy()
        return false
    end

    event:AddCondition(UsingManaShield)
    event:AddAction(ManaShield)

    --local function destroy_effect()
    --    DestroyEffect(effect)
    --    DestroyTimer(GetExpiredTimer())
    --end
    --
    --if not BattleSystem.Status() then
    --    local timer = CreateTimer()
    --    TimerStart(timer, 5., false, destroy_effect)
    --end
end

function LadyDeathwhisper.MSCheckPhase()
    if LadyDeathwhisper.phase == 1 then
        return true
    end
    return false
end

function LadyDeathwhisper.InitManaShield()
    local event = EventsUnit(LadyDeathwhisper.unit)
    event:RegisterAttacked()
    event:AddCondition(LadyDeathwhisper.MSCheckPhase)
    event:AddAction(LadyDeathwhisper.ManaShield)
end

