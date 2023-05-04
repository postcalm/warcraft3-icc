-- Copyright (c) meiso

function Priest.RemovePowerWordShield(unit)
    if BuffSystem.IsBuffOnHero(unit, POWER_WORD_SHIELD) then
        BuffSystem.RemoveBuffToHero(unit, POWER_WORD_SHIELD)
    end
end

function Priest.CastPowerWordShield()
    local unit = Unit(GetSpellTargetUnit())
    local event = EventsUnit(unit)
    local absorb = 2230
    local model = "Abilities\\Spells\\Human\\ManaShield\\ManaShieldCaster.mdx"

    BuffSystem.RegisterHero(unit)

    --TODO: вешать 15-секундный дебаф на повтор
    if BuffSystem.IsBuffOnHero(unit, POWER_WORD_SHIELD) then
        BuffSystem.RemoveBuffToHeroByFunc(unit, POWER_WORD_SHIELD)
    end

    local timer = CreateTimer()
    local pws_effect = Effect(unit, model, "origin")
    event:RegisterDamaged()

    local remove_buff = function()
        Priest.RemovePowerWordShield(unit)
        DestroyTimer(timer)
        event:Destroy()
        pws_effect:Destroy()
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
    BuffSystem.AddBuffToHero(unit, POWER_WORD_SHIELD, remove_buff)
    TimerStart(timer, 30., false, remove_buff)

    event:AddCondition(UsingShield)
    event:AddAction(Shield)
end

function Priest.IsPowerWordShield()
    return GetSpellAbilityId() == POWER_WORD_SHIELD_TR
end

function Priest.InitPowerWordShield()
    Ability(POWER_WORD_SHIELD_TR, power_word_shield_tooltip, power_word_shield_desc)
    Priest.hero:SetAbilityManacost(POWER_WORD_SHIELD, 23)
    Priest.hero:SetAbilityCooldown(POWER_WORD_SHIELD, 4.)

    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Priest.IsPowerWordShield)
    event:AddAction(Priest.CastPowerWordShield)
end
