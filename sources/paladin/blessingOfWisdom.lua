
function Paladin.RemoveBlessingOfWisdom(unit, items_list)
    if BuffSystem.IsBuffOnHero(unit, "BlessingOfWisdom") then
        EquipSystem.RemoveItemsToUnit(unit, items_list)
        BuffSystem.RemoveBuffToHero(unit, "BlessingOfWisdom")
    end
    DestroyTimer(GetExpiredTimer())
end

function Paladin.BlessingOfWisdom()
    local unit = GetSpellTargetUnit()
    local items_list = {"BLESSING_OF_WISDOM_ITEM"}
    local items_spells_list = {"BLESSING_OF_WISDOM"}

    BuffSystem.RegisterHero(unit)
    EquipSystem.RegisterItems(items_list, items_spells_list)

    Paladin.hero:LoseMana{percent=5}

    if not BuffSystem.IsBuffOnHero(unit, "BlessingOfWisdom") then
        EquipSystem.AddItemsToUnit(unit, items_list)

        local remove_buff = function() Paladin.RemoveBlessingOfWisdom(unit, items_list) end
        local timer = CreateTimer()
        BuffSystem.AddBuffToHero(unit, "BlessingOfWisdom", remove_buff)

        TimerStart(timer, 600., false, remove_buff)
    end
end

function Paladin.IsBlessingOfWisdom()
    return GetSpellAbilityId() == BLESSING_OF_WISDOM
end

function Paladin.InitBlessingOfWisdom()
    local event = EventsPlayer(PLAYER_1)
    event:RegisterUnitSpellCast()
    event:AddCondition(Paladin.IsBlessingOfWisdom)
    event:AddAction(Paladin.BlessingOfWisdom)
end
    