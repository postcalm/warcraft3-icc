---@author meiso

function Priest.InnerFire()
    local event = EventsUnit(Priest.hero)
    local stack = 20
    local timer = Timer(60. * 30)  --баф висит полчаса
    local spd = 120 * SPD
    local armor = 2440
    local model = "Abilities/Spells/Human/InnerFire/InnerFireTarget.mdl"

    BuffSystem.RegisterHero(Priest.hero)

    if BuffSystem.IsBuffOnHero(Priest.hero, inner_fire) then
        BuffSystem.RemoveBuffFromHeroByFunc(Priest.hero, inner_fire)
    end

    local effect = Effect(Priest.hero, model)
    Timer(2., function() effect:Destroy() end):Start()

    event:RegisterDamaged()

    Priest.hero:AddInt(spd)
    Priest.hero:AddArmor(armor)
    local remove_buff =  function()
        Priest.hero:AddInt(-spd)
        Priest.hero:AddArmor(-armor)
        event:Destroy()
        timer:Destroy()
    end
    BuffSystem.AddBuffToHero(Priest.hero, inner_fire, remove_buff)
    timer:SetFunc(remove_buff)
    timer:Start()

    local function InnerFire()
        TriggerSleepAction(0.)
        local damage = GetEventDamage()
        if damage > 0. then
            stack = stack - 1
        end
    end

    event:AddAction(InnerFire)
    event:AddAction(function()
        if stack == 0 then remove_buff() end
    end)
end

function Priest.IsInnerFire()
    return inner_fire:SpellCasted()
end

function Priest.InitInnerFire()
    inner_fire:Init()
    Priest.hero:SetAbilityManacost(inner_fire:GetId(), 14)
    Priest.hero:SetAbilityCooldown(inner_fire:GetId(), 1.5)

    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Priest.IsInnerFire)
    event:AddAction(Priest.InnerFire)
end
