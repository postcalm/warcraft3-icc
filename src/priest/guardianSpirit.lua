-- Copyright (c) meiso

function Priest.CastGuardianSpirit()
    local unit = Unit(GetSpellTargetUnit())
    local model = "Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl"

    BuffSystem.RegisterHero(unit)

    local timer = CreateTimer()
    local gs_effect = Effect(Priest.hero, model, "origin")
    local event = EventsUnit(unit)
    event:RegisterDamaged()

    local remove_buff = function()
        BuffSystem.RemoveBuffToHero(unit, GUARDIAN_SPIRIT)
        DestroyTimer(timer)
        gs_effect:Destroy()
        event:Destroy()
    end

    local function SaveHero()
        BlzSetEventDamage(0.)
        unit:SetLife(unit:GetPercentLifeOfMax(50.))
    end

    local function GetLife()
        local damage = GetEventDamage()
        local current_hp = unit:GetCurrentLife()
        return current_hp < damage
    end

    BuffSystem.AddBuffToHero(unit, GUARDIAN_SPIRIT)
    TimerStart(timer, 10., false, remove_buff)

    event:AddCondition(GetLife)
    event:AddAction(SaveHero)
end

function Priest.IsGuardianSpirit()
    return GetSpellAbilityId() == GUARDIAN_SPIRIT
end

function Priest.InitGuardianSpirit()
    Ability(GUARDIAN_SPIRIT, guardian_spirit_tooltip, guardian_spirit_desc)
    Priest.hero:SetAbilityManacost(GUARDIAN_SPIRIT, 6)
    Priest.hero:SetAbilityCooldown(GUARDIAN_SPIRIT, 180.)

    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Priest.IsGuardianSpirit)
    event:AddAction(Priest.CastGuardianSpirit)
end
