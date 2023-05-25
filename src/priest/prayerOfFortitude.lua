-- Copyright (c) meiso

function Priest.SetPrayerOfFortitude()
    --TODO: пока что даём как есть. потом отскалируем
    local items = { "PRAYER_OF_FORTITUDE_ITEM" }
    local items_spells = { "HP_165_POF" }

    EquipSystem.RegisterItems(items, items_spells)

    local function act()
        local u = Unit(GetEnumUnit())
        EquipSystem.RemoveItemsToUnit(u, items)
        if u:HasBuff(PRAYER_OF_FORTITUDE_BUFF) then
            EquipSystem.AddItemsToUnit(u, items)
        end
    end

    Priest.hero:UseSpellFunc {
        location = Priest.hero:GetLoc(),
        --а здесь наоборот должна быть больше
        radius = 30,
        func = act
    }
end

function Priest.InitPrayerOfFortitude()
    --эта кастомная аура по сути перманентна
    prayer_of_fortitude:Init()

    local set_buff = EventsUnit(Priest.hero)
    --здесь дистанция прока ауры должна быть меньше чем задана в редакторе,
    --иначе ивент не будет цеплять юнитов на краю зоны ауры
    set_buff:RegisterWithinRange(19.)
    set_buff:AddAction(Priest.SetPrayerOfFortitude)
end
