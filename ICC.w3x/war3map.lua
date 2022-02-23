udg_My_hero = {}
udg_My_y = __jarray(0.0)
udg_My_index = 0
udg_My_x = __jarray(0.0)
udg_My_type = __jarray(0)
udg_SaveUnit_ability = __jarray(0)
udg_SaveUnit_y = 0.0
udg_SaveUnit_g1 = 0
udg_SaveUnit_g2 = 0
udg_SaveUnit_gamecache = nil
udg_SaveUnit_map_number = 0
udg_SaveUnit_hero_ability = __jarray(0)
udg_SaveUnit_unit = nil
udg_SaveUnit_user_data = __jarray(0)
udg_SaveUnit_x = 0.0
udg_SaveUnit_bool = false
udg_SaveUnit_author = 0
udg_SaveUnit_data = __jarray(0)
udg_SaveUnit_directory = ""
udg_cache = nil
gg_rct_RespawZone = nil
gg_rct_areaLM = nil
gg_rct_areaLD = nil
gg_trg_Pal = nil
gg_trg_INIT = nil
gg_trg_UNIT_DEATH = nil
gg_trg_Cmd_new = nil
gg_trg_Init = nil
gg_trg_Save_unit_hero_ability = nil
gg_trg_SaveUnit_load = nil
gg_trg_SaveUnit_save = nil
function InitGlobals()
    local i = 0
    i = 0
    while (true) do
        if ((i > 1)) then break end
        udg_My_y[i] = 0.0
        i = i + 1
    end
    udg_My_index = 0
    i = 0
    while (true) do
        if ((i > 1)) then break end
        udg_My_x[i] = 0.0
        i = i + 1
    end
    i = 0
    while (true) do
        if ((i > 1)) then break end
        udg_My_type[i] = 0
        i = i + 1
    end
    udg_SaveUnit_y = 0.0
    udg_SaveUnit_g1 = 0
    udg_SaveUnit_g2 = 0
    udg_SaveUnit_map_number = 0
    i = 0
    while (true) do
        if ((i > 1)) then break end
        udg_SaveUnit_user_data[i] = 0
        i = i + 1
    end
    udg_SaveUnit_x = 0.0
    udg_SaveUnit_bool = false
    udg_SaveUnit_author = 0
    i = 0
    while (true) do
        if ((i > 1)) then break end
        udg_SaveUnit_data[i] = 0
        i = i + 1
    end
    udg_SaveUnit_directory = ""
end

function CreateUnitsForPlayer0()
    local p = Player(0)
    local u
    local unitID
    local t
    local life
    u = CreateUnit(p, FourCC("Hpal"), 4482.6, 329.9, 110.510)
    u = CreateUnit(p, FourCC("Hpal"), 4096.3, -8835.7, 171.755)
    u = CreateUnit(p, FourCC("Hpal"), 3839.9, -2903.6, 90.000)
    SetHeroLevel(u, 80, false)
    SetUnitState(u, UNIT_STATE_MANA, 800)
    u = CreateUnit(p, FourCC("Hpal"), 4062.6, -5020.2, 109.900)
end

function CreateUnitsForPlayer1()
    local p = Player(1)
    local u
    local unitID
    local t
    local life
    u = CreateUnit(p, FourCC("Hpal"), 4291.2, -2880.6, 52.820)
    SetHeroLevel(u, 80, false)
end

function CreateUnitsForPlayer10()
    local p = Player(10)
    local u
    local unitID
    local t
    local life
    u = CreateUnit(p, FourCC("U001"), 4067.0, -1663.7, 270.000)
    SetHeroLevel(u, 83, false)
    SetHeroStr(u, 15, true)
    SetHeroAgi(u, 14, true)
    SetHeroInt(u, 1, true)
    u = CreateUnit(p, FourCC("U000"), 4095.6, 1498.8, 270.000)
    SetHeroLevel(u, 10, false)
    u = CreateUnit(p, FourCC("h002"), 4420.7, -1759.2, 86.040)
    u = CreateUnit(p, FourCC("ugho"), 3227.7, -3737.3, 12.610)
    u = CreateUnit(p, FourCC("ugho"), 3214.7, -3584.5, 263.720)
    u = CreateUnit(p, FourCC("ugho"), 3371.0, -3728.6, 246.840)
end

function CreatePlayerBuildings()
end

function CreatePlayerUnits()
    CreateUnitsForPlayer0()
    CreateUnitsForPlayer1()
    CreateUnitsForPlayer10()
end

function CreateAllUnits()
    CreatePlayerBuildings()
    CreatePlayerUnits()
end

function CreateRegions()
    local we
    gg_rct_RespawZone = Rect(3936.0, -3616.0, 4256.0, -3168.0)
    gg_rct_areaLM = Rect(3040.0, -2688.0, 5184.0, -1056.0)
    gg_rct_areaLD = Rect(2944.0, -128.0, 5248.0, 1984.0)
end

--CUSTOM_CODE

AREA_LM = gg_rct_areaLM
AREA_LD = gg_rct_areaLD


--Paladin
BUFF_GBK = FourCC('B000')
JUDGEMENT_OF_LIGHT_BUFF = FourCC('B002')
JUDGEMENT_OF_WISDOM_BUFF = FourCC('B003')



Items = {
    FourCC('I001'), --ARMOR_ITEM
    FourCC('I000'), --ATTACK_ITEM
    FourCC('I002'), --HP_ITEM
    FourCC('I003'), --MAGICARMOR_ITEM
    FourCC('I004'), --DEC_DMG_ITEM
    FourCC('I005')  --BLESSING_OF_WISDOM_ITEM
}

ItemsSpells = {
    FourCC('A008'), --ARMOR_500
    FourCC('A007'), --ATTACK_1500
    FourCC('A00D'), --HP_90K
    FourCC('A00I'), --MAGICARMOR_500
    FourCC('A00K'), --DECREASE_DMG
    FourCC('A00F')  --BLESSING_OF_WISDOM
}


--Lord Marrowgar
BONE_SPIKE_OBJ = FourCC('h000')
COLDFLAME_OBJ = FourCC('h001')

--Common
DUMMY = FourCC('h002')
DUMMY_EQUIP = FourCC('e000')


--Lord Marrowgar
COLDFLAME = FourCC("A001")
WHIRLWIND = FourCC("A005")

--Paladin
DIVINE_SHIELD           = FourCC("AHds")
CONSECRATION            = FourCC("A009")
CONSECRATION_TR         = FourCC("A00A")
HAMMER_RIGHTEOUS        = FourCC("A00B")
BLESSING_OF_KINGS       = FourCC("A00C")
BLESSING_OF_SANCTUARY   = FourCC("A00H")
BLESSING_OF_WISDOM      = FourCC("A00G")
BLESSING_OF_MIGHT       = FourCC("A00M")
CRUSADER_AURA           = FourCC("A00J")
DEVOTION_AURA           = FourCC("AHhb")
JUDGEMENT_OF_LIGHT      = FourCC("A00N")
JUDGEMENT_OF_LIGHT_TR   = FourCC("A00P")
JUDGEMENT_OF_WISDOM     = FourCC("A00O")
JUDGEMENT_OF_WISDOM_TR  = FourCC("A00Q")
SHIELD_OF_RIGHTEOUSNESS = FourCC("A00R")
AVENGERS_SHIELD         = FourCC("A004")
SPELLBOOK_PALADIN       = FourCC("A00L")



--tanks
PALADIN = FourCC("Hpal")
DEATH_KNIGHT = nil
WARRIOR = nil
--damage dealers
WARLOCK = nil
HUNTER = nil
ROGUE = nil
MAGE = nil
--healers
DRIUD = nil
SHAMAN = nil
PRIEST = nil
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
---@author Vlod | WWW.XGM.RU
---@author meiso | WWW.XGM.RU

--- Область, за которой следует номер карты
SCOPE_MAP        = 2
--- Область, за которой следуют данные о ресурсах игрока
SCOPE_RESOURCES  = 3
--- Область, за которой следуют данные о юните (положение, хп, мана)
SCOPE_HERO_DATA  = 4
--- Область, за которой следуют данные о количестве skill points
SCOPE_HERO_SKILL = 5
--- Область, за которой следуют данные о характеристиках
SCOPE_STATE      = 6
--- Область, за которой следуют данные о способностях героя
SCOPE_ABILITIES  = 7
--- Область, за которой следуют данные об имеющихся предметах
SCOPE_ITEMS      = 8

MAGIC_NUMBER_ONE   = 18259200
MAGIC_NUMBER_TWO   = 44711
MAGIC_NUMBER_THREE = 259183
MAGIC_NUMBER_FOUR  = 129593
MAGIC_NUMBER_FIVE  = 259200
MAGIC_NUMBER_SIX   = 54773
MAGIC_NUMBER_SEVEN = 7141
MAGIC_NUMBER_EIGHT = 421
MAGIC_NUMBER_NINE  = 259199

--- Возрождает юнита
function UnitsRespawn()
    local u = GetTriggerUnit()
    if IsUnitType(u, UNIT_TYPE_HERO) == true  then
        TriggerSleepAction(5)
        ReviveHero(u, udg_SaveUnit_x, udg_SaveUnit_y, false)
    end
end

--- Сохраняет способности героя
function SaveHeroAbilities()
    udg_SaveUnit_hero_ability[1] = DEVOTION_AURA
    udg_SaveUnit_hero_ability[2] = DIVINE_SHIELD
    udg_SaveUnit_hero_ability[3] = CONSECRATION
    udg_SaveUnit_hero_ability[4] = CONSECRATION_TR
    udg_SaveUnit_hero_ability[5] = HAMMER_RIGHTEOUS
    udg_SaveUnit_hero_ability[6] = JUDGEMENT_OF_LIGHT_TR
    udg_SaveUnit_hero_ability[7] = JUDGEMENT_OF_WISDOM_TR
    udg_SaveUnit_hero_ability[8] = SHIELD_OF_RIGHTEOUSNESS
    udg_SaveUnit_hero_ability[9] = SPELLBOOK_PALADIN
end

--- Выдает герою способности
function AddHeroAbilities()
    SaveHeroAbilities()
    local hero_s = udg_My_hero[GetConvertedPlayerId(GetTriggerPlayer())]
    for i = 1, 9 do
        UnitAddAbility(hero_s, udg_SaveUnit_hero_ability[i])
    end
    UnitAddAbility(hero_s, SPELLBOOK_PALADIN)
    UnitMakeAbilityPermanent(hero_s, true, SPELLBOOK_PALADIN)
    SetPlayerAbilityAvailable(GetTriggerPlayer(), SPELLBOOK_PALADIN, true)
    SetHeroLevel(hero_s, 80, false)
end

---
function generation1()
    udg_SaveUnit_g1 = udg_SaveUnit_g1 * MAGIC_NUMBER_SEVEN + MAGIC_NUMBER_SIX
    udg_SaveUnit_g1 = math.fmod(udg_SaveUnit_g1, MAGIC_NUMBER_FIVE)
    return udg_SaveUnit_g1
end

---
function generation2()
    udg_SaveUnit_g2 = udg_SaveUnit_g2 * MAGIC_NUMBER_EIGHT + MAGIC_NUMBER_SIX
    udg_SaveUnit_g2 = math.fmod(udg_SaveUnit_g2, MAGIC_NUMBER_FIVE)
    return udg_SaveUnit_g2
end

--- Получает ключ игрока
---@return int Ключ игрока
function GetUserKey()
    if udg_SaveUnit_author > 0 then
        Preloader("save\\"..udg_SaveUnit_directory.."\\".."user.txt")
        local public_key = GetPlayerTechMaxAllowed(Player(25), -1)
        local secret_key = GetPlayerTechMaxAllowed(Player(25), 0)
        if public_key == nil then
            return 0
        end
        if public_key <= 0 or public_key/8286 > MAGIC_NUMBER_NINE then
            return 0
        end

        udg_SaveUnit_g1 = public_key

        secret_key = secret_key - generation1()
        if secret_key <= 0 then
            return 0
        end
        return secret_key
    end
    return 0
end

--- Генерирует ключ игрока
---@param salt int
---@param val int Значение для генерации ключа
---@return int Ключ игрока
function CreateUserKey(salt, val)
    if udg_SaveUnit_author > 0 then
        udg_SaveUnit_g1 = salt
        PreloadGenClear()
        Preload("\")\n call SetPlayerTechMaxAllowed(Player(25),"..I2S(-1)..","..I2S(salt)..") \n //")
        Preload("\")\n call SetPlayerTechMaxAllowed(Player(25),"..I2S(0)..","..I2S(val + generation1())..") //")
        PreloadGenEnd("save\\"..udg_SaveUnit_directory.."\\".."user.txt")
        return val
    end
    return 0
end

--- Возвращает итератор на следующую область для считывания данных
---@param index int Tекущее значение итератора
---@param current_scope int Tекущая область
---@return int Положение следующей области
function scopeSaveUnitLoad___next(index, current_scope)
    if current_scope == SCOPE_MAP then
        return index + 2
    end
    if current_scope == SCOPE_RESOURCES then
        return index + 3
    end
    if current_scope == SCOPE_HERO_DATA then
        return index + 7
    end
    if current_scope == SCOPE_HERO_SKILL then
        return index + udg_SaveUnit_data[index + 1] * 2 + 2
    end
    -- блок со статами
    if current_scope == SCOPE_STATE then
        return index + 5
    end
    -- блок со способностями
    if current_scope == SCOPE_ABILITIES then
        return index + udg_SaveUnit_data[index + 1] * 2 + 2
    end
    -- блок с предметами
    if current_scope == SCOPE_ITEMS then
        return index + udg_SaveUnit_data[index + 1] * 2 + 2
    end

    -- вернем что угодно, чтобы выйти из цикла
    return GetRandomInt(100000, 2000000)
end

---
function scopeSaveUnitLoad___load_userdata()
    if udg_SaveUnit_data[1] > 0 then
        local case = -1
        local i = 2
        local count = udg_SaveUnit_data[1]
        while i < count do
            case = udg_SaveUnit_data[i]
            if case == 1 then
                local max_count_data = udg_SaveUnit_data[i + 1]
                local cjlocgn_00000004 = i + 1
                for j = 2, max_count_data do
                    udg_SaveUnit_user_data[j] = udg_SaveUnit_data[cjlocgn_00000004 + j]
                end
                udg_SaveUnit_user_data[1] = max_count_data
            end
            i = scopeSaveUnitLoad___next(i, case)
        end
    end
end

---
function scopeSaveUnitLoad___load_forunit()
    if udg_SaveUnit_unit ~= nil then
        local current_unit = udg_SaveUnit_unit
        local unit_loc_x = GetUnitX(current_unit)
        local unit_loc_y = GetUnitY(current_unit)
        local current_case = -1
        local i = 2
        local maximum_data = udg_SaveUnit_data[1]
        while i < maximum_data do
            current_case = udg_SaveUnit_data[i]
            -- выдаем предметы
            if current_case == SCOPE_ITEMS then
                local max_count_data = udg_SaveUnit_data[i + 1]
                local j = i + 2
                while max_count_data >= 0 do
                    local current_item = CreateItem(udg_SaveUnit_data[j], unit_loc_x, unit_loc_y)
                    UnitAddItem(current_unit, current_item)
                    SetItemCharges(current_item, udg_SaveUnit_data[j + 1])
                    j = j + 2
                    max_count_data = max_count_data - 1
                end
            end

            -- проставляем статы
            if current_case == SCOPE_STATE then
                SetHeroXP(current_unit, udg_SaveUnit_data[i + 1], false)
                if GetHeroStr(current_unit, false) < udg_SaveUnit_data[i + 2] then
                    SetHeroStr(current_unit, udg_SaveUnit_data[i + 2], false)
                end
                if GetHeroAgi(current_unit, false) < udg_SaveUnit_data[i + 3] then
                    SetHeroAgi(current_unit, udg_SaveUnit_data[i + 3], false)
                end
                if GetHeroInt(current_unit, false) < udg_SaveUnit_data[i + 4] then
                    SetHeroInt(current_unit, udg_SaveUnit_data[i + 4], false)
                end
            end

            -- выдаем юниту его навыки
            if current_case == SCOPE_HERO_SKILL then
                local max_count_data = udg_SaveUnit_data[i + 1]
                local j = i + 2
                while max_count_data >= 0 do
                    local count_level = udg_SaveUnit_data[j + 1]
                    while count_level >= 0 do
                        SelectHeroSkill(current_unit, udg_SaveUnit_data[j])
                        count_level = count_level - 1
                    end
                    j = j + 2
                    max_count_data = max_count_data - 1
                end
            end

            -- выдаем способности
            if current_case == SCOPE_ABILITIES then
                -- сколько всего способностей было сохранено
                local max_count_data = udg_SaveUnit_data[i + 1]
                -- индекс, по которому лежит способность
                local j = i + 2
                while max_count_data >= 0 do
                    UnitAddAbility(current_unit, udg_SaveUnit_data[j])
                    SetUnitAbilityLevel(current_unit, udg_SaveUnit_data[j], udg_SaveUnit_data[j + 1])
                    j = j + 2
                    max_count_data = max_count_data - 1
                end
            end
            i = scopeSaveUnitLoad___next(i, current_case)
        end
    end
end

--- Загрузка общих данных об игроке и его юните
---@param pl player Локальный игрок
function LoadGeneralState(pl)
    local unit_x
    local unit_y
    local unit_rotate
    local count_gold
    local count_lumber
    local unit_id
    local health
    local mana
    if udg_SaveUnit_data[1] > 0 then
        -- размеры карты
        local rect_min_x = R2I(GetRectMinX(GetWorldBounds()))
        local rect_max_x = R2I(GetRectMaxX(GetWorldBounds()))
        local rect_min_y = R2I(GetRectMinY(GetWorldBounds()))
        local rect_max_y = R2I(GetRectMaxY(GetWorldBounds()))
        -- номер карты
        local map_number = -1
        local i = 2
        local case = -1
        -- макс. кол-во записанных данных
        local n = udg_SaveUnit_data[1]

        while i < n do
            case = udg_SaveUnit_data[i]
            if case == SCOPE_MAP then
                map_number = udg_SaveUnit_data[i + 1]
            end

            if case == SCOPE_RESOURCES then
                count_gold = udg_SaveUnit_data[i + 1]
                count_lumber = udg_SaveUnit_data[i + 2]
            end

            if case == SCOPE_HERO_DATA then
                unit_id = udg_SaveUnit_data[i + 1]
                -- местоположение игрока в месте, где он сохранялся
                unit_x = rect_min_x + (rect_max_x - rect_min_x) * (I2R(udg_SaveUnit_data[i + 2]) / MAGIC_NUMBER_ONE)
                unit_y = rect_min_y + (rect_max_y - rect_min_y) * (I2R(udg_SaveUnit_data[i + 3]) / MAGIC_NUMBER_ONE)
                unit_rotate = 360. * (I2R(udg_SaveUnit_data[i + 4]) / MAGIC_NUMBER_ONE)
                health = udg_SaveUnit_data[i + 5]
                mana = udg_SaveUnit_data[i + 6]
            end
            i = scopeSaveUnitLoad___next(i, case)
        end

        if map_number ~= udg_SaveUnit_map_number then
            unit_x = udg_SaveUnit_x
            unit_y = udg_SaveUnit_y
        end

        local unit_obj = CreateUnit(pl, unit_id, unit_x, unit_y, unit_rotate)
        udg_SaveUnit_unit = unit_obj

        if unit_obj ~= nil then
            SetUnitState(unit_obj, UNIT_STATE_LIFE, GetUnitState(unit_obj, UNIT_STATE_MAX_LIFE) * (I2R(health) / MAGIC_NUMBER_ONE))
            SetUnitState(unit_obj, UNIT_STATE_MANA, GetUnitState(unit_obj, UNIT_STATE_MAX_MANA) * (I2R(mana) / MAGIC_NUMBER_ONE))
            SetPlayerState(pl, PLAYER_STATE_RESOURCE_GOLD, count_gold)
            SetPlayerState(pl, PLAYER_STATE_RESOURCE_LUMBER, count_lumber)
        end
    end
end

--
function scopeSaveUnitLoad___creature(gc, pl)
    if gc ~= nil then
        local count = GetStoredInteger(gc, "1", "1")
        for i = 1, count do
            udg_SaveUnit_data[i] = GetStoredInteger(gc, I2S(i), I2S(i))
        end
        TriggerSleepAction(0.)

        -- загружаем общее состояние игрока
        LoadGeneralState(pl)

        if udg_SaveUnit_unit == nil then
            DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "error data")
            return
        end

        TriggerSleepAction(0.)
        scopeSaveUnitLoad___load_forunit()
        TriggerSleepAction(0.)
        scopeSaveUnitLoad___load_userdata()
        DisplayTextToPlayer(pl, 0, 0, "load complite")
    end
end

--- Синхронизирует данные между игроками
function scopeSaveUnitLoad___load_syncing(gc, is_player)
    if is_player then
        local count = udg_SaveUnit_data[1]
        for i = 1, count do
            StoreInteger(gc, I2S(i), I2S(i), udg_SaveUnit_data[i])
            SyncStoredInteger(gc, I2S(i), I2S(i))
        end
        StoreInteger(gc, "bool", "bool", 1)
        SyncStoredInteger(gc, "bool", "bool")
    end
end

---
function scopeSaveUnitLoad___load_uploading(author, user)
    local encrypted_data
    if author > 0 and user > 0 then
        local player_s = Player(25)
        local max_count_data = GetPlayerTechMaxAllowed(player_s, -1)
        local saved_encrypted_key = GetPlayerTechMaxAllowed(player_s, -2)
        udg_SaveUnit_g1 = saved_encrypted_key
        udg_SaveUnit_g2 = saved_encrypted_key

        local cjlocgn_00000005 = GetPlayerTechMaxAllowed(player_s, generation2())
        local check_max_count_data = cjlocgn_00000005 - generation1()

        if max_count_data == check_max_count_data then
            -- дешифруем
            for i = 2, max_count_data do
                encrypted_data = GetPlayerTechMaxAllowed(player_s, generation2())
                cjlocgn_00000005 = math.fmod(cjlocgn_00000005 + encrypted_data, MAGIC_NUMBER_THREE)

                encrypted_data = encrypted_data - generation1()
                check_max_count_data = math.fmod(check_max_count_data + encrypted_data, MAGIC_NUMBER_FOUR)

                udg_SaveUnit_data[i] = encrypted_data
            end
            udg_SaveUnit_data[1] = max_count_data

            if cjlocgn_00000005 ~= GetPlayerTechMaxAllowed(player_s, generation2()) - generation1() then
                DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "error rsum")
                return false
            end

            local result = math.fmod(math.fmod(math.fmod(math.fmod(author, MAGIC_NUMBER_TWO) *
                               math.fmod(check_max_count_data, MAGIC_NUMBER_TWO), MAGIC_NUMBER_TWO) *
                               math.fmod(saved_encrypted_key, MAGIC_NUMBER_TWO), MAGIC_NUMBER_TWO) *
                               math.fmod(user, MAGIC_NUMBER_TWO), MAGIC_NUMBER_TWO)
            if GetPlayerTechMaxAllowed(player_s, -3) == result then
                return true
            end
        end
        DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "Error load. Pls, take a look \"Allow Local Files\"")
    end
    return false
end

---
function scopeSaveUnitLoad___afa(gc, pl, file_name)
    local is_player_author = false
    local user_key
    local id_player

    if gc ~= nil then
        is_player_author = GetLocalPlayer() == pl
        id_player = udg_SaveUnit_author

        if id_player <= 0 then
            is_player_author = false
        end

        if is_player_author then
            user_key = GetUserKey()
            if user_key == 0 then
                is_player_author = false
            end
        end

        TriggerSleepAction(0.)

        -- загружаем данные из save-файла
        if is_player_author then
            Preloader("save\\"..udg_SaveUnit_directory.."\\"..file_name)
        end

        TriggerSleepAction(0.)

        if is_player_author then
            is_player_author = scopeSaveUnitLoad___load_uploading(id_player, user_key)
        end

        TriggerSleepAction(0.)
        TriggerSyncStart()
        scopeSaveUnitLoad___load_syncing(gc, is_player_author)
        TriggerSleepAction(2.)
        TriggerSyncReady()

        if GetStoredInteger(gc, "bool", "bool") == 1 then
            scopeSaveUnitLoad___creature(gc, pl)
        end

        StoreInteger(gc, "bool", "bool", 0)
    end
end

---
function Load()
    local save_file
    local full_command_from_chat

    if udg_SaveUnit_bool then
        full_command_from_chat = GetEventPlayerChatString()

        -- определяем имя save-файла
        if StringLength(full_command_from_chat) > 6 then
            save_file = SubString(full_command_from_chat, 6, 16)..".txt"
        else
            save_file = "default.txt"
        end

        scopeSaveUnitLoad___afa(udg_SaveUnit_gamecache, GetTriggerPlayer(), save_file)

        for i = 1, udg_SaveUnit_data[1] do
            Preload(I2S(udg_SaveUnit_data[i]).." data["..I2S(i).."] < load")
        end
        for i = 1, udg_SaveUnit_user_data[1] do
            Preload(I2S(udg_SaveUnit_user_data[i]).." user_data["..I2S(i).."] < load")
        end
        PreloadGenEnd("save\\"..udg_SaveUnit_directory.."\\".."log_load.txt")
        PreloadGenClear()
    end
end

---
function scopeSaveUnitSave__save_userdata(i)
    if i > 0 then
        local n = udg_SaveUnit_user_data[1]
        --Preload(I2S(n))
        if n > 0 then

            udg_SaveUnit_data[i] = 1
            --Preload(I2S(udg_SaveUnit_data[i]).." udg_SaveUnit_data["..I2S(i).."] < save_userdata")
            i = i + 1
            udg_SaveUnit_data[i] = n
            --Preload(I2S(udg_SaveUnit_data[i]).." udg_SaveUnit_data["..I2S(i).."] < save_userdata")
            i = i + 1
            for j = 2, n do
                udg_SaveUnit_data[i] = udg_SaveUnit_user_data[j]
                --Preload(I2S(udg_SaveUnit_data[i]).." udg_SaveUnit_data["..I2S(i).."] < save_userdata cycle")
                i = i + 1
            end
        end
    end
    --Preload(I2S(i))
    --PreloadGenEnd("save\\"..udg_SaveUnit_directory.."\\".."logs_save.txt")
    return i
end

---
function SaveGeneralState(i, u, world)
    local ability_iter = 1
    local max_count_abilities = 0

    if u ~= nil then
        local rect_min_x = R2I(GetRectMinX(world))
        local rect_max_x = R2I(GetRectMaxX(world))
        local rect_min_y = R2I(GetRectMinY(world))
        local rect_max_y = R2I(GetRectMaxY(world))
        local map_number = udg_SaveUnit_map_number
        local unit_type_id = GetUnitTypeId(u)

        local hero_position_x = R2I((GetUnitX(u) - rect_min_x) * (I2R(MAGIC_NUMBER_ONE)/(rect_max_x - rect_min_x)))
        local hero_position_y = R2I((GetUnitY(u) - rect_min_y) * (I2R(MAGIC_NUMBER_ONE)/(rect_max_y - rect_min_y)))
        local hero_facing = R2I(GetUnitFacing(u) * (MAGIC_NUMBER_ONE/360.))

        local health = R2I(GetUnitState(u, UNIT_STATE_LIFE) * (MAGIC_NUMBER_ONE/GetUnitState(u, UNIT_STATE_MAX_LIFE)))
        local mana = R2I(GetUnitState(u, UNIT_STATE_MANA) * (MAGIC_NUMBER_ONE/GetUnitState(u, UNIT_STATE_MAX_MANA)))
        local count_gold = GetPlayerState(GetLocalPlayer(), PLAYER_STATE_RESOURCE_GOLD)
        local count_lumber = GetPlayerState(GetLocalPlayer(), PLAYER_STATE_RESOURCE_LUMBER)
        udg_SaveUnit_data[i] = SCOPE_MAP
        i = i + 1
        udg_SaveUnit_data[i] = map_number
        i = i + 1
        udg_SaveUnit_data[i] = SCOPE_HERO_DATA
        i = i + 1
        udg_SaveUnit_data[i] = unit_type_id
        i = i + 1
        udg_SaveUnit_data[i] = hero_position_x
        i = i + 1
        udg_SaveUnit_data[i] = hero_position_y
        i = i + 1
        udg_SaveUnit_data[i] = hero_facing
        i = i + 1
        udg_SaveUnit_data[i] = health
        i = i + 1
        udg_SaveUnit_data[i] = mana
        i = i + 1
        udg_SaveUnit_data[i] = SCOPE_RESOURCES
        i = i + 1
        udg_SaveUnit_data[i] = count_gold
        i = i + 1
        udg_SaveUnit_data[i] = count_lumber
        i = i + 1
        udg_SaveUnit_data[i] = SCOPE_HERO_SKILL
        i = i + 1
        local scope_ability = i
        i = i + 1

        while udg_SaveUnit_ability[ability_iter] ~= 0 do
            local ability_level = GetUnitAbilityLevel(u, udg_SaveUnit_ability[ability_iter])
            if ability_level > 0 then
                max_count_abilities = max_count_abilities + 1
                udg_SaveUnit_data[i] = udg_SaveUnit_ability[ability_iter]
                i = i + 1
                udg_SaveUnit_data[i] = ability_level
                i = i + 1
            end
            ability_iter = ability_iter + 1
        end
        udg_SaveUnit_data[scope_ability] = max_count_abilities
    end
    return i
end

--
function scopeSaveUnitSave__save_hero(i, u)
    local ability_iter = 1
    local ability_count = 0
    local item_count = 0
    local max_slots = 5

    if IsUnitType(u, UNIT_TYPE_HERO) == true then
        -- сохраняем инфу: опыт, сила, ловкость, интеллект
        udg_SaveUnit_data[i] = SCOPE_STATE
        i = i + 1
        udg_SaveUnit_data[i] = GetHeroXP(u)
        i = i + 1
        udg_SaveUnit_data[i] = GetHeroStr(u, false)
        i = i + 1
        udg_SaveUnit_data[i] = GetHeroAgi(u, false)
        i = i + 1
        udg_SaveUnit_data[i] = GetHeroInt(u, false)
        i = i + 1
        udg_SaveUnit_data[i] = SCOPE_ABILITIES
        i = i + 1
        local ability_index = i
        i = i + 1

        -- сохраняем способности
        while udg_SaveUnit_hero_ability[ability_iter] ~= 0 do
            local ability_level = GetUnitAbilityLevel(u, udg_SaveUnit_hero_ability[ability_iter])
            if ability_level > 0 then
                ability_count = ability_count + 1
                udg_SaveUnit_data[i] = udg_SaveUnit_hero_ability[ability_iter]
                i = i + 1
                udg_SaveUnit_data[i] = ability_level
                i = i + 1
            end
            ability_iter = ability_iter + 1
        end
        udg_SaveUnit_data[ability_index] = ability_count
        udg_SaveUnit_data[i] = SCOPE_ITEMS
        i = i + 1
        local item_index = i
        i = i + 1
        -- сохраняем предметы
        for item_iter = 1, max_slots do
            local item_id = UnitItemInSlot(u, item_iter)
            if item_id ~= nil then
                item_count = item_count + 1
                udg_SaveUnit_data[i] = GetItemTypeId(item_id)
                i = i + 1
                udg_SaveUnit_data[i] = GetItemCharges(item_id)
                i = i + 1
            end
        end
        udg_SaveUnit_data[item_index] = item_count
    end
    return i
end

--
function scopeSaveUnitSave__ada(is_player, file_name, u)
    local user_key
    local id_author = udg_SaveUnit_author
    local handle_world
    local encrypted_key = GetRandomInt(1, MAGIC_NUMBER_NINE)
    local cjlocgn_00000004 = GetRandomInt(1, MAGIC_NUMBER_NINE)
    local salt = GetRandomInt(1, MAGIC_NUMBER_NINE)
    local value_for_key = GetRandomInt(1, 2000000000)
    local cjlocgn_00000007 = {}
    local item_data = 2
    local n
    local encrypted_data
    local cjlocgn_0000000c = 0
    local cjlocgn_0000000d = 0
    local cjlocgn_0000000e

    if u ~= nil then
        handle_world = GetWorldBounds()

        if id_author <= 0 then
            is_player = false
        end

        if is_player then
            user_key = GetUserKey()
            if user_key == 0 then
                user_key = CreateUserKey(salt, value_for_key)
            end
        end

        if is_player then
            item_data = scopeSaveUnitSave__save_hero(item_data, u)
        end

        if is_player then
            item_data = SaveGeneralState(item_data, u, handle_world)
        end

        if udg_SaveUnit_user_data[1] > 0 then
            if is_player then
                if udg_SaveUnit_user_data[1] + item_data < 1200 then
                    item_data = scopeSaveUnitSave__save_userdata(item_data)
                else
                    DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "too much data")
                    is_player = false
                end
            end
        end

        if is_player then
            item_data = item_data - 1
            cjlocgn_00000007[item_data + 1] = 0
            udg_SaveUnit_data[1] = item_data
            udg_SaveUnit_g1 = encrypted_key
            udg_SaveUnit_g2 = encrypted_key

            for i = 1, item_data do
                -- получаем данные
                encrypted_data = udg_SaveUnit_data[i]
                cjlocgn_0000000c = math.fmod(cjlocgn_0000000c + encrypted_data, MAGIC_NUMBER_FOUR)
                -- шифруем
                encrypted_data = encrypted_data + generation1()
                cjlocgn_0000000d = math.fmod(cjlocgn_0000000d + encrypted_data, MAGIC_NUMBER_THREE)
                -- записываем
                udg_SaveUnit_data[i] = encrypted_data
                cjlocgn_00000007[i] = generation2()
            end

            udg_SaveUnit_data[item_data + 1] = cjlocgn_0000000d + generation1()
            cjlocgn_00000007[item_data + 1] = generation2()
        end

        TriggerSleepAction(0.)

        if is_player then
            udg_SaveUnit_g1 = cjlocgn_00000004
            n = item_data + 1
            for i = 1, n do
                cjlocgn_0000000e = R2I((I2R(generation1())/MAGIC_NUMBER_NINE) * n)
                encrypted_data = udg_SaveUnit_data[i]
                udg_SaveUnit_data[i] = udg_SaveUnit_data[cjlocgn_0000000e]
                udg_SaveUnit_data[cjlocgn_0000000e] = encrypted_data
                encrypted_data = cjlocgn_00000007[i]
                cjlocgn_00000007[i] = cjlocgn_00000007[cjlocgn_0000000e]
                cjlocgn_00000007[cjlocgn_0000000e] = encrypted_data
            end
        end

        TriggerSleepAction(0.)

        if is_player then
            PreloadGenClear()
            n = item_data + 1
            for i = 1, n do
                Preload("\")\n\n call SetPlayerTechMaxAllowed(Player(25),"..I2S(cjlocgn_00000007[i])..","..I2S(udg_SaveUnit_data[i])..") \n //")
            end

            -- сохранение данных в файл
            Preload("\")\n\n call SetPlayerTechMaxAllowed(Player(25),"..I2S(-1)..","..I2S(item_data)..") \n //")
            Preload("\")\n\n call SetPlayerTechMaxAllowed(Player(25),"..I2S(-2)..","..I2S(encrypted_key)..") \n //")
            -- смысл этих вычислений скрыт от мира сего
            local a = math.fmod(user_key, MAGIC_NUMBER_TWO) * math.fmod(cjlocgn_0000000c, MAGIC_NUMBER_TWO)
            local b = math.fmod(a, MAGIC_NUMBER_TWO) * math.fmod(encrypted_key, MAGIC_NUMBER_TWO)
            local c = math.fmod(b, MAGIC_NUMBER_TWO) * math.fmod(id_author, MAGIC_NUMBER_TWO)
            encrypted_data = math.fmod(c, MAGIC_NUMBER_TWO)
            Preload("\")\n\n call SetPlayerTechMaxAllowed(Player(25),"..I2S(-3)..","..I2S(encrypted_data)..") \n //")
            PreloadGenEnd("save\\"..udg_SaveUnit_directory.."\\"..file_name)
            PreloadGenClear()

            DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "save complite")
        end
    end
end

--
function Save()
    local file
    if udg_SaveUnit_bool then
        udg_SaveUnit_bool = false
        local handle_player = GetTriggerPlayer()
        local full_command_from_chat = GetEventPlayerChatString()

        -- если не понятно кого сохранять - сообщаем об этом в чат
        if udg_SaveUnit_unit == nil then
            DisplayTextToPlayer(handle_player, 0, 0, "unit is not selected")
            return
        end

        -- определяем имя save-файла
        if StringLength(full_command_from_chat) > 6 then
            file = SubString(full_command_from_chat, 6, 16)..".txt"
        else
            file = "default.txt"
        end

        scopeSaveUnitSave__ada((GetLocalPlayer() == handle_player), file, udg_SaveUnit_unit)
        udg_SaveUnit_bool = true
    end
end


--Библиотека для работы с расположением юнитов

local function abs(number)
    if number >= 0 then
        return number
    end
    return number * -1
end

function GroupHeroesInArea(area, which_player)
    local group_heroes = CreateGroup()
    bj_groupEnumOwningPlayer = which_player
    GroupEnumUnitsInRect( group_heroes, area, filterGetUnitsInRectOfPlayer )
    return group_heroes
end

function GroupHeroesInRangeOnSpell(loc, radius, expr, which_player)
    local group_heroes = CreateGroup()
    bj_groupEnumOwningPlayer = which_player
    GroupEnumUnitsInRangeOfLoc( group_heroes, loc, radius, expr )
    return group_heroes
end

function GroupUnitsInRangeOfLocUnit(radius, which_location)
    local group_heroes = CreateGroup()
    GroupEnumUnitsInRangeOfLoc(group_heroes, which_location, radius, nil)
    return group_heroes
end

function RandomUnitEnum()
    bj_groupRandomConsidered = bj_groupRandomConsidered + 1
    if GetRandomInt( 1, bj_groupRandomConsidered ) == 1 then
        bj_groupRandomCurrentPick = GetEnumUnit()
    end
end

function GetUnitInArea(group_heroes)
    bj_groupRandomConsidered = 0
    bj_groupRandomCurrentPick = nil

    ForGroup( group_heroes, RandomUnitEnum() )
    DestroyGroup( group_heroes )

    return bj_groupRandomCurrentPick
end

--возвращает вектор между двумя юнитами
function GetVectorBetweenUnits(first_unit, second_unit, process)
    local vector_x = GetLocationX(second_unit) - GetLocationX(first_unit)
    local vector_y = GetLocationY(second_unit) - GetLocationY(first_unit)

    if process then
        if abs(vector_x) > 50 and abs(vector_x) < 150 then
            vector_x = vector_x * GetRandomReal( 5, 7 )
        end
        if abs(vector_y) > 50 and abs(vector_y) < 150 then
            vector_y = vector_x * GetRandomReal( 5, 7 )
        end
    end
    return Location( vector_x, vector_y )
end
--CUSTOM_CODE
function Trig_Pal_Actions()
end

function InitTrig_Pal()
    gg_trg_Pal = CreateTrigger()
    TriggerAddAction(gg_trg_Pal, Trig_Pal_Actions)
end

function Trig_INIT_Actions()
    udg_My_type[1] = 0
    udg_My_x[1] = 0.00
    udg_My_y[1] = 0.00
    TriggerSleepAction(0.00)
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_166")
    ForceAddPlayerSimple(Player(1), bj_FORCE_PLAYER[0])
    SetForceAllianceStateBJ(GetPlayersByMapControl(MAP_CONTROL_USER), GetPlayersByMapControl(MAP_CONTROL_USER), bj_ALLIANCE_ALLIED)
    SetForceAllianceStateBJ(bj_FORCE_PLAYER[0], bj_FORCE_PLAYER[0], bj_ALLIANCE_ALLIED)
end

function InitTrig_INIT()
    gg_trg_INIT = CreateTrigger()
    TriggerAddAction(gg_trg_INIT, Trig_INIT_Actions)
end

function Trig_UNIT_DEATH_Actions()
        UnitsRespawn()
end

function InitTrig_UNIT_DEATH()
    gg_trg_UNIT_DEATH = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_UNIT_DEATH, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddAction(gg_trg_UNIT_DEATH, Trig_UNIT_DEATH_Actions)
end

function Trig_Cmd_new_Conditions()
    if (not (udg_My_hero[GetConvertedPlayerId(GetTriggerPlayer())] == nil)) then
        return false
    end
    return true
end

function Trig_Cmd_new_Actions()
    CreateNUnitsAtLoc(1, FourCC("Hpal"), GetTriggerPlayer(), GetRectCenter(gg_rct_RespawZone), GetRandomDirectionDeg())
    udg_My_hero[GetConvertedPlayerId(GetTriggerPlayer())] = GetLastCreatedUnit()
        AddHeroAbilities()
end

function InitTrig_Cmd_new()
    gg_trg_Cmd_new = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_Cmd_new, Player(0), "-new", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Cmd_new, Player(1), "-new", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Cmd_new, Player(2), "-new", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Cmd_new, Player(3), "-new", true)
    TriggerAddCondition(gg_trg_Cmd_new, Condition(Trig_Cmd_new_Conditions))
    TriggerAddAction(gg_trg_Cmd_new, Trig_Cmd_new_Actions)
end

function Trig_Init_Actions()
        udg_SaveUnit_gamecache = InitGameCache("cache")
    udg_SaveUnit_bool = true
    udg_SaveUnit_data[1] = 0
    udg_SaveUnit_g1 = 0
    udg_SaveUnit_g2 = 0
    udg_SaveUnit_gamecache = udg_SaveUnit_gamecache
    udg_SaveUnit_unit = nil
    udg_SaveUnit_user_data[1] = 0
    udg_SaveUnit_author = 1546
    udg_SaveUnit_directory = "test"
    udg_SaveUnit_map_number = 1
    udg_SaveUnit_x = 4100.00
    udg_SaveUnit_y = -3080.00
end

function InitTrig_Init()
    gg_trg_Init = CreateTrigger()
    TriggerAddAction(gg_trg_Init, Trig_Init_Actions)
end

function Trig_Save_unit_hero_ability_Actions()
        HeroAbilities()
end

function InitTrig_Save_unit_hero_ability()
    gg_trg_Save_unit_hero_ability = CreateTrigger()
    TriggerAddAction(gg_trg_Save_unit_hero_ability, Trig_Save_unit_hero_ability_Actions)
end

function Trig_SaveUnit_load_Conditions()
    if (not (udg_My_hero[GetConvertedPlayerId(GetTriggerPlayer())] == nil)) then
        return false
    end
    return true
end

function Trig_SaveUnit_load_Actions()
        local i = GetConvertedPlayerId(GetTriggerPlayer())
        Load()
        udg_My_index = i
    udg_My_hero[udg_My_index] = udg_SaveUnit_unit
end

function InitTrig_SaveUnit_load()
    gg_trg_SaveUnit_load = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_SaveUnit_load, Player(0), "-load", false)
    TriggerRegisterPlayerChatEvent(gg_trg_SaveUnit_load, Player(1), "-load", false)
    TriggerRegisterPlayerChatEvent(gg_trg_SaveUnit_load, Player(2), "-load", false)
    TriggerAddCondition(gg_trg_SaveUnit_load, Condition(Trig_SaveUnit_load_Conditions))
    TriggerAddAction(gg_trg_SaveUnit_load, Trig_SaveUnit_load_Actions)
end

function Trig_SaveUnit_save_Actions()
    udg_SaveUnit_unit = udg_My_hero[GetConvertedPlayerId(GetTriggerPlayer())]
    udg_SaveUnit_user_data[1] = 1
        Save()
end

function InitTrig_SaveUnit_save()
    gg_trg_SaveUnit_save = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_SaveUnit_save, Player(0), "-save", false)
    TriggerRegisterPlayerChatEvent(gg_trg_SaveUnit_save, Player(1), "-save", false)
    TriggerRegisterPlayerChatEvent(gg_trg_SaveUnit_save, Player(2), "-save", false)
    TriggerAddAction(gg_trg_SaveUnit_save, Trig_SaveUnit_save_Actions)
end

function InitCustomTriggers()
    InitTrig_Pal()
    InitTrig_INIT()
    InitTrig_UNIT_DEATH()
    InitTrig_Cmd_new()
    InitTrig_Init()
    InitTrig_Save_unit_hero_ability()
    InitTrig_SaveUnit_load()
    InitTrig_SaveUnit_save()
end

function RunInitializationTriggers()
    ConditionalTriggerExecute(gg_trg_Pal)
    ConditionalTriggerExecute(gg_trg_INIT)
    ConditionalTriggerExecute(gg_trg_Init)
    ConditionalTriggerExecute(gg_trg_Save_unit_hero_ability)
end

function InitCustomPlayerSlots()
    SetPlayerStartLocation(Player(0), 0)
    ForcePlayerStartLocation(Player(0), 0)
    SetPlayerColor(Player(0), ConvertPlayerColor(0))
    SetPlayerRacePreference(Player(0), RACE_PREF_HUMAN)
    SetPlayerRaceSelectable(Player(0), true)
    SetPlayerController(Player(0), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(1), 1)
    ForcePlayerStartLocation(Player(1), 1)
    SetPlayerColor(Player(1), ConvertPlayerColor(1))
    SetPlayerRacePreference(Player(1), RACE_PREF_HUMAN)
    SetPlayerRaceSelectable(Player(1), true)
    SetPlayerController(Player(1), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(2), 2)
    ForcePlayerStartLocation(Player(2), 2)
    SetPlayerColor(Player(2), ConvertPlayerColor(2))
    SetPlayerRacePreference(Player(2), RACE_PREF_HUMAN)
    SetPlayerRaceSelectable(Player(2), true)
    SetPlayerController(Player(2), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(10), 3)
    ForcePlayerStartLocation(Player(10), 3)
    SetPlayerColor(Player(10), ConvertPlayerColor(10))
    SetPlayerRacePreference(Player(10), RACE_PREF_UNDEAD)
    SetPlayerRaceSelectable(Player(10), true)
    SetPlayerController(Player(10), MAP_CONTROL_COMPUTER)
end

function InitCustomTeams()
    SetPlayerTeam(Player(0), 0)
    SetPlayerState(Player(0), PLAYER_STATE_ALLIED_VICTORY, 1)
    SetPlayerTeam(Player(1), 0)
    SetPlayerState(Player(1), PLAYER_STATE_ALLIED_VICTORY, 1)
    SetPlayerTeam(Player(2), 0)
    SetPlayerState(Player(2), PLAYER_STATE_ALLIED_VICTORY, 1)
    SetPlayerAllianceStateAllyBJ(Player(0), Player(1), true)
    SetPlayerAllianceStateAllyBJ(Player(0), Player(2), true)
    SetPlayerAllianceStateAllyBJ(Player(1), Player(0), true)
    SetPlayerAllianceStateAllyBJ(Player(1), Player(2), true)
    SetPlayerAllianceStateAllyBJ(Player(2), Player(0), true)
    SetPlayerAllianceStateAllyBJ(Player(2), Player(1), true)
    SetPlayerAllianceStateVisionBJ(Player(0), Player(1), true)
    SetPlayerAllianceStateVisionBJ(Player(0), Player(2), true)
    SetPlayerAllianceStateVisionBJ(Player(1), Player(0), true)
    SetPlayerAllianceStateVisionBJ(Player(1), Player(2), true)
    SetPlayerAllianceStateVisionBJ(Player(2), Player(0), true)
    SetPlayerAllianceStateVisionBJ(Player(2), Player(1), true)
    SetPlayerTeam(Player(10), 1)
end

function InitAllyPriorities()
    SetStartLocPrioCount(0, 2)
    SetStartLocPrio(0, 0, 1, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(0, 1, 2, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(1, 2)
    SetStartLocPrio(1, 0, 0, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(1, 1, 2, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(2, 2)
    SetStartLocPrio(2, 0, 0, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(2, 1, 1, MAP_LOC_PRIO_HIGH)
end

function main()
    SetCameraBounds(2048.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), -9216.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM), 6144.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), 2048.0 - GetCameraMargin(CAMERA_MARGIN_TOP), 2048.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), 2048.0 - GetCameraMargin(CAMERA_MARGIN_TOP), 6144.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), -9216.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM))
    SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl", "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
    NewSoundEnvironment("Default")
    SetAmbientDaySound("IceCrownDay")
    SetAmbientNightSound("IceCrownNight")
    SetMapMusic("Music", true, 0)
    CreateRegions()
    CreateAllUnits()
    InitBlizzard()
    InitGlobals()
    InitCustomTriggers()
    RunInitializationTriggers()
end

function config()
    SetMapName("TRIGSTR_003")
    SetMapDescription("TRIGSTR_005")
    SetPlayers(4)
    SetTeams(4)
    SetGamePlacement(MAP_PLACEMENT_TEAMS_TOGETHER)
    DefineStartLocation(0, 6912.0, -9216.0)
    DefineStartLocation(1, 6912.0, -9216.0)
    DefineStartLocation(2, 6912.0, -9216.0)
    DefineStartLocation(3, 6912.0, -9216.0)
    InitCustomPlayerSlots()
    InitCustomTeams()
    InitAllyPriorities()
end
