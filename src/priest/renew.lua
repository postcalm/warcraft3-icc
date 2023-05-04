-- Copyright (c)  Kodpi

function Priest.CastRenew()
    --Прибавка каждые 3 секунды в течение 15 сек
    local heal = 280
    local unit = Unit(GetSpellTargetUnit())

    if not Priest.hero:LoseMana { percent = 17 } then
        return
    end
    for _ = 1, 5 do
        heal = BuffSystem.ImproveSpell(unit, heal)
        unit:GainLife { life = heal, show = true }
        TriggerSleepAction(3.)
    end
end

function Priest.IsRenew()
    return GetSpellAbilityId() == RENEW
end

function Priest.InitRenew()
    Ability(RENEW, renew_tooltip, renew_desc)
    Priest.hero:SetAbilityManacost(RENEW, 17)
    Priest.hero:SetAbilityCooldown(RENEW, 1.5)

    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Priest.IsRenew)
    event:AddAction(Priest.CastRenew)
end
