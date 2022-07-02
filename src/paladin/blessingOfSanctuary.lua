
function Paladin.RemoveBlessingOfSanctuary(unit, stat, items_list, timer)
    if BuffSystem.IsBuffOnHero(unit, BLESSING_OF_SANCTUARY) then
        SetHeroStr(unit, GetHeroStr(unit, false) - stat, false)
        EquipSystem.RemoveItemsToUnit(unit, items_list)
        BuffSystem.RemoveBuffToHero(unit, BLESSING_OF_SANCTUARY)
    end
    DestroyTimer(timer)
end

function Paladin.BlessingOfSanctuary()
    local unit = GetSpellTargetUnit()
    local items_list = {"DEC_DMG_ITEM"}
    local items_spells_list = {"DECREASE_DMG"}

    BuffSystem.RegisterHero(unit)
    EquipSystem.RegisterItems(items_list, items_spells_list)

    if BuffSystem.IsBuffOnHero(unit, BLESSING_OF_SANCTUARY) then
        BuffSystem.RemoveBuffToHeroByFunc(unit, BLESSING_OF_SANCTUARY)
    end

    EquipSystem.AddItemsToUnit(unit, items_list)
    local stat = R2I(GetHeroStr(unit, false) * 0.1)
    SetHeroStr(unit, GetHeroStr(unit, false) + stat, false)

    local timer = CreateTimer()
    local remove_buff = function() Paladin.RemoveBlessingOfSanctuary(unit, stat, items_list, timer) end

    BuffSystem.AddBuffToHero(unit, BLESSING_OF_SANCTUARY, remove_buff)

    TimerStart(timer, 600., false, remove_buff)
end

function Paladin.IsBlessingOfSanctuary()
    return GetSpellAbilityId() == BLESSING_OF_SANCTUARY
end

function Paladin.InitBlessingOfSanctuary()
    Ability(
            BLESSING_OF_SANCTUARY,
            "Благословение неприкосновенности (X)",
            "Благословляет дружественную цель, уменьшая любой наносимый ей урон на 3% и " ..
            "повышая ее силу и выносливость на 10%. Эффект длится 10 мин."
    )
    Paladin.hero:SetAbilityManacost(BLESSING_OF_SANCTUARY, 7)
    Paladin.hero:SetAbilityCooldown(BLESSING_OF_SANCTUARY, 1.5)

    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Paladin.IsBlessingOfSanctuary)
    event:AddAction(Paladin.BlessingOfSanctuary)
end
