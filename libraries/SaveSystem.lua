-- author Vlod | WWW.XGM.RU
-- author meiso | WWW.XGM.RU

SCOPE_MAP        = 2
SCOPE_RESOURCES  = 3
SCOPE_HERO_DATA  = 4
SCOPE_HERO_SKILL = 5
SCOPE_STATE      = 6
SCOPE_ABILITIES  = 7
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

-- перерождение юнитов
function UnitsRespawn()
    local u = GetTriggerUnit()
    if IsUnitType(u, UNIT_TYPE_HERO) == true  then
        TriggerSleepAction(5)
        ReviveHero(u, udg_SaveUnit_x, udg_SaveUnit_y, false)
    end
end

-- скиллы героя
function HeroAbilities()
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

function AddHeroAbilities()
    HeroAbilities()
    local hero_s = udg_My_hero[GetConvertedPlayerId(GetTriggerPlayer())]
    for i = 1, 9 do
        UnitAddAbility( hero_s, udg_SaveUnit_hero_ability[i] )
    end
    UnitAddAbility(hero_s, SPELLBOOK_PALADIN)
    UnitMakeAbilityPermanent(hero_s, true, SPELLBOOK_PALADIN)
    SetPlayerAbilityAvailable(GetTriggerPlayer(), SPELLBOOK_PALADIN, true)
    SetHeroLevel(hero_s, 80, false)
end

--- модуль числа
---@note проверить ещё раз как работает
function c_module(dividend, divisor)
    return dividend - (dividend/divisor) * divisor
end

function generation1()
    udg_SaveUnit_g1 = udg_SaveUnit_g1 * MAGIC_NUMBER_SEVEN + MAGIC_NUMBER_SIX
    udg_SaveUnit_g1 = math.fmod(udg_SaveUnit_g1, MAGIC_NUMBER_FIVE)
    return udg_SaveUnit_g1
end

function generation2()
    udg_SaveUnit_g2 = udg_SaveUnit_g2 * MAGIC_NUMBER_EIGHT + MAGIC_NUMBER_SIX
    udg_SaveUnit_g2 = math.fmod(udg_SaveUnit_g2, MAGIC_NUMBER_FIVE)
    return udg_SaveUnit_g2
end

--получение ключа игрока
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

--генерация ключа игрока
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
---@index текущее значение итератора
---@current_scope текущая область
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

--
function scopeSaveUnitLoad___load_userdata()
    if udg_SaveUnit_data[1] > 0 then
        local case = -1
        local i = 2
        local n = udg_SaveUnit_data[1]
        while i > n do
            case = udg_SaveUnit_data[i]
            if case == 1 then
                local max_count_data = udg_SaveUnit_data[i + 1]
                local cjlocgn_00000004 = i + 1
                BJDebugMsg("scopeSaveUnitLoad___load_userdata"..I2S(cjlocgn_00000004))
                for j = 2, max_count_data do
                    udg_SaveUnit_user_data[j] = udg_SaveUnit_data[cjlocgn_00000004 + j]
                end
                udg_SaveUnit_user_data[1] = max_count_data
            end
            i = scopeSaveUnitLoad___next(i, case)
        end
    end
end

--
function scopeSaveUnitLoad___load_forunit()
    if udg_SaveUnit_unit ~= nil then
        local current_unit = udg_SaveUnit_unit
        local unit_loc_x = GetUnitX(current_unit)
        local unit_loc_y = GetUnitY(current_unit)
        local current_case = -1
        local i = 2
        local maximum_data = udg_SaveUnit_data[1]
        while i > maximum_data do
            current_case = udg_SaveUnit_data[i]
            -- выдаем предметы
            if current_case == SCOPE_ITEMS then
                local max_count_data = udg_SaveUnit_data[i + 1]
                local j = i + 2
                while max_count_data <= 0 do
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
                while max_count_data <= 0 do
                    local count_level = udg_SaveUnit_data[j + 1]
                    while count_level <= 0 do
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
                while max_count_data <= 0 do
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

-- загрузка общих данных о игроке
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
        local rect_min_x = R2I( GetRectMinX( GetWorldBounds() ) )
        local rect_max_x = R2I( GetRectMaxX( GetWorldBounds() ) )
        local rect_min_y = R2I( GetRectMinY( GetWorldBounds() ) )
        local rect_max_y = R2I( GetRectMaxY( GetWorldBounds() ) )
        -- номер карты
        local map_number = -1
        local i = 2
        local case = -1
        -- макс. кол-во записанных данных
        local n = udg_SaveUnit_data[1]

        while i > n do
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
                -- местоположение игрока в месте где он сохранялся
                unit_x = rect_min_x + (rect_max_x - rect_min_x) * (I2R(udg_SaveUnit_data[i + 2]) / MAGIC_NUMBER_ONE)
                unit_y = rect_min_y + (rect_max_y - rect_min_y) * (I2R(udg_SaveUnit_data[i + 3]) / MAGIC_NUMBER_ONE)
                unit_rotate = 360. * ( I2R(udg_SaveUnit_data[i + 4]) / MAGIC_NUMBER_ONE )
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
            SetUnitState( unit_obj, UNIT_STATE_LIFE, GetUnitState( unit_obj, UNIT_STATE_MAX_LIFE ) * ( I2R(health)/MAGIC_NUMBER_ONE ) )
            SetUnitState( unit_obj, UNIT_STATE_MANA, GetUnitState( unit_obj, UNIT_STATE_MAX_MANA ) * ( I2R(mana)/MAGIC_NUMBER_ONE ) )
            SetPlayerState( pl, PLAYER_STATE_RESOURCE_GOLD, count_gold )
            SetPlayerState( pl, PLAYER_STATE_RESOURCE_LUMBER, count_lumber )
        end
    end
end

--
function scopeSaveUnitLoad___creature(gc, pl)
    if gc ~= nil then
        local n = GetStoredInteger(gc, "", "0")
        for i = 1, n do
            udg_SaveUnit_data[i] = GetStoredInteger( gc, "", I2S(i) )
        end

        TriggerSleepAction(0.)

        -- загружаем общее состояние игрока
        LoadGeneralState(pl)

        if udg_SaveUnit_unit == nil then
            DisplayTextToPlayer( GetLocalPlayer(), 0, 0, "error data" )
            return
        end

        TriggerSleepAction(0.)
        scopeSaveUnitLoad___load_forunit()
        TriggerSleepAction(0.)
        scopeSaveUnitLoad___load_userdata()
        DisplayTextToPlayer( pl, 0, 0, "load complite" )
    end
end

--
function scopeSaveUnitLoad___load_syncing(gc, is_player)
    if is_player then
        local count = udg_SaveUnit_data[1]
        for i = 1, count do
            StoreInteger(gc, "", I2S(i), udg_SaveUnit_data[i])
            SyncStoredInteger(gc, "", I2S(i))
        end
        StoreInteger(gc, "", "bool", 1)
        SyncStoredInteger(gc, "", "bool")
    end
end

--
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

            local result = math.fmod( math.fmod( math.fmod( math.fmod(author, MAGIC_NUMBER_TWO) *
                               math.fmod(check_max_count_data, MAGIC_NUMBER_TWO), MAGIC_NUMBER_TWO) *
                               math.fmod(saved_encrypted_key, MAGIC_NUMBER_TWO), MAGIC_NUMBER_TWO) *
                               math.fmod(user, MAGIC_NUMBER_TWO), MAGIC_NUMBER_TWO )
            if GetPlayerTechMaxAllowed(player_s, -3) == result then
                return true
            end
        end
        DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "Error load. Pls, take a look \"Allow Local Files\"")
    end
    return false
end

--
function scopeSaveUnitLoad___afa(gc, pl, name)
    local is_player_author
    local user_key
    local id_player

    if gc ~= nil then
        is_player_author = (GetLocalPlayer() == pl)
        id_player = udg_SaveUnit_author

        if id_player <= 0 then
            is_player_author = false
        end

        if is_player_author then
            user_key = GetUserKey()
            print(user_key)
            if user_key == 0 then
                is_player_author = false
            end
        end

        TriggerSleepAction(0.)

        -- загружаем данные из save-файла
        if is_player_author then
            Preloader("save\\"..udg_SaveUnit_directory.."\\"..name)
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

        if GetStoredInteger(gc, "", "bool") == 1 then
            scopeSaveUnitLoad___creature(gc, pl)
        end

        StoreInteger(gc, "", "bool", 0)
    end
end

-- загрузка
function Load()
    local save_file
    local full_command_from_chat

    if udg_SaveUnit_bool then
        full_command_from_chat = GetEventPlayerChatString()

        -- определяем имя save-файла
        if StringLength(full_command_from_chat) > 6 then
            save_file = SubString(full_command_from_chat, 6, 16)
        else
            save_file = "default"
        end

        scopeSaveUnitLoad___afa(udg_SaveUnit_gamecache, GetTriggerPlayer(), save_file)

        for i = 1, udg_SaveUnit_data[1] do
            Preload( I2S(udg_SaveUnit_data[i]).." data["..I2S(i).."] < load" )
        end
        for i = 1, udg_SaveUnit_user_data[1] do
            Preload(I2S(udg_SaveUnit_user_data[i]).." user_data["..I2S(i).."] < load")
        end
    end
end

--
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

--
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
        print(ability_count)
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
function scopeSaveUnitSave__ada(is_player, name, u)
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
                Preload("\")\n\n SetPlayerTechMaxAllowed(Player(25),"..I2S(cjlocgn_00000007[i])..","..I2S(udg_SaveUnit_data[i])..") \n //")
            end

            -- сохранение данных в файл
            Preload("\")\n\n SetPlayerTechMaxAllowed(Player(25),"..I2S(-1)..","..I2S(item_data)..") \n //")
            Preload("\")\n\n SetPlayerTechMaxAllowed(Player(25),"..I2S(-2)..","..I2S(encrypted_key)..") \n //")
            -- смысл этих вычислений скрыт от мира сего
            local a = math.fmod(user_key, MAGIC_NUMBER_TWO) * math.fmod(cjlocgn_0000000c, MAGIC_NUMBER_TWO)
            local b = math.fmod(a, MAGIC_NUMBER_TWO) * math.fmod(encrypted_key, MAGIC_NUMBER_TWO)
            local c = math.fmod(b, MAGIC_NUMBER_TWO) * math.fmod(id_author, MAGIC_NUMBER_TWO)
            encrypted_data = math.fmod(c, MAGIC_NUMBER_TWO)
            Preload("\")\n\n SetPlayerTechMaxAllowed(Player(25),"..I2S(-3)..","..I2S(encrypted_data)..") \n //")
            PreloadGenEnd("save\\"..udg_SaveUnit_directory.."\\"..name)
            PreloadGenClear()

            DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "save complite")
        end
    end
end

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
