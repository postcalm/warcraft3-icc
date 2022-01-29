//  Equipment system
//  author Warden | 5.08.2007 | Warden_xgm@mail.ru | WWW.XGM.RU

/*
>> Для работы системы требуется :

1. Триггер "equipment system" / скрипт включенный в карту
2. Переменная типа "буфер игры" (Записанная в функцию "get_cache_eq")
3. Юнит со способностью "предметы(герой)" (Записанный в функцию "dummy_eq")

>> Основные функции :

1. function equip_item takes unit hero, item it returns nothing
2. function equip_items_id takes unit hero, integer id, integer c returns nothing
3. function unequip_item_id takes unit hero, integer id, integer c returns nothing
4. function reg_item_eq takes integer id, string ablist, integer c returns nothing

1. Добавляет герою (hero) невидимый предмет (it)
2. Добавляет герою (hero) невидимый предмет типа (id), (c) раза
3. Удаляет у героя (hero) невидимый предмет типа (id), (c) раза
4. Регистрирует предмет типа (id), со способностями (ablist), с количеством способностей (c)

>> Примечания :

1. в 'ablist' записываются id способностей предмета, без тегов и через запятую (Например : "I000,I001")
*/

#guard EquipmentSystem

library EquipmentSystem
{
    int dummy_eq()
    {
        return 'e000'
    }

    gamecache get_cache_eq()
    {
        if(udg_cache == null)
        {
            FlushGameCache( InitGameCache("equipment_vars.w3v") )
            udg_cache = InitGameCache("equipment_vars.w3v")
        }
        return udg_cache
    }

    //###########################################################################
    string get_item_list_eq(int id)
    {
        return GetStoredString( get_cache_eq(), "eq_", "item_ab_list" + I2S(id) )
    }

    int get_item_abc_eq(int id)
    {
        return GetStoredInteger( get_cache_eq(), "eq_", "item_ab_count" + I2S(id) )
    }

    void reg_item_eq(int id, string ablist, int c)
    {
        StoreInteger( get_cache_eq(), "eq_", "item_ab_count" + I2S(id), c )
        StoreString( get_cache_eq(), "eq_", "item_ab_list" + I2S(id), ablist )
    }

    //###########################################################################
    string chr(int i)
    {
        string abc = "abcdefghijklmnopqrstuvwxyz"
        string ABC = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        string digits = "0123456789"
        if( i >= 65 and i <= 90 )
        {
            return SubString( ABC, i - 65, i - 64 )
        }
        elseif( i >= 97 and i <= 122 )
        {
            return SubString( abc, i - 97, i - 96 )
        }
        elseif( i >= 48 and i <= 57 )
        {
            return SubString( digits, i - 48, i - 47 )
        }
        return ""
    }

    int CPos(string StrData, string ToFind, int From)
    {
        int FromPos = From
        whilenot( SubString(StrData, FromPos, FromPos + 1) == ToFind or SubString(StrData, FromPos, FromPos + 1) == "" )
        {
            FromPos++
        }
                    
        if( SubString( StrData, FromPos, FromPos + 1) == ToFind )
        {
            return FromPos
        }
        return -1
    }
    

    int convert_to_int(string Str)
    {
        int Pos = CPos( "ABCDEFGHIJKLMNOPQRSTUVWXYZ", Str, 0 ) + 65
        if(Pos == 64)
        {
            Pos = CPos( "0123456789", Str, 0 ) + 48
        }
        if(Pos == 47)
        {
            Pos = CPos( "abcdefghijklmnopqrstuvwxyz", Str, 0 ) + 97
        }
        if(Str == "")
        {
            return 0
        }
        else
        {
            return Pos
        }
    }

    string id2string(int itemid)
    {
        return chr(itemid/256/256/256) + \
                chr(ModuloInteger(itemid/256/256, 256)) + \
                chr(ModuloInteger(itemid/256, 256)) + \
                chr(ModuloInteger(itemid, 256))
    }

    int string2id(string str)
    {
        return convert_to_int(SubString(str,0,1))*256*256*256 + \
                convert_to_int(SubString(str,1,2))*256*256 + \
                convert_to_int(SubString(str,2,3))*256 + \
                convert_to_int(SubString(str,3,4))
    }

    //###########################################################################
    string get_string_str(string str, string divisor, int n)
    {
        int i = 0
        int num = 0
        string res = ""
        whilenot( i >= StringLength(str) )
        {
            if( SubString(str, i, i + 1) == divisor )
            {
                if(num == n) { return res }
                else { res = "" }

                num++
            }
            else
            {
                res = res + SubString(str, i, i + 1)
            }
        }
        return res
    }

    //###########################################################################
    void convert_item()
    {
        RemoveItem(GetManipulatedItem())
    }

    void equip_item(unit hero, item it)
    {
        int i = 0
        trigger t = CreateTrigger()
        unit u = CreateUnit( GetOwningPlayer(hero), dummy_eq(), GetUnitX(hero), GetUnitY(hero), 0. )
        item itx
        integer abc = get_item_abc_eq(GetItemTypeId(it))
        if(abc == 0)
        {
            return
        }
        
        do
        {
            itx=UnitItemInSlot(hero, i)
        } whilenot( i > 5 or itx == null )
        
        if(i >= 5)
        {
            itx = UnitRemoveItemFromSlotSwapped(5, hero)
        }
        else
        {
            itx = null
        }
        
        TriggerRegisterUnitEvent(t, u, EVENT_UNIT_DROP_ITEM)
        TriggerAddAction(t, function convert_item)
        UnitAddItem(u, it)
        UnitAddItem(hero, it)
        DestroyTrigger(t)
        RemoveUnit(u)
        
        if(itx != null)
        {
            UnitAddItem(hero,itx)
        }
        
        t = null
        u = null
        it = null
        itx = null
    }

    void equip_items_id(unit hero, int id, int c)
    {
        int i = 0
        trigger t = CreateTrigger()
        unit u = CreateUnit( GetOwningPlayer(hero), dummy_eq(), GetUnitX(hero), GetUnitY(hero), 0. )
        item it
        item itx
        int abc = get_item_abc_eq(id)
        
        if(abc == 0) { return }
        
        // тут переход на cJass не удался
        // при конвертации в jass, проверка выходит за область цикла
        do {
            itx = UnitItemInSlot(hero, i)
            exitwhen i == 5 or itx == null
            i++
        }
    
        if(i >= 5)
        {
            itx = UnitRemoveItemFromSlotSwapped(5, hero)
        }
        else
        {
            itx = null
        }
        
        i = 1
    
        TriggerRegisterUnitEvent(t, u, EVENT_UNIT_DROP_ITEM)
        TriggerAddAction(t, function convert_item)
    
        whilenot( i++ > c )
        {
            it = CreateItem(id, 0, 0)
            UnitAddItem(u, it)
            UnitAddItem(hero, it)
        }
    
        if(itx != null)
        {
            UnitAddItem(hero, itx)
        }
        DestroyTrigger(t)
        RemoveUnit(u)
        t = null
        u = null
        it = null
        itx = null
    }

    void unequip_item_id(unit hero, int id, int c)
    {
        int i = 1
        int i2 = 0
        string ablist = get_item_list_eq(id)
        int abc = get_item_abc_eq(id)
        int ab
        whilenot( i > c )
        {
            i2 = 0
            whilenot( i2 > abc - 1 )
            {
                ab = string2id( get_string_str(ablist, ",", i2) )
                UnitRemoveAbility(hero, ab)
            }
        }
        
        ablist = null
    }

}