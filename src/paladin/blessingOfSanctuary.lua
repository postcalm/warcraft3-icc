-- Copyright (c) meiso

function Paladin.RemoveBlessingOfSanctuary(unit, stat, items_list)
    if BuffSystem.IsBuffOnHero(unit, blessing_of_sanctuary) then
        SetHeroStr(unit, GetHeroStr(unit, false) - stat, false)
        EquipSystem.RemoveItemsToUnit(unit, items_list)
        BuffSystem.RemoveBuffFromHero(unit, blessing_of_sanctuary)
    end
end

function Paladin.BlessingOfSanctuary()
    local unit = GetSpellTargetUnit()
    local timer = Timer(600.)
    local items_list = { "DEC_DMG_ITEM" }

    BuffSystem.RegisterHero(unit)

    if BuffSystem.IsBuffOnHero(unit, blessing_of_sanctuary) then
        BuffSystem.RemoveBuffFromHeroByFunc(unit, blessing_of_sanctuary)
    end

    EquipSystem.AddItemsToUnit(unit, items_list)
    local stat = R2I(GetHeroStr(unit, false) * 0.1)
    SetHeroStr(unit, GetHeroStr(unit, false) + stat, false)

    local remove_buff = function()
        Paladin.RemoveBlessingOfSanctuary(unit, stat, items_list)
        timer:Destroy()
    end
    BuffSystem.AddBuffToHero(unit, blessing_of_sanctuary, remove_buff)
    timer:SetFunc(remove_buff)
    timer:Start()
end

function Paladin.IsBlessingOfSanctuary()
    return blessing_of_sanctuary:SpellCasted()
end

function Paladin.InitBlessingOfSanctuary()
    blessing_of_sanctuary:Init()
    Paladin.hero:SetAbilityManacost(blessing_of_sanctuary:GetId(), 7)
    Paladin.hero:SetAbilityCooldown(blessing_of_sanctuary:GetId(), 1.5)

    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Paladin.IsBlessingOfSanctuary)
    event:AddAction(Paladin.BlessingOfSanctuary)
end
