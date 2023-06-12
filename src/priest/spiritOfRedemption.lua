---@author meiso

function Priest.SORHideMainUnit()
    Priest.hero:Pause(true)
    Priest.hero:Hide()
    Priest.hero:SetPathing(true)
end

function Priest.SORShowOffUnit(u_sor)
    u_sor:SetName(Priest.hero:GetName())
    u_sor:AddAbilities(ALL_MAIN_PRIEST_SPELLS)
    for _, spell in pairs(ALL_MAIN_PRIEST_SPELLS) do
        Priest.hero:SetAbilityManacost(spell, 0)
    end
end

function Priest.SpiritOfRedemption()
    local timer = Timer(15.)
    local u_sor = Unit(
            Priest.hero:GetOwner(),
            PRIEST_SOR,
            Priest.hero:GetLoc(),
            Priest.hero:GetFacing()
    )

    Priest.SORHideMainUnit()
    TriggerSleepAction(0.)
    Priest.SORShowOffUnit(u_sor)

    timer:SetFunc(function()
        Priest.hero:Pause(false)
        Priest.hero:Show()
        Priest.hero:Kill()
        Priest.spirit_of_redemption = false
        u_sor:Hide()
        u_sor:Remove()
        timer:Destroy()
    end)
    timer:Start()
end

function Priest.IsSpiritOfRedemption()
    -- берём проверку на смерть в свои руки,
    -- чтобы лишний раз не триггерить воскрешение (да и вообще не париться с ним)
    local dmg = GetEventDamage()
    local dmg_target = BlzGetEventDamageTarget()
    if Priest.hero:GetCurrentLife() - dmg <= 1. and
            dmg_target == Priest.hero:GetId() and
            not Priest.spirit_of_redemption then
        Priest.spirit_of_redemption = true
        BlzSetEventDamage(0.)
        return true
    end
    return false
end

function Priest.InitSpiritOfRedemption()
    spirit_of_redemption:Init()
    Priest.hero:SetAbilityCooldown(spirit_of_redemption:GetId(), 1.5)
    Priest.hero:SetAbilityManacost(spirit_of_redemption:GetId(), 0.)
    Priest.hero:DisableAbility(spirit_of_redemption:GetId())

    local event = EventsPlayer()
    event:RegisterUnitDamaged()
    event:AddCondition(Priest.IsSpiritOfRedemption)
    event:AddAction(Priest.SpiritOfRedemption)
end
