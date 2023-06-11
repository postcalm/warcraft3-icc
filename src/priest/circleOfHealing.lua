---@author Kodpi, meiso

function Priest.CastCircleOfHealing()
    local heal = GetRandomInt(958, 1058)

    local function act()
        local u = GetEnumUnit()
        if Priest.hero:IsAlly(u) then
            heal = BuffSystem.ImproveSpell(u, heal)
            Unit(u):GainLife { life = heal, show = true }
        end
    end

    Priest.hero:UseSpellFunc {
        location = Priest.hero:GetLoc(),
        radius = 15,
        func = act
    }
end

function Priest.IsCircleOfHealing()
    return circle_of_healing:SpellCasted()
end

function Priest.InitCircleOfHealing()
    circle_of_healing:Init()
    Priest.hero:SetAbilityManacost(circle_of_healing:GetId(), 21)
    Priest.hero:SetAbilityCooldown(circle_of_healing:GetId(), 6.)

    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Priest.IsCircleOfHealing)
    event:AddAction(Priest.CastCircleOfHealing)
end
