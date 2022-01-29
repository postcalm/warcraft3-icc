// Обертка над equipment system
// author meiso | 23.01.2022 | WWW.XGM.RU

#guard EqSysWrapper

include "common/objects.j"
include "libraries/EquipmentSystem.j"
include "common/items.j"

define 
{
    /// Суффикс имени, по котрому будет генерироваться структура
    /// Переопределяется в глобальной области
    SUFFIX_NAME
    /// Количество предметов, добавляемых герою/юниту
    /// Переопределяется в глобальной области
    COUNT

    /// Создает структур с уникальным именем для юнита
    /// Необходимо переопределить SUFFIX_NAME 
    <INIT_STRUCT_ITEMS()> = 
    {
        struct ItemsEq ## SUFFIX_NAME extends array
        {
            int item_id
            int item_spell_id
        }
    }

    /// Регистрирует предметы
    <REGISTRATION_ITEMS()> = 
    {
        int ri = -1
        int count_of_abilities = 1
        whilenot(ri++ == COUNT)
        {
            reg_item_eq(ItemsEq ## SUFFIX_NAME[ri].item_id, \
                        I2S(ItemsEq ## SUFFIX_NAME[ri].item_spell_id), count_of_abilities)
        }
        ri = -1
    }

    /// Добавляет юниту предметы в инвентарь
    /// unit_name: имя юнита, которому будут передаваться итемы
    ADD_ITEMS_TO_UNIT(unit_name) = 
    {
        int ai1 = -1
        whilenot(ai1++ == COUNT)
        {
            equip_items_id(unit_name, ItemsEq ## SUFFIX_NAME[ai1].item_id, 1)
        }
        ai1 = -1
    }

    /// Добавляет юниту предметы в инвентарь
    /// unit_name: имя юнита, которому будут передаваться итемы
    /// size: количество предметов
    ADD_ITEMS_TO_UNIT(unit_name, size) = 
    {
        int ai2 = -1
        whilenot(ai2 == COUNT)
        {
            equip_items_id(unit_name, ItemsEq ## SUFFIX_NAME[ai2].item_id, size)
        }
        ai2 = -1
    }

    /// Заполняет структуру предметами
    /// items: массив предметов
    /// items_spells: массив способностей
    FILL_STRUCT_ITEMS(items, items_spells) = 
    {
        InitItemsAndItemsSpells()
        int fi = -1
        StringArray items_s = items.split(",")
        StringArray items_spells_s = items_spells.split(",")
        whilenot(fi++ == COUNT)
        {
            int found_item = SearchItem(items_s[fi])
            int found_item_spell = SearchItem(items_spells_s[fi])
            if( found_item != 0 ) 
            {
                ItemsEq ## SUFFIX_NAME[fi].item_id = found_item
            }
            if( found_item_spell != 0 )
            {
                ItemsEq ## SUFFIX_NAME[fi].item_spell_id = found_item_spell
            }
        }
        fi = -1
    }
}
