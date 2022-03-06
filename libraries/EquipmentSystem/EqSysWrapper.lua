--- Created by meiso.
--- DateTime: 23.02.2022 21:29

EquipSystem = {}

--- Регистрирует предмет со способностями.
--- Последовательность имен в массивах должна сохраняться
---@param items string Список предметов
---@param items_spells string Список способностей предметов
function EquipSystem.RegisterItems(items, items_spells)
    local count = 1
    local items_ = zip(items, items_spells)
    for _, item in pairs({table.unpack(items_)}) do
        reg_item_eq(Items[item[1]], ItemsSpells[item[2]].str, count)
    end
end

--- Добавляет юниту некоторое количество предметов
---@param unit unit Id юнита
---@param items string Список предметов
---@param count int Количество предметов
function EquipSystem.AddItemsToUnit(unit, items, count)
    count = count or 1
    for _, item in pairs(items) do
        equip_items_id(unit, Items[item], count)
    end
end

--- Удаляет у юнита некоторое количество предметов
---@param unit unit Id юнита
---@param items string Список предметов
---@param count int Количество предметов
function EquipSystem.RemoveItemsToUnit(unit, items, count)
    count = count or 1
    for _, item in pairs(items) do
        unequip_item_id(unit, Items[item], count)
    end
end