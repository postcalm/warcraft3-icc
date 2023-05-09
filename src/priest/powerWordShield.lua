-- Copyright (c) meiso

function Priest.RemovePowerWordShield(unit)
    if BuffSystem.IsBuffOnHero(unit, power_word_shield) then
        BuffSystem.RemoveBuffFromHero(unit, power_word_shield)
    end
end

function Priest.CastPowerWordShield()
    local unit = Unit(GetSpellTargetUnit())
    local event = EventsUnit(unit)
    local absorb = 2230
    local model = "Abilities\\Spells\\Human\\ManaShield\\ManaShieldCaster.mdx"

    BuffSystem.RegisterHero(unit)

    --ничего не делаем, если есть дебаф на повтор
    if BuffSystem.IsBuffOnHero(unit, weakened_soul) then
        return
    end
    --проверяем есть ли щит, если да - сбрасываем и обновляем
    if BuffSystem.IsBuffOnHero(unit, power_word_shield) then
        BuffSystem.RemoveBuffFromHeroByFunc(unit, power_word_shield)
    end

    local timer = CreateTimer()
    local debuff_timer = CreateTimer()
    local pws_effect = Effect(unit, model, "origin")
    event:RegisterDamaged()

    local remove_buff = function()
        Priest.RemovePowerWordShield(unit)
        DestroyTimer(timer)
        event:Destroy()
        pws_effect:Destroy()
    end

    local remove_debuff = function()
        BuffSystem.RemoveBuffFromHero(unit, weakened_soul)
        DestroyTimer(debuff_timer)
    end

    local function Shield()
        local damage = GetEventDamage()
        if damage == 0 then return end
        absorb = absorb - damage
        if 0. <= absorb and absorb < damage then
            BlzSetEventDamage(absorb)
            remove_buff()
        else
            BlzSetEventDamage(0.)
        end
    end

    local function UsingShield()
        return absorb > 0.
    end

    BuffSystem.AddBuffToHero(unit, power_word_shield, remove_buff)
    --фиксируем дебаф на юните
    BuffSystem.AddBuffToHero(unit, weakened_soul, remove_debuff, true)
    TimerStart(timer, 30., false, remove_buff)
    --сбрасываем сам дебаф через 15 сек
    TimerStart(debuff_timer, 15., false, remove_debuff)

    event:AddCondition(UsingShield)
    event:AddAction(Shield)
end

function Priest.IsPowerWordShield()
    return power_word_shield:SpellCasted()
end

function Priest.InitPowerWordShield()
    power_word_shield:Init()
    Priest.hero:SetAbilityManacost(power_word_shield:GetId(), 23)
    Priest.hero:SetAbilityCooldown(power_word_shield:GetId(), 4.)

    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Priest.IsPowerWordShield)
    event:AddAction(Priest.CastPowerWordShield)
end
