-- Copyright (c) 2022 Kodpi

function Priest.CastCircleOfHealing()
    if not Priest.hero:LoseMana{percent=21} then return end
    local heal = GetRandomInt(958, 1058)

    Priest.hero:HealNear {
        heal = heal,
        location = Priest.hero:GetLoc(),
        radius = 15
    }
end

--- Заврешение способности
function Priest.IsCircleOfHealing()
    return GetSpellAbilityId() == CIRCLE_OF_HEALING
end

--- Иницилизация персонажа
function Priest.InitCircleOfHealing()
    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Priest.IsCircleOfHealing)
    event:AddAction(Priest.CastCircleOfHealing)
end

