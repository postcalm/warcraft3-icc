
function RemoveBlessingOfSanctuary(unit, stat, items_list)
    SetHeroStr(unit, GetHeroStr(unit, false) - stat, false)
    EquipSystem.RemoveItemsToUnit(unit, items_list)
    BuffSystem.RemoveBuffToHero(unit, "BlessingOfSanctuary")
    DestroyTimer(GetExpiredTimer())
end

function BlessingOfSanctuary()
    local unit = GetSpellTargetUnit()
    local items_list = {"DEC_DMG_ITEM"}
    local items_spells_list = {"DECREASE_DMG"}

    BuffSystem.RegisterHero(unit)
    EquipSystem.RegisterItems(items_list, items_spells_list)

    if not BuffSystem.IsBuffOnHero(unit, "BlessingOfSanctuary") then
        EquipSystem.AddItemsToUnit(unit, items_list)
        local stat = R2I(GetHeroStr(unit, false) * 0.1)
        SetHeroStr(unit, GetHeroStr(unit, false) + stat, false)
        BuffSystem.AddBuffToHero(unit, "BlessingOfSanctuary")

        local remove_buff = function() RemoveBlessingOfSanctuary(unit, stat, items_list) end
        local tm = CreateTimer()
        TimerStart(tm, 600., false, remove_buff)
    end
end

function IsBlessingOfSanctuary()
    return GetSpellAbilityId() == BLESSING_OF_SANCTUARY
end

function Init_BlessingOfSanctuary()
    local event = EventsPlayer(Player(0))
    event:RegisterUnitSpellCast()
    event:AddCondition(IsBlessingOfSanctuary)
    event:AddAction(BlessingOfSanctuary)
end
