
function Paladin.RemoveBlessingOfWisdom(unit, items_list, timer)
    if BuffSystem.IsBuffOnHero(unit, BLESSING_OF_WISDOM) then
        EquipSystem.RemoveItemsToUnit(unit, items_list)
        BuffSystem.RemoveBuffToHero(unit, BLESSING_OF_WISDOM)
    end
    DestroyTimer(timer)
end

function Paladin.BlessingOfWisdom()
    local unit = GetSpellTargetUnit()
    local items_list = {"BLESSING_OF_WISDOM_ITEM"}
    local items_spells_list = {"BLESSING_OF_WISDOM"}

    BuffSystem.RegisterHero(unit)
    EquipSystem.RegisterItems(items_list, items_spells_list)

    if not Paladin.hero:LoseMana{percent=5} then return end

    if BuffSystem.IsBuffOnHero(unit, BLESSING_OF_WISDOM) then
       BuffSystem.RemoveBuffToHeroByFunc(unit, BLESSING_OF_WISDOM) 
    end

    EquipSystem.AddItemsToUnit(unit, items_list)

    local timer = CreateTimer()
    local remove_buff = function() Paladin.RemoveBlessingOfWisdom(unit, items_list, timer) end
    BuffSystem.AddBuffToHero(unit, BLESSING_OF_WISDOM, remove_buff)

    TimerStart(timer, 600., false, remove_buff)
end

function Paladin.IsBlessingOfWisdom()
    return GetSpellAbilityId() == BLESSING_OF_WISDOM
end

function Paladin.InitBlessingOfWisdom()
    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Paladin.IsBlessingOfWisdom)
    event:AddAction(Paladin.BlessingOfWisdom)
end
    