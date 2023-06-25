---@author Kodpi, meiso

function Priest.CastRenew()
    --Прибавка каждые 3 секунды в течение 15 сек
    local heal = 280
    local unit = Unit(GetSpellTargetUnit())
    local model = "Abilities/Spells/ItemsAIhe/AIheTarget.mdl"
    local effect = Effect(unit, model, "origin")

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
    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Priest.IsRenew)
    event:AddAction(Priest.CastRenew)
end
