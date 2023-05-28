-- Copyright (c) meiso

function Priest.CastGuardianSpirit()
    local unit = Unit(GetSpellTargetUnit())
    local model = "Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl"

    BuffSystem.RegisterHero(unit)

    local timer = Timer(10.)
    local gs_effect = Effect(Priest.hero, model, "origin")
    local event = EventsUnit(unit)
    event:RegisterDamaged()

    local remove_buff = function()
        BuffSystem.RemoveBuffFromHero(unit, guardian_spirit)
        timer:Destroy()
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
    BuffSystem.AddBuffToHero(unit, guardian_spirit)
    timer:SetFunc(remove_buff)
    timer:Start()
    event:AddCondition(GetLife)
    event:AddAction(SaveHero)
end

function Priest.IsGuardianSpirit()
    return guardian_spirit:SpellCasted()
end

function Priest.InitGuardianSpirit()
    guardian_spirit:Init()
    Priest.hero:SetAbilityManacost(guardian_spirit:GetId(), 6)
    Priest.hero:SetAbilityCooldown(guardian_spirit:GetId(), 180.)

    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Priest.IsGuardianSpirit)
    event:AddAction(Priest.CastGuardianSpirit)
end
