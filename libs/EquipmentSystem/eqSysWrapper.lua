-- Copyright (c)  meiso

--Обёртка над системой экипировки

EquipSystem = {}

--- Регистрирует предмет со способностями.
--- Последовательность имен в массивах должна сохраняться
---@param items string Список предметов
---@param items_spells string Список способностей предметов
---@return nil
function EquipSystem.RegisterItems(items, items_spells)
    local count = 1
    local items_ = zip(items, items_spells)
    for _, item in pairs({ table.unpack(items_) }) do
        reg_item_eq(Items[item[1]], ItemsSpells[item[2]].str, count)
    end
end

--- Добавляет юниту некоторое количество предметов
---@param unit unit Id юнита или от класса Unit
---@param items string Список предметов
---@param count int Количество предметов
---@return nil
function EquipSystem.AddItemsToUnit(unit, items, count)
    local c = count or 1
    local u = unit
    if type(unit) == "table" then
        u = unit:GetId()
    end
    for _, item in pairs(items) do
        equip_items_id(u, Items[item], c)
    end
end

--- Удаляет у юнита некоторое количество предметов
---@param unit unit Id юнита или от класса Unit
---@param items string Список предметов
---@param count int Количество предметов
---@return nil
function EquipSystem.RemoveItemsToUnit(unit, items, count)
    local c = count or 1
    local u = unit
    if type(unit) == "table" then
        u = unit:GetId()
    end
    for _, item in pairs(items) do
        unequip_item_id(u, Items[item], c)
    end
end
