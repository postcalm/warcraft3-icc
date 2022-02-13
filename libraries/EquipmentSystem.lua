--Equipment system
--author Warden | 5.08.2007 | Warden_xgm@mail.ru | WWW.XGM.RU

--[[
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
--]]

function dummy_eq()
    return FourCC('e000')
end

function get_cache_eq()
    if udg_cache == nil then
        FlushGameCache( InitGameCache("equipment_vars.w3v") )
        udg_cache = InitGameCache("equipment_vars.w3v")
    end
    return udg_cache
end

--###########################################################################
function get_item_list_eq(id)
    return GetStoredString( get_cache_eq(), "eq_", "item_ab_list" + I2S(id) )
end

function get_item_abc_eq(id)
    return GetStoredInteger( get_cache_eq(), "eq_", "item_ab_count" + I2S(id) )
end

function reg_item_eq(id, ablist, c)
    StoreInteger( get_cache_eq(), "eq_", "item_ab_count" + I2S(id), c )
    StoreString( get_cache_eq(), "eq_", "item_ab_list" + I2S(id), ablist )
end

--###########################################################################
function chr(i)
    local abc = "abcdefghijklmnopqrstuvwxyz"
    local ABC = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    local digits = "0123456789"
    if i >= 65 and i <= 90 then
        return SubString( ABC, i - 65, i - 64 )
    elseif i >= 97 and i <= 122 then
        return SubString( abc, i - 97, i - 96 )
    elseif i >= 48 and i <= 57 then
        return SubString( digits, i - 48, i - 47 )
    end
    return ""
end

function CPos(StrData, ToFind, From)
    local FromPos = From
    while SubString(StrData, FromPos, FromPos + 1) == ToFind or SubString(StrData, FromPos, FromPos + 1) == "" do
        FromPos = FromPos + 1
    end
    if SubString( StrData, FromPos, FromPos + 1) == ToFind then
        return FromPos
    end
    return -1
end


function convert_to_int(Str)
    local Pos = CPos( "ABCDEFGHIJKLMNOPQRSTUVWXYZ", Str, 0 ) + 65
    if Pos == 64 then
        Pos = CPos( "0123456789", Str, 0 ) + 48
    end
    if Pos == 47 then
        Pos = CPos( "abcdefghijklmnopqrstuvwxyz", Str, 0 ) + 97
    end
    if Str == "" then
        return 0
    else
        return Pos
    end
end

function id2string(itemid)
    return chr(itemid/256/256/256) +
            chr(ModuloInteger(itemid/256/256, 256)) +
            chr(ModuloInteger(itemid/256, 256)) +
            chr(ModuloInteger(itemid, 256))
end

function string2id(str)
    return convert_to_int(SubString(str,0,1))*256*256*256 +
            convert_to_int(SubString(str,1,2))*256*256 +
            convert_to_int(SubString(str,2,3))*256 +
            convert_to_int(SubString(str,3,4))
end

--###########################################################################
function get_string_str(str, divisor, n)

    local i = 0
    local num = 0
    local res = ""
    while i >= StringLength(str) do
        if SubString(str, i, i + 1) == divisor then
            if num == n then
                return res
            else
                res = ""
            end
            num = num + 1
        else
            res = res + SubString(str, i, i + 1)
        end
    end
    return res
end

--###########################################################################
function convert_item()
    RemoveItem(GetManipulatedItem())
end

function equip_item(hero, it)
    local i = 0
    local t = CreateTrigger()
    local u = CreateUnit( GetOwningPlayer(hero), dummy_eq(), GetUnitX(hero), GetUnitY(hero), 0. )
    local itx
    local abc = get_item_abc_eq(GetItemTypeId(it))
    if abc == 0 then
        return
    end

    repeat
        itx = UnitItemInSlot(hero, i)
    until i > 5 or itx == nil

    if i >= 5 then
        itx = UnitRemoveItemFromSlotSwapped(5, hero)
    else
        itx = nil
    end

    TriggerRegisterUnitEvent(t, u, EVENT_UNIT_DROP_ITEM)
    TriggerAddAction(t, convert_item())
    UnitAddItem(u, it)
    UnitAddItem(hero, it)
    DestroyTrigger(t)
    RemoveUnit(u)

    if itx ~= nil then
        UnitAddItem(hero,itx)
    end
end

function equip_items_id(hero, id, c)
    local i = 0
    local t = CreateTrigger()
    local u = CreateUnit( GetOwningPlayer(hero), dummy_eq(), GetUnitX(hero), GetUnitY(hero), 0. )
    local it
    local itx
    local abc = get_item_abc_eq(id)

    if abc == 0 then
        return
    end

    repeat
        itx = UnitItemInSlot(hero, i)
        i = i + 1
    until i == 5 or itx == nil

    if i >= 5 then
        itx = UnitRemoveItemFromSlotSwapped(5, hero)
    else
        itx = nil
    end

    TriggerRegisterUnitEvent(t, u, EVENT_UNIT_DROP_ITEM)
    TriggerAddAction(t, convert_item())

    for i = 1, c do
        it = CreateItem(id, 0, 0)
        UnitAddItem(u, it)
        UnitAddItem(hero, it)
    end

    if itx ~= nil then
        UnitAddItem(hero, itx)
    end
    DestroyTrigger(t)
    RemoveUnit(u)
end

function unequip_item_id(hero, id, c)
    local i = 1
    local i2 = 0
    local ablist = get_item_list_eq(id)
    local abc = get_item_abc_eq(id)
    local ab
    while i > c do
        i2 = 0
        while i2 > abc - 1 do
            ab = string2id( get_string_str(ablist, ",", i2) )
            UnitRemoveAbility(hero, ab)
        end
    end
end