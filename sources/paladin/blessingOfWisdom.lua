
function RemoveBlessingOfWisdom(unit, items_list)
    if BuffSystem.IsBuffOnHero(unit, "BlessingOfWisdom") then
        EquipSystem.RemoveItemsToUnit(unit, items_list)
        BuffSystem.RemoveBuffToHero(unit, "BlessingOfWisdom")
    end
    DestroyTimer(GetExpiredTimer())
end

function BlessingOfWisdom()
    local unit = GetSpellTargetUnit()
    local items_list = {"BLESSING_OF_WISDOM_ITEM"}
    local items_spells_list = {"BLESSING_OF_WISDOM"}

    BuffSystem.RegisterHero(unit)
    EquipSystem.RegisterItems(items_list, items_spells_list)

    if not BuffSystem.IsBuffOnHero(unit, "BlessingOfWisdom") then
        EquipSystem.AddItemsToUnit(unit, items_list)

        local remove_buff = function() RemoveBlessingOfWisdom(unit, items_list) end
        local timer = CreateTimer()
        BuffSystem.AddBuffToHero(unit, "BlessingOfWisdom", remove_buff)

        TimerStart(timer, 600., false, remove_buff)
    end
end

function IsBlessingOfWisdom()
    return GetSpellAbilityId() == BLESSING_OF_WISDOM
end

function Init_BlessingOfWisdom()
    local event = EventsPlayer(Player(0))
    event:RegisterUnitSpellCast()
    event:AddCondition(IsBlessingOfWisdom)
    event:AddAction(BlessingOfWisdom)
end
    