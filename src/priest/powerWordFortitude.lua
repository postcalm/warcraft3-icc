---@author meiso

function Priest.RemovePowerWordFortitude(unit, items_list)
    if BuffSystem.IsBuffOnHero(unit, power_word_fortitude) then
        EquipSystem.RemoveItemsToUnit(unit, items_list)
        BuffSystem.RemoveBuffFromHero(unit, power_word_fortitude)
    end
end

function Priest.PowerWordFortitude()
    --TODO: пока что даём как есть. потом отскалируем
    local unit = GetSpellTargetUnit()
    local timer = Timer(600.)
    local items = { "POWER_WORD_FORTITUDE_ITEM" }
    local model = "Abilities/Spells/Human/InnerFire/InnerFireTarget.mdl"
    local effect = Effect(unit, model, "overhead")

    Timer(2., function() effect:Destroy() end):Start()
    BuffSystem.RegisterHero(unit)

    if BuffSystem.IsBuffOnHero(unit, power_word_fortitude) then
        BuffSystem.RemoveBuffFromHeroByFunc(unit, power_word_fortitude)
    end
    EquipSystem.AddItemsToUnit(unit, items)

    local remove_buff = function()
        Paladin.RemovePowerWordFortitude(unit, items)
        timer:Destroy()
    end
    BuffSystem.AddBuffToHero(unit, power_word_fortitude, remove_buff)
    timer:SetFunc(remove_buff)
    timer:Start()
end

function Priest.IsPowerWordFortitude()
    return power_word_fortitude:SpellCasted()
end

function Priest.InitPowerWordFortitude()
    power_word_fortitude:Init()
    Priest.hero:SetAbilityManacost(power_word_fortitude:GetId(), 27)
    Priest.hero:SetAbilityCooldown(power_word_fortitude:GetId(), 1.5)

    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Priest.IsPowerWordFortitude)
    event:AddAction(Priest.PowerWordFortitude)
end
