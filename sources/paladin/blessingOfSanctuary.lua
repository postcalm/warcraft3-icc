
function Paladin.RemoveBlessingOfSanctuary(unit, stat, items_list)
    if BuffSystem.IsBuffOnHero(unit, "BlessingOfSanctuary") then
        SetHeroStr(unit, GetHeroStr(unit, false) - stat, false)
        EquipSystem.RemoveItemsToUnit(unit, items_list)
        BuffSystem.RemoveBuffToHero(unit, "BlessingOfSanctuary")
    end
    DestroyTimer(GetExpiredTimer())
end

function Paladin.BlessingOfSanctuary()
    local unit = GetSpellTargetUnit()
    local items_list = {"DEC_DMG_ITEM"}
    local items_spells_list = {"DECREASE_DMG"}

    BuffSystem.RegisterHero(unit)
    EquipSystem.RegisterItems(items_list, items_spells_list)

    if not BuffSystem.IsBuffOnHero(unit, "BlessingOfSanctuary") then
        EquipSystem.AddItemsToUnit(unit, items_list)
        local stat = R2I(GetHeroStr(unit, false) * 0.1)
        SetHeroStr(unit, GetHeroStr(unit, false) + stat, false)

        local remove_buff = function() Paladin.RemoveBlessingOfSanctuary(unit, stat, items_list) end
        local timer = CreateTimer()

        BuffSystem.AddBuffToHero(unit, "BlessingOfSanctuary", remove_buff)

        TimerStart(timer, 600., false, remove_buff)
    end
end

function Paladin.IsBlessingOfSanctuary()
    return GetSpellAbilityId() == BLESSING_OF_SANCTUARY
end

function Paladin.InitBlessingOfSanctuary()
    local event = EventsPlayer(PLAYER_1)
    event:RegisterUnitSpellCast()
    event:AddCondition(Paladin.IsBlessingOfSanctuary)
    event:AddAction(Paladin.BlessingOfSanctuary)
end
