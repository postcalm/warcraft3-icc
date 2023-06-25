---@author Kodpi, meiso

function Priest.CastCircleOfHealing()
    local heal = GetRandomInt(958, 1058)
    local model = "Abilities/Spells/Items/HealingSalve/HealingSalveTarget.mdl"

    local function act()
        local u = GetEnumUnit()
        if Priest.hero:IsAlly(u) then
            local effect = Effect(u, model, "origin")
            Timer(1., function() effect:Destroy() end):Start()
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
    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Priest.IsCircleOfHealing)
    event:AddAction(Priest.CastCircleOfHealing)
end
