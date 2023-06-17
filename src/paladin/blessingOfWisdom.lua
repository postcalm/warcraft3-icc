---@author meiso

function Paladin.RemoveBlessingOfWisdom(unit, items_list)
    if BuffSystem.IsBuffOnHero(unit, blessing_of_wisdom) then
        EquipSystem.RemoveItemsToUnit(unit, items_list)
        BuffSystem.RemoveBuffFromHero(unit, blessing_of_wisdom)
    end
end

function Paladin.BlessingOfWisdom()
    local unit = GetSpellTargetUnit()
    local timer = Timer(600.)
    local items_list = { Items.BLESSING_OF_WISDOM_ITEM }

    BuffSystem.RegisterHero(unit)

    if BuffSystem.IsBuffOnHero(unit, blessing_of_wisdom) then
        BuffSystem.RemoveBuffFromHeroByFunc(unit, blessing_of_wisdom)
    end

    EquipSystem.AddItemsToUnit(unit, items_list)

    local remove_buff = function()
        Paladin.RemoveBlessingOfWisdom(unit, items_list)
        timer:Destroy()
    end
    BuffSystem.AddBuffToHero(unit, blessing_of_wisdom, remove_buff)
    timer:SetFunc(remove_buff)
    timer:Start()
end

function Paladin.IsBlessingOfWisdom()
    return blessing_of_wisdom:SpellCasted()
end

function Paladin.InitBlessingOfWisdom()
    blessing_of_wisdom:Init()

    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Paladin.IsBlessingOfWisdom)
    event:AddAction(Paladin.BlessingOfWisdom)
end
