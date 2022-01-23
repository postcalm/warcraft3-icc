
define 
{
    /// Регистрирует предметы, назначая им способности
    /// items: структура, содержащая id предметов и их способности
    /// count: количество предметов в структуре
    REGISTRATION_ITEMS(items, count) = {
        int ri = 0
        whilenot(ri++ == count)
        {
            reg_item_eq(items[ri].item_id, \
                        I2S(items[ri].spell_item_id), 1)
        }
    }

    /// Добавляет юниту предметы в инвентарь
    /// unit_name: имя юнита, которому будут передаваться итемы
    /// items: структура, содержащая id предметов и их способности
    /// count: количество предметов в структуре
    ADD_ITEMS_TO_UNIT(unit_name, items, count) = {
        int ai = 0
        whilenot(ai++ == count)
        {
            equip_items_id(unit_name, items[ai].item_id, 1)
        }
    }

    /// Создает структур с уникальным именем для юнита
    /// NOTE: Использовать только в глобальной области!
    /// name: идентификатор юнита
    INIT_ITEMS_STRUCT(name, size) = {
        struct Items##name
        {
            int array item_id[size]
            int array spell_item_id[size]
        }

        type ItemsId##name extends int array[size]

        type SpellsItemsId##name extends int array[size]
    }

    /// 
    FILL_STRUCT_ITEMS(items) = 
    {
        sBJDebugMsg("%v")
    }
}
