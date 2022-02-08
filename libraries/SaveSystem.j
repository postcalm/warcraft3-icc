// author Vlod | WWW.XGM.RU
// author meiso | WWW.XGM.RU
include "common/spells.j"

define 
{
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
}

// перерождение юнитов
void UnitsRespawn()
{
    unit u = GetTriggerUnit()
    integer handle_time
    
    if( IsUnitType(u, UNIT_TYPE_HERO) == true )
    {
        TriggerSleepAction(5)
        ReviveHero(u, 4100., -3080., false)
    }
    
    u = null
}

// скиллы героя
void HeroAbilities()
{
    udg_SaveUnit_hero_ability[0] = DEVOTION_AURA
    udg_SaveUnit_hero_ability[1] = DIVINE_SHIELD
    udg_SaveUnit_hero_ability[2] = CONSECRATION
    udg_SaveUnit_hero_ability[3] = CONSECRATION_TR
    udg_SaveUnit_hero_ability[4] = HAMMER_RIGHTEOUS
    udg_SaveUnit_hero_ability[5] = JUDGEMENT_OF_LIGHT_TR
    udg_SaveUnit_hero_ability[6] = JUDGEMENT_OF_WISDOM_TR
    udg_SaveUnit_hero_ability[7] = SHIELD_OF_RIGHTEOUSNESS
    udg_SaveUnit_hero_ability[8] = SPELLBOOK_PALADIN
}

void AddHeroAbilities()
{
    HeroAbilities()
    int i = 0
    unit hero_s = udg_My_hero[GetConvertedPlayerId(GetTriggerPlayer())]
    whilenot( i > 8 )
    {
        UnitAddAbility( hero_s, \
                        udg_SaveUnit_hero_ability[i] )
        i++
    }
    // UnitAddAbility(hero_s, SPELLBOOK_PALADIN)
    UnitMakeAbilityPermanent(hero_s, true, SPELLBOOK_PALADIN)
    SetPlayerAbilityAvailable(GetTriggerPlayer(), SPELLBOOK_PALADIN, true)
    SetHeroLevel( hero_s, 80, false )
}

// модуль числа (custom)
integer c_module(integer dividend, integer divisor)
{
    return dividend - (dividend/divisor) * divisor
}	

//
integer generation1()
{
    udg_SaveUnit_g1 = udg_SaveUnit_g1 * MAGIC_NUMBER_SEVEN + MAGIC_NUMBER_SIX
    udg_SaveUnit_g1 = c_module(udg_SaveUnit_g1, MAGIC_NUMBER_FIVE)
    return udg_SaveUnit_g1
}

// 
integer generation2()
{	
    udg_SaveUnit_g2 = udg_SaveUnit_g2 * MAGIC_NUMBER_EIGHT + MAGIC_NUMBER_SIX
    udg_SaveUnit_g2 = c_module(udg_SaveUnit_g2, MAGIC_NUMBER_FIVE)
    return udg_SaveUnit_g2
}

// получение ключа игрока
integer GetUserKey()
{
    integer public_key
    integer secret_key
    
    if( udg_SaveUnit_author > 0 )
    {
        Preloader("save\\" + udg_SaveUnit_directory + "\\" + "user")
        
        public_key = GetPlayerTechMaxAllowed(Player(15), -1)
        secret_key = GetPlayerTechMaxAllowed(Player(15), 0)
        
        if( public_key <= 0 or ( public_key/8286 ) > 259199 ) 
        { 
            return 0 
        }
        
        udg_SaveUnit_g1 = public_key
        
        secret_key = secret_key - generation1()
        if ( secret_key <= 0 ) 
        { 
            return 0 
        }
        return secret_key
    }
    return 0
}

// генерация ключа игрока
integer CreateUserKey(integer salt, integer val)
{
    if( udg_SaveUnit_author > 0 )
    {
        udg_SaveUnit_g1 = salt
        PreloadGenClear()
        Preload("\")\n call SetPlayerTechMaxAllowed(Player(15)," + I2S(-1) + "," + I2S(salt) + ") \n //")
        Preload("\")\n call SetPlayerTechMaxAllowed(Player(15)," + I2S(0) + "," + I2S(val + generation1()) + ") //")
        PreloadGenEnd("save\\" + udg_SaveUnit_directory + "\\" + "user")
        return val
    }
    return 0
}

/// Возвращает итератор на следующую область для считывания данных
/// index: текущее значение итератора
/// current_scope: текущая область
integer scopeSaveUnitLoad___next(integer index, integer current_scope)
{
    if(current_scope == SCOPE_MAP)
    {
        return index + 2
    }
    if(current_scope == SCOPE_RESOURCES)
    {
        return index + 3 
    }
    if(current_scope == SCOPE_HERO_DATA)
    {
        return index + 7
    }
    if(current_scope == SCOPE_HERO_SKILL)
    {
        return index + udg_SaveUnit_data[index + 1] * 2 + 2
    }
    // блок со статами
    if(current_scope == SCOPE_STATE)
    {
        return index + 5
    }
    // блок со способностями
    if(current_scope == SCOPE_ABILITIES)
    {
        return index + udg_SaveUnit_data[index + 1] * 2 + 2
    }
    // блок с предметами
    if(current_scope == SCOPE_ITEMS)
    {
        return index + udg_SaveUnit_data[index + 1] * 2 + 2
    }
    
    // вернем что угодно, чтобы выйти из цикла
    return GetRandomInt(100000, 2000000)
}

// 
void scopeSaveUnitLoad___load_userdata()
{
    integer case
    integer i
    integer n
    integer cjlocgn_00000003
    integer cjlocgn_00000004
    integer j = 0
    
    if( udg_SaveUnit_data[0] > 0 )
    {
        case = -1
        i = 1
        n = udg_SaveUnit_data[0]
        whilenot( i > n)
        {
            case = udg_SaveUnit_data[i]
            if( case == 1 )
            {
                cjlocgn_00000003 = udg_SaveUnit_data[i + 1]
                cjlocgn_00000004 = i + 1
                whilenot( j++ > cjlocgn_00000003 )
                {
                    udg_SaveUnit_user_data[j] = udg_SaveUnit_data[cjlocgn_00000004 + j]
                }
                udg_SaveUnit_user_data[0] = cjlocgn_00000003
            }
            i = scopeSaveUnitLoad___next(i, case)
        }
    }
}

// 
void scopeSaveUnitLoad___load_forunit()
{
    unit current_unit
    real unit_loc_x
    real unit_loc_y
    item current_item
    integer current_case
    integer i
    integer maximum_data
    integer max_count_data
    integer j
    integer count_level
    
    if( udg_SaveUnit_unit != null )
    {
        current_unit = udg_SaveUnit_unit
        unit_loc_x = GetUnitX(current_unit)
        unit_loc_y = GetUnitY(current_unit)
        current_case = -1
        i = 1
        maximum_data = udg_SaveUnit_data[0]
        whilenot( i > maximum_data )
        {
            current_case = udg_SaveUnit_data[i]
            
            // выдаем предметы
            if( current_case == SCOPE_ITEMS )
            {
                max_count_data = udg_SaveUnit_data[i + 1]
                j = i + 2
                whilenot( max_count_data <= 0 )
                {
                    current_item = CreateItem(udg_SaveUnit_data[j], unit_loc_x, unit_loc_y)
                    UnitAddItem(current_unit, current_item)
                    SetItemCharges(current_item, udg_SaveUnit_data[j + 1])
                    j += 2
                    max_count_data -= 1
                }
            }
            
            // проставляем статы
            if( current_case == SCOPE_STATE )
            {
                SetHeroXP(current_unit, udg_SaveUnit_data[i + 1], false)
                if GetHeroStr(current_unit, false) < udg_SaveUnit_data[i + 2]
                {
                    SetHeroStr(current_unit, udg_SaveUnit_data[i + 2], false)
                }
                if GetHeroAgi(current_unit, false) < udg_SaveUnit_data[i + 3]
                {
                    SetHeroAgi(current_unit, udg_SaveUnit_data[i + 3], false)
                }
                if GetHeroInt(current_unit, false) < udg_SaveUnit_data[i + 4]
                {
                    SetHeroInt(current_unit, udg_SaveUnit_data[i + 4], false)
                }
            }
            
            // выдаем юниту его навыки
            if( current_case == SCOPE_HERO_SKILL )
            {
                max_count_data = udg_SaveUnit_data[i + 1]
                j = i + 2
                whilenot( max_count_data <= 0 )
                {
                    count_level = udg_SaveUnit_data[j + 1]
                    whilenot( count_level <= 0 )
                    {
                        SelectHeroSkill(current_unit, udg_SaveUnit_data[j])
                        count_level -= 1
                    }
                    j += 2
                    max_count_data -= 1
                }
            }

            // выдаем способности
            if( current_case == SCOPE_ABILITIES )
            {
                // сколько всего способностей было сохранено
                max_count_data = udg_SaveUnit_data[i + 1]
                // индекс, по которому лежит способность
                j = i + 2
                whilenot( max_count_data <= 0 )
                {
                    UnitAddAbility(current_unit, udg_SaveUnit_data[j])
                    SetUnitAbilityLevel(current_unit, udg_SaveUnit_data[j], udg_SaveUnit_data[j + 1])
                    j += 2
                    max_count_data -= 1
                }
            }
            i = scopeSaveUnitLoad___next(i, current_case)
        }
        current_unit = null
        current_item = null
    }
}

// загрузка общих данных о игроке
void LoadGeneralState(player pl)
{
    // размеры карты 
    integer rect_min_x
    integer rect_max_x
    integer rect_min_y
    integer rect_max_y
    
    // номер карты
    integer map_number
    
    integer health
    integer mana
    integer count_gold
    integer count_lumber
    
    // положение игрока
    real unit_x
    real unit_y
    real unit_rotate
    // объект и id
    unit unit_obj
    integer unit_id
    
    // итераторы
    integer i
    integer case
    // макс. кол-во записанных данных
    integer n
    
    if( udg_SaveUnit_data[0] > 0 )
	{
        rect_min_x = R2I( GetRectMinX( GetWorldBounds() ) )
        rect_max_x = R2I( GetRectMaxX( GetWorldBounds() ) )
        rect_min_y = R2I( GetRectMinY( GetWorldBounds() ) )
        rect_max_y = R2I (GetRectMaxY( GetWorldBounds() ) )
        map_number = -1
        i = 1
        case = -1
        n = udg_SaveUnit_data[0]
        
        whilenot( i > n )
        {
            case = udg_SaveUnit_data[i]
            if( case == SCOPE_MAP )
            {
                map_number = udg_SaveUnit_data[i + 1]
            }
            
            if( case == SCOPE_RESOURCES )
            {
                count_gold = udg_SaveUnit_data[i + 1]
                count_lumber = udg_SaveUnit_data[i + 2]
            }
            
            if( case == SCOPE_HERO_DATA )
            {
                unit_id = udg_SaveUnit_data[i + 1]
                // местоположение игрока в месте где он сохранялся
                unit_x = rect_min_x + (rect_max_x - rect_min_x) * (I2R(udg_SaveUnit_data[i + 2])/MAGIC_NUMBER_ONE)
                unit_y = rect_min_y + (rect_max_y - rect_min_y) * (I2R(udg_SaveUnit_data[i + 3])/MAGIC_NUMBER_ONE)
                unit_rotate = 360. * (I2R(udg_SaveUnit_data[i + 4])/MAGIC_NUMBER_ONE)
                health = udg_SaveUnit_data[i + 5]
                mana = udg_SaveUnit_data[i + 6]
            }
            i = scopeSaveUnitLoad___next(i, case)
        }
        
        if( map_number != udg_SaveUnit_map_number )
        {
            unit_x = udg_SaveUnit_x
            unit_y = udg_SaveUnit_y
        }
        
        unit_obj = CreateUnit(pl, unit_id, unit_x, unit_y, unit_rotate)
        udg_SaveUnit_unit = unit_obj
        
        if( unit_obj != null )
        {
            SetUnitState( unit_obj, UNIT_STATE_LIFE, GetUnitState( unit_obj, UNIT_STATE_MAX_LIFE ) * ( I2R(health)/MAGIC_NUMBER_ONE ) )
            SetUnitState( unit_obj, UNIT_STATE_MANA, GetUnitState( unit_obj, UNIT_STATE_MAX_MANA ) * ( I2R(mana)/MAGIC_NUMBER_ONE ) )
            SetPlayerState( pl, PLAYER_STATE_RESOURCE_GOLD, count_gold )
            SetPlayerState( pl, PLAYER_STATE_RESOURCE_LUMBER, count_lumber )
            unit_obj = null
        }
    }
}

// 
void scopeSaveUnitLoad___creature(gamecache gc, player pl)
{
    integer i = 0
    integer n
    
    if( gc != null )
    {
        n = GetStoredInteger(gc, "", "0")
        whilenot( i > n )
        {
            udg_SaveUnit_data[i] = GetStoredInteger( gc, "", I2S(i) )
            i++
        }
        
        TriggerSleepAction(0.)
        
        // загружаем общее состояние игрока
        LoadGeneralState(pl)
        
        if( udg_SaveUnit_unit == null )
        {
            DisplayTextToPlayer( GetLocalPlayer(), 0, 0, "error data" )
            return        
        }
        
        TriggerSleepAction(0.)
        scopeSaveUnitLoad___load_forunit()
        TriggerSleepAction(0.)
        scopeSaveUnitLoad___load_userdata()
        DisplayTextToPlayer( pl, 0, 0, "load complite" )
    }
}

// 
void scopeSaveUnitLoad___load_syncing(gamecache gc, boolean is_player)
{
    integer i = 0
    integer count
    
    if( is_player )
    {
        count = udg_SaveUnit_data[0]
        whilenot( i > count )
        {
            StoreInteger( gc, "", I2S(i), udg_SaveUnit_data[i] )
            SyncStoredInteger( gc, "", I2S(i) )
            i++
        }
        StoreInteger( gc, "", "bool", 1 )
        SyncStoredInteger( gc, "", "bool" )
    }
}

// 
boolean scopeSaveUnitLoad___load_uploading(integer author, integer user)
{
    player player_s = null
    integer max_count_data
    integer saved_encrypted_key
    integer encrypted_data
    integer i = 1
    integer cjlocgn_00000005
    integer check_max_count_data
    integer result
    
    if( author > 0 and user > 0 )
    {
        player_s = Player(15)
        max_count_data = GetPlayerTechMaxAllowed(player_s, -1)
        saved_encrypted_key = GetPlayerTechMaxAllowed(player_s, -2)
        
        udg_SaveUnit_g1 = saved_encrypted_key
        udg_SaveUnit_g2 = saved_encrypted_key
        
        cjlocgn_00000005 = GetPlayerTechMaxAllowed(player_s, generation2())
        
        check_max_count_data = cjlocgn_00000005 - generation1()
        
        if( max_count_data == check_max_count_data )
        {
            // дешифруем
            whilenot( i > max_count_data )
            {
                encrypted_data = GetPlayerTechMaxAllowed(player_s, generation2())
                cjlocgn_00000005 = c_module(cjlocgn_00000005 + encrypted_data, MAGIC_NUMBER_THREE)
                
                encrypted_data = encrypted_data - generation1()
                check_max_count_data = c_module(check_max_count_data + encrypted_data, MAGIC_NUMBER_FOUR)
                
                udg_SaveUnit_data[i] = encrypted_data
                i++
            }
            udg_SaveUnit_data[0] = max_count_data
            
            if( cjlocgn_00000005 != GetPlayerTechMaxAllowed(player_s, generation2()) - generation1() )
            {
                DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "error rsum")
                return false
            }
            
            result = c_module( c_module( c_module( c_module(author, MAGIC_NUMBER_TWO) * \
                               c_module(check_max_count_data, MAGIC_NUMBER_TWO), MAGIC_NUMBER_TWO) * \
                               c_module(saved_encrypted_key, MAGIC_NUMBER_TWO), MAGIC_NUMBER_TWO) * \
                               c_module(user, MAGIC_NUMBER_TWO), MAGIC_NUMBER_TWO )
            if( GetPlayerTechMaxAllowed(player_s, -3) == result )
            {
                return true
            }
        }
        PreloadGenEnd("save\\" + udg_SaveUnit_directory + "\\logs.txt")
        DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "Error load. Pls, take a look \"Allow Local Files\"")
    }
    return false
}

// 
void scopeSaveUnitLoad___afa(gamecache gc, player pl, string name)
{
    boolean is_player_author
    integer user_key
    integer id_player
    
    if gc != null
    {
        is_player_author = (GetLocalPlayer() == pl)
        id_player = udg_SaveUnit_author
        
        if( id_player <= 0 )
        {
            is_player_author = false
        }
        
        if( is_player_author )
        {
            user_key = GetUserKey()
            if( user_key == 0 )
            {
                is_player_author = false
            }
        }
        
        TriggerSleepAction(0.)
        
        // загружаем данные из save-файла
        if( is_player_author )
        {
            Preloader("save\\" + udg_SaveUnit_directory + "\\" + name)
        }
        
        TriggerSleepAction(0.)
        
        if( is_player_author )
        {
            is_player_author = scopeSaveUnitLoad___load_uploading(id_player, user_key)
        }
        
        TriggerSleepAction(0.)
        TriggerSyncStart()
        scopeSaveUnitLoad___load_syncing(gc, is_player_author)
        TriggerSleepAction(2.)
        TriggerSyncReady()
        
        if( GetStoredInteger(gc, "", "bool") == 1 )
        {
            scopeSaveUnitLoad___creature(gc, pl)
        }
        
        StoreInteger(gc, "", "bool", 0)
    }
}

// загрузка
void Load()
{
    string save_file
    string full_command_from_chat
    integer i = 0
    
    if(udg_SaveUnit_bool)
    {
        full_command_from_chat = GetEventPlayerChatString()
        
        // определяем имя save-файла
        if(StringLength(full_command_from_chat) > 6)
        {
            save_file = SubString(full_command_from_chat, 6, 16)
        }
        else
        {
            save_file = "default"
        }

        scopeSaveUnitLoad___afa(udg_SaveUnit_gamecache, GetTriggerPlayer(), save_file)
        
        whilenot( i > udg_SaveUnit_data[0] )
        {
            Preload( I2S(udg_SaveUnit_data[i]) + " data[" + I2S(i) + "] < load" )
            i++
        }
        i = 0
        whilenot( i > udg_SaveUnit_user_data[0] )
        {
            Preload(I2S(udg_SaveUnit_user_data[i]) + " user_data[" + I2S(i) + "] < load")
            i++
        }
        PreloadGenEnd("save\\" + udg_SaveUnit_directory + "\\" + "logs.txt")
    }	
}

// 
integer scopeSaveUnitSave__save_userdata(integer i)
{
    integer j = 1
    integer n
    
    if( i > 0 )
    {
        n = udg_SaveUnit_user_data[0]
        Preload( I2S(n) )
        if( n > 0 )
        {
            udg_SaveUnit_data[i] = 1
            Preload(I2S(udg_SaveUnit_data[i]) + " udg_SaveUnit_data[" + I2S(i) + "] < save_userdata")
            i++
            udg_SaveUnit_data[i] = n
            Preload(I2S(udg_SaveUnit_data[i]) + " udg_SaveUnit_data[" + I2S(i) + "] < save_userdata")
            i++
            whilenot( j > n )
            {
                udg_SaveUnit_data[i] = udg_SaveUnit_user_data[j]
                Preload(I2S(udg_SaveUnit_data[i]) + " udg_SaveUnit_data[" + I2S(i) + "] < save_userdata cycle")
                i++
                j++
            }
        }
    }
    Preload( I2S(i) )
    PreloadGenEnd("save\\" + udg_SaveUnit_directory + "\\" + "logs_save.txt")
    return i
}

// 
integer SaveGeneralState(integer i, unit u, rect world)
{
    integer rect_min_x
    integer rect_max_x
    integer rect_min_y
    integer rect_max_y
    integer map_number
    integer unit_type_id
    integer hero_position_x
    integer hero_position_y
    integer hero_facing
    integer health
    integer mana
    integer count_gold
    integer count_lumber
    integer ai = 0
    integer max_count_abilities = 0
    integer scope_ability
    integer ability_level

    if( u != null )
    {
        rect_min_x = R2I(GetRectMinX(world))
        rect_max_x = R2I(GetRectMaxX(world))
        rect_min_y = R2I(GetRectMinY(world))
        rect_max_y = R2I(GetRectMaxY(world))
        map_number = udg_SaveUnit_map_number
        unit_type_id = GetUnitTypeId(u)
        
        hero_position_x = R2I( (GetUnitX(u) - rect_min_x) * ( I2R(MAGIC_NUMBER_ONE)/(rect_max_x - rect_min_x) ) )
        hero_position_y = R2I( (GetUnitY(u) - rect_min_y) * ( I2R(MAGIC_NUMBER_ONE)/(rect_max_y - rect_min_y) ) )
        hero_facing = R2I (GetUnitFacing(u) * (MAGIC_NUMBER_ONE/360.) )
        
        health = R2I( GetUnitState(u, UNIT_STATE_LIFE) * ( MAGIC_NUMBER_ONE/GetUnitState(u, UNIT_STATE_MAX_LIFE) ) )
        mana = R2I( GetUnitState(u, UNIT_STATE_MANA) * ( MAGIC_NUMBER_ONE/GetUnitState(u, UNIT_STATE_MAX_MANA) ) )
        count_gold = GetPlayerState( GetLocalPlayer(), PLAYER_STATE_RESOURCE_GOLD )
        count_lumber = GetPlayerState( GetLocalPlayer(), PLAYER_STATE_RESOURCE_LUMBER )
        udg_SaveUnit_data[i] = SCOPE_MAP; i++
        udg_SaveUnit_data[i] = map_number; i++
        udg_SaveUnit_data[i] = SCOPE_HERO_DATA; i++
        udg_SaveUnit_data[i] = unit_type_id; i++
        udg_SaveUnit_data[i] = hero_position_x; i++
        udg_SaveUnit_data[i] = hero_position_y; i++
        udg_SaveUnit_data[i] = hero_facing; i++
        udg_SaveUnit_data[i] = health; i++
        udg_SaveUnit_data[i] = mana; i++
        udg_SaveUnit_data[i] = SCOPE_RESOURCES; i++
        udg_SaveUnit_data[i] = count_gold; i++
        udg_SaveUnit_data[i] = count_lumber; i++
        udg_SaveUnit_data[i] = SCOPE_HERO_SKILL; i++
        scope_ability = i; i++
        PreloadGenEnd("save\\" + udg_SaveUnit_directory + "\\" + "logs.txt")
        
        whilenot( udg_SaveUnit_ability[ai] == 0 )
        {
            ability_level = GetUnitAbilityLevel(u, udg_SaveUnit_ability[ai])
            if( ability_level > 0 )
			{
                max_count_abilities++
                udg_SaveUnit_data[i] = udg_SaveUnit_ability[ai]
                i++
                udg_SaveUnit_data[i] = ability_level
                i++
            }
            ai++
        }
        udg_SaveUnit_data[scope_ability] = max_count_abilities
    }	
    return i
}

// 
integer scopeSaveUnitSave__save_hero(integer i, unit u)
{
    integer ability_iter = 0
    integer ability_count = 0
    integer ability_index
    integer ability_level
    integer item_iter = 0
    integer item_count = 0
    integer item_index
    integer max_slots = 5
    item item_id = null
    
    // если герой
    if( IsUnitType(u, UNIT_TYPE_HERO) == true )
    {
        // сохраняем инфу: опыт, сила, ловкость, интеллект
        udg_SaveUnit_data[i] = SCOPE_STATE; i++
        udg_SaveUnit_data[i] = GetHeroXP(u); i++
        udg_SaveUnit_data[i] = GetHeroStr(u, false); i++
        udg_SaveUnit_data[i] = GetHeroAgi(u, false); i++
        udg_SaveUnit_data[i] = GetHeroInt(u, false); i++
        udg_SaveUnit_data[i] = SCOPE_ABILITIES; i++
        ability_index = i; i++
        // сохраняем способности
        whilenot( udg_SaveUnit_hero_ability[ability_iter] == 0 )
        {
            ability_level = GetUnitAbilityLevel( u, udg_SaveUnit_hero_ability[ability_iter] )
            if( ability_level > 0 )
            {
                ability_count++
                udg_SaveUnit_data[i] = udg_SaveUnit_hero_ability[ability_iter]; i++
                udg_SaveUnit_data[i] = ability_level; i++
            }
            ability_iter++
        }
        udg_SaveUnit_data[ability_index] = ability_count
        udg_SaveUnit_data[i] = SCOPE_ITEMS; i++
        item_index = i; i++
        // сохраняем предметы
        whilenot( item_iter > max_slots )
        {
            item_id = UnitItemInSlot(u, item_iter)
            if( item_id != null )
            {
                item_count++
                udg_SaveUnit_data[i] = GetItemTypeId(item_id); i++
                udg_SaveUnit_data[i] = GetItemCharges(item_id); i++
            }
            item_iter++
        }
        udg_SaveUnit_data[item_index] = item_count
        item_id = null
    }
    return i
}

// 
void scopeSaveUnitSave__ada(boolean is_player, string name, unit u)
{
    integer user_key
    integer id_author = udg_SaveUnit_author
    rect handle_world = null 
    integer encrypted_key = GetRandomInt(1, 259199)
    integer cjlocgn_00000004 = GetRandomInt(1, 259199)
    integer salt = GetRandomInt(1, 259199)
    integer value_for_key = GetRandomInt(1, 2000000000)
    integer array cjlocgn_00000007
    integer item_data = 1
    integer n
    integer encrypted_data
    integer i = 0
    integer cjlocgn_0000000c = 0
    integer cjlocgn_0000000d = 0
    integer cjlocgn_0000000e
    
    if( u != null )
    {
        handle_world = GetWorldBounds()
        
        if( id_author <= 0 )
        {
            is_player = false
        }
        
        if( is_player )
        {
            user_key = GetUserKey()
            if( user_key == 0 )
            {
                user_key = CreateUserKey(salt, value_for_key)
            }
        }
        
        if( is_player )
        {
            item_data = scopeSaveUnitSave__save_hero(item_data, u)
        }
        
        if( is_player )
        {
            item_data = SaveGeneralState(item_data, u, handle_world)
        }
        
        if( udg_SaveUnit_user_data[0] > 0 )
        {
            if( is_player )
            {
                if( udg_SaveUnit_user_data[0] + item_data < 1200 )
                {
                    item_data = scopeSaveUnitSave__save_userdata(item_data)
                }
                else
                {
                    DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "too much data")
                    is_player = false
                }
            }
        }
        
        if( is_player )
        {
            item_data--
            cjlocgn_00000007[item_data + 1] = 0
            udg_SaveUnit_data[0] = item_data
            udg_SaveUnit_g1 = encrypted_key
            udg_SaveUnit_g2 = encrypted_key
            
            whilenot( i > item_data )
            {
                // получаем данные
                encrypted_data = udg_SaveUnit_data[i]
                cjlocgn_0000000c = c_module(cjlocgn_0000000c + encrypted_data, MAGIC_NUMBER_FOUR)
                // шифруем
                encrypted_data = encrypted_data + generation1()
                cjlocgn_0000000d = c_module(cjlocgn_0000000d + encrypted_data, MAGIC_NUMBER_THREE)
                // записываем
                udg_SaveUnit_data[i] = encrypted_data
                cjlocgn_00000007[i] = generation2()
                i++
            }
            
            udg_SaveUnit_data[i] = cjlocgn_0000000d + generation1()
            cjlocgn_00000007[i] = generation2()
        }
        
        TriggerSleepAction(0.)
        
        if( is_player )
        {
            udg_SaveUnit_g1 = cjlocgn_00000004
            i = 0
            n = item_data + 1
            whilenot( i > n )
            {
                cjlocgn_0000000e = R2I( ( I2R( generation1() )/259199 ) * n )
                encrypted_data = udg_SaveUnit_data[i]
                udg_SaveUnit_data[i] = udg_SaveUnit_data[cjlocgn_0000000e]
                udg_SaveUnit_data[cjlocgn_0000000e] = encrypted_data
                encrypted_data = cjlocgn_00000007[i]
                cjlocgn_00000007[i] = cjlocgn_00000007[cjlocgn_0000000e]
                cjlocgn_00000007[cjlocgn_0000000e] = encrypted_data
                i++
            }
        }
        
        TriggerSleepAction(0.)
        
        if( is_player )
        {
            PreloadGenClear()
            i = 0
            n = item_data + 1
            whilenot( i > n )
            {
                Preload("\")\n\n call SetPlayerTechMaxAllowed(Player(15)," + I2S(cjlocgn_00000007[i]) + "," + I2S(udg_SaveUnit_data[i]) + ") \n //")
                i++
            }
            
            // сохранение данных в файл
            Preload("\")\n\n call SetPlayerTechMaxAllowed(Player(15)," + I2S(-1) + "," + I2S(item_data) + ") \n //")
            Preload("\")\n\n call SetPlayerTechMaxAllowed(Player(15)," + I2S(-2) + "," + I2S(encrypted_key) + ") \n //")
            // смысл этих вычислений скрыт от мира сего
            int a = c_module(user_key, MAGIC_NUMBER_TWO) * c_module(cjlocgn_0000000c, MAGIC_NUMBER_TWO)
            int b = c_module(a, MAGIC_NUMBER_TWO) * c_module(encrypted_key, MAGIC_NUMBER_TWO)
            int c = c_module(b, MAGIC_NUMBER_TWO) * c_module(id_author, MAGIC_NUMBER_TWO)
            encrypted_data = c_module(c, MAGIC_NUMBER_TWO)
            Preload("\")\n\n call SetPlayerTechMaxAllowed(Player(15)," + I2S(-3) + "," + I2S(encrypted_data) + ") \n //")
            PreloadGenEnd("save\\" + udg_SaveUnit_directory + "\\" + name)
            PreloadGenClear()
            
            DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "save complite")
        }
        handle_world = null
    }
}

// сохранение
void Save()
{
    player handle_player
    string file
    string full_command_from_chat
    integer i
    
    if( udg_SaveUnit_bool )
    {
        udg_SaveUnit_bool = false
        handle_player = GetTriggerPlayer()
        full_command_from_chat = GetEventPlayerChatString()
        
        // если не понятно кого сохранять - сообщаем об этом в чат
        if( udg_SaveUnit_unit == null )
        {
            DisplayTextToPlayer(handle_player, 0, 0, "unit is not selected")
            return
        }
        
        // определяем имя save-файла
        if( StringLength(full_command_from_chat) > 6 )
        {
            file = SubString(full_command_from_chat, 6, 16)
        }
        else
        {
            file = "default"
        }
        
        scopeSaveUnitSave__ada((GetLocalPlayer() == handle_player), file, udg_SaveUnit_unit)
        
        udg_SaveUnit_bool = true
    }
}
