---@author Kodpi, meiso

function Priest.CastFlashHeal()
    local cast_time = 1.5
    local target = Unit(GetSpellTargetUnit())
    local model = "Abilities/Spells/Items/AIhe/AIheTarget.mdl"

    --TODO: скалировать от стат
    local heal = GetRandomInt(1887, 2193)
    heal = BuffSystem.ImproveSpell(target, heal)

    -- отображаем кастбар
    Frame:CastBar(cast_time, "Быстрое исцеление", Priest.hero)
    TriggerSleepAction(cast_time)
    -- дропаем каст заклинания, если кастбар был сброшен
    if Frame:IsDrop() then return end

    -- даем хп указанному юниту
    target:GainLife { life = heal, show = true}
    local effect = Effect(target, model, "origin")
    Timer(1., function() effect:Destroy() end):Start()
end

function Priest.IsFlashHeal()
    return flash_heal:SpellCasted()
end

function Priest.InitFlashHeal()
    flash_heal:Init()
    Priest.hero:SetAbilityManacost(flash_heal:GetId(), 18)
    Priest.hero:SetAbilityCooldown(flash_heal:GetId(), 1.5)

    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Priest.IsFlashHeal)
    event:AddAction(Priest.CastFlashHeal)
end
