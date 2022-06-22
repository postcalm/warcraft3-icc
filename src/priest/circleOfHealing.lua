-- Copyright (c) 2022 Kodpi

function Priest.CastCircleOfHealing()
    local target = Unit(GetSpellTargetUnit())

    if not Priest.hero:LoseMana{percent=21} then return end
    local heal = GetRandomInt(958, 1058)

    while Priest.consecration_effect do
        location = Location(
                BlzGetLocalSpecialEffectX(Priest.consecration_effect),
                BlzGetLocalSpecialEffectY(Priest.consecration_effect))
        Priest.hero:GainLifeNear {
            heal = heal,
            overtime = 6.,
            location = location,
            radius = 15
        }
    end
end

--- Заврешение способности
function Priest.IsCircleOfHealing()
    return GetSpellAbilityId() == CIRCLE_OF_HEALING
end

--- Иницилизация персонажа
function Priest.InitCircleOfHealing()
    local event = EventsPlayer(PLAYER_1)
    event:RegisterUnitSpellCast()
    event:AddCondition(Priest.IsCircleOfHealing)
    event:AddAction(Priest.CastCircleOfHealing)
end

