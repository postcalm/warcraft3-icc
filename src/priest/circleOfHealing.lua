-- Copyright (c) Kodpi, meiso

function Priest.CastCircleOfHealing()
    if not Priest.hero:LoseMana { percent = 21 } then
        return
    end
    local heal = GetRandomInt(958, 1058)

    local function act()
        local u = GetEnumUnit()
        if Priest.hero:IsAlly(u) then
            heal = BuffSystem.ImproveSpell(u, heal)
            Unit(u):GainLife { life = heal, show = true }
        end
    end

    Priest.hero:HealNear {
        location = Priest.hero:GetLoc(),
        radius = 15,
        func = act
    }
end

function Priest.IsCircleOfHealing()
    return GetSpellAbilityId() == CIRCLE_OF_HEALING
end

function Priest.InitCircleOfHealing()
    Ability(CIRCLE_OF_HEALING, circle_of_healing_tooltip, circle_of_healing_desc)
    Priest.hero:SetAbilityManacost(CIRCLE_OF_HEALING, 21)
    Priest.hero:SetAbilityCooldown(CIRCLE_OF_HEALING, 6.)

    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Priest.IsCircleOfHealing)
    event:AddAction(Priest.CastCircleOfHealing)
end
