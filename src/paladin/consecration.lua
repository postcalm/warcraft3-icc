
function Paladin.EnableConsecration()
    local location
    local light = 1
    local factor = 0.04
    local ap = GetHeroStr(Paladin.hero:GetId(), true) * 2
    local damage = 8 * (113 + factor * light + factor * ap)

    while Paladin.consecration_effect do
        location = Location(
                BlzGetLocalSpecialEffectX(Paladin.consecration_effect),
                BlzGetLocalSpecialEffectY(Paladin.consecration_effect))
        Paladin.hero:DealMagicDamageLoc {
            damage = damage,
            overtime = 1.,
            location = location,
            radius = 8
        }
    end
end

function Paladin.DisableConsecration()
    DestroyTimer(GetExpiredTimer())
    DestroyEffect(Paladin.consecration_effect)
    Paladin.consecration_effect = nil
end

function Paladin.Consecration()
    Paladin.hero:LoseMana{percent=22}

    local loc = Paladin.hero:GetLoc()
    local model = "Consecration_Impact_Base.mdx"
    local timer = CreateTimer()
    Paladin.consecration_effect = AddSpecialEffectLoc(model, loc)
    TimerStart(timer, 8., false, Paladin.DisableConsecration)
    Paladin.EnableConsecration()
end

function Paladin.IsConsecration()
    return GetSpellAbilityId() == CONSECRATION_TR
end

function Paladin.InitConsecration()
    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Paladin.IsConsecration)
    event:AddAction(Paladin.Consecration)
end
