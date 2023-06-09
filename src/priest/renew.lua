-- Copyright (c) Kodpi, meiso

function Priest.CastRenew()
    --Прибавка каждые 3 секунды в течение 15 сек
    local heal = 280
    local unit = Unit(GetSpellTargetUnit())
    local model = "Abilities/Spells/ItemsAIhe/AIheTarget.mdl"
    local effect = Effect(unit, model, "origin")
    if not Priest.hero:LoseMana { percent = 17 } then
        return
    end
    for _ = 1, 5 do
        heal = BuffSystem.ImproveSpell(unit, heal)
        unit:GainLife { life = heal, show = true }
        TriggerSleepAction(3.)
    end
    effect:Destroy()
end

function Priest.IsRenew()
    return renew:SpellCasted()
end

function Priest.InitRenew()
    renew:Init()
    Priest.hero:SetAbilityManacost(renew:GetId(), 17)
    Priest.hero:SetAbilityCooldown(renew:GetId(), 1.5)

    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Priest.IsRenew)
    event:AddAction(Priest.CastRenew)
end
