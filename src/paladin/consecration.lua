---@author meiso

function Paladin.EnableConsecration()
    local location
    local light = 1
    local factor = 0.04
    local ap = GetHeroStr(Paladin.hero:GetId(), true) * 2
    local damage = 8 * (113 + factor * light + factor * ap)

    while Paladin.consecration_effect do
        location = Location(
                BlzGetLocalSpecialEffectX(Paladin.consecration_effect),
                BlzGetLocalSpecialEffectY(Paladin.consecration_effect)
        )
        Paladin.hero:DealMagicDamageLoc {
            damage = damage,
            overtime = 1.,
            location = location,
            radius = 8
        }
    end
end

function Paladin.Consecration()
    local loc = Paladin.hero:GetLoc()
    local model = "Consecration_Impact_Base.mdx"
    local timer = Timer(8.)
    local function remove_effect()
        DestroyEffect(Paladin.consecration_effect)
        Paladin.consecration_effect = nil
        timer:Destroy()
    end
    Paladin.consecration_effect = AddSpecialEffectLoc(model, loc)
    timer:SetFunc(remove_effect)
    timer:Start()
    Paladin.EnableConsecration()
end

function Paladin.IsConsecration()
    return consecration:SpellCasted()
end

function Paladin.InitConsecration()
    consecration:Init()
    Paladin.hero:SetAbilityManacost(consecration:GetId(), 22)
    Paladin.hero:SetAbilityCooldown(consecration:GetId(), 8.)

    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Paladin.IsConsecration)
    event:AddAction(Paladin.Consecration)
end
