// Обертка над equipment system
// author meiso | 23.01.2022

define 
{
    SUFFIX_NAME
    SIZE
    /// Регистрирует предметы, назначая им способности
    /// items: структура, содержащая id предметов и их способности
    /// count: количество предметов в структуре
    <REGISTRATION_ITEMS()> = {
        int ri = -1
        whilenot(ri++ == SIZE)
        {
            reg_item_eq(ItemsEq ## SUFFIX_NAME[ri].item_id, \
                        I2S(ItemsEq ## SUFFIX_NAME[ri].item_spell_id), 1)
        }
    }

    /// Добавляет юниту предметы в инвентарь
    /// unit_name: имя юнита, которому будут передаваться итемы
    /// items: структура, содержащая id предметов и их способности
    /// count: количество предметов в структуре
    ADD_ITEMS_TO_UNIT(unit_name) = {
        int ai = -1
        whilenot(ai++ == SIZE)
        {
            equip_items_id(unit_name, ItemsEq ## SUFFIX_NAME[ai].item_id, 1)
        }
    }

    /// Создает структур с уникальным именем для юнита
    /// NOTE: Использовать только в глобальной области!
    /// name: идентификатор юнита
    <INIT_STRUCT_ITEMS()> = {
        struct ItemsEq ## SUFFIX_NAME extends array
        {
            int item_id
            int item_spell_id
        }
    }

    /// Заполняет структуру предметами
    /// items: массив предметов
    /// items_spells: массив способностей
    /// struct_s: заполняемая структура
    FILL_STRUCT_ITEMS(items, items_spells) = 
    {
        InitItemsAndItemsSpells()
        int fi = -1
        StringArray items_s = items.split(",")
        StringArray items_spells_s = items_spells.split(",")
        whilenot(fi++ == SIZE)
        {
            if( Items[fi].getIdByName(items_s[fi]) != 0 ) 
            {
                ItemsEq ## SUFFIX_NAME[fi].item_id = Items[fi].item_id
            }
            if( ItemsSpells[fi].getIdByName(items_spells_s[fi]) != 0 )
            {
                ItemsEq ## SUFFIX_NAME[fi].item_spell_id = ItemsSpells[fi].item_spell_id
            }
        }
    }
}
