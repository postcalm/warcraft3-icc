
function RemoveBlessingOfWisdom(unit, items_list)
    EquipSystem.RemoveItemsToUnit(unit, items_list)
    BuffSystem.RemoveBuffToHero(unit, "bow")
    DestroyTimer(GetExpiredTimer())
end

function BlessingOfWisdom()
    local unit = GetSpellTargetUnit()
    local items_list = {"BLESSING_OF_WISDOM_ITEM"}
    local items_spells_list = {"BLESSING_OF_WISDOM"}

    BuffSystem.RegisterHero(unit)
    EquipSystem.RegisterItems(items_list, items_spells_list)

    if not BuffSystem.IsBuffOnHero(unit, "bow") then
        EquipSystem.AddItemsToUnit(unit, items_list)
        BuffSystem.AddBuffToHero(unit, "bow")

        local remove_buff = function() RemoveBlessingOfWisdom(unit, items_list) end
        local tm = CreateTimer()
        TimerStart(tm, 600., false, remove_buff)
    end
end

function IsBlessingOfWisdom()
    return GetSpellAbilityId() == BLESSING_OF_WISDOM
end

function Init_BlessingOfWisdom()
    local trigger_buff = CreateTrigger()
    TriggerRegisterPlayerUnitEvent(trigger_buff, Player(0), EVENT_PLAYER_UNIT_SPELL_CAST, nil)
    TriggerAddCondition(trigger_buff, Condition(IsBlessingOfWisdom))
    TriggerAddAction(trigger_buff, BlessingOfWisdom)
end
    