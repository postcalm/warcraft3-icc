// Обертка над equipment system
// author meiso | 23.01.2022

define 
{
    /// Регистрирует предметы, назначая им способности
    /// items: структура, содержащая id предметов и их способности
    /// count: количество предметов в структуре
    REGISTRATION_ITEMS(items, count) = {
        int ri = -1
        whilenot(ri++ == count)
        {
            reg_item_eq(items[ri].item_id, \
                        I2S(items[ri].item_spell_id), 1)
        }
    }

    /// Добавляет юниту предметы в инвентарь
    /// unit_name: имя юнита, которому будут передаваться итемы
    /// items: структура, содержащая id предметов и их способности
    /// count: количество предметов в структуре
    ADD_ITEMS_TO_UNIT(unit_name, items, count) = {
        int ai = -1
        whilenot(ai++ == count)
        {
            equip_items_id(unit_name, items[ai].item_id, 1)
        }
    }

    /// Создает структур с уникальным именем для юнита
    /// NOTE: Использовать только в глобальной области!
    /// name: идентификатор юнита
    INIT_STRUCT_ITEMS(name) = {
        struct ItemsEq ## name extends array
        {
            int item_id
            int item_spell_id
        }
    }

    /// Заполняет структуру предметами
    /// items: массив предметов
    /// items_spells: массив способностей
    /// struct_s: заполняемая структура
    FILL_STRUCT_ITEMS(items, items_spells, struct_s) = 
    {
        InitItemsAndItemsSpells()
        int fi = -1
        StringArray items_s = items.split(",")
        StringArray items_spells_s = items_spells.split(",")
        whilenot(fi++ == 3)
        {
            if( Items[fi].getIdByName(items_s[fi]) != 0 ) 
            {
                struct_s[fi].item_id = Items[fi].item_id
            }
            if( ItemsSpells[fi].getIdByName(items_spells_s[fi]) != 0 )
            {
                struct_s[fi].item_spell_id = ItemsSpells[fi].item_spell_id
            }
        }
    }
}
