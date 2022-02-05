include "common/spells.j"

define 
{
	SCOPE_STATE = 6
	SCOPE_ABILITIES = 7
	SCOPE_ITEMS = 8
}

// перерождение всех юнитов по таймеру
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
	udg_SaveUnit_g1 = udg_SaveUnit_g1 * 7141 + 54773
	udg_SaveUnit_g1 = c_module(udg_SaveUnit_g1, 259200)
	return udg_SaveUnit_g1
}

// 
integer generation2()
{	
	udg_SaveUnit_g2 = udg_SaveUnit_g2 * 421 + 54773
    udg_SaveUnit_g2 = c_module(udg_SaveUnit_g2, 259200)
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
	if(udg_SaveUnit_author > 0)
    {
		udg_SaveUnit_g1 = salt
		PreloadGenClear()
		Preload("\")\n call SetPlayerTechMaxAllowed(Player(15)," + I2S(-1) + "," + I2S(salt) + ") \n //")
		Preload("\")\n call SetPlayerTechMaxAllowed(Player(15)," + I2S(0) + "," + I2S( val + generation1() ) + ") //")
		PreloadGenEnd("save\\" + udg_SaveUnit_directory + "\\" + "user")
		return val
    }
	
	return 0
}

// аналог switch - case
integer scopeSaveUnitLoad___next(integer i, integer current_scope)
{
	if(current_scope == 2)
    {
		sBJDebugMsg("current_scope 2 %i", i + 2)
		return i + 2 // 30
    }
	if(current_scope == 3)
    {
		sBJDebugMsg("current_scope 3 %i", i + 3)
		return i + 3 // 40 
	}
	if(current_scope == 4)
    {
		sBJDebugMsg("current_scope 4 %i", i + 7)
		return i + 7 // 37
	}
	if(current_scope == 5)
    {
		sBJDebugMsg("current_scope 5 %i", i + udg_SaveUnit_data[i + 1] * 2 + 2)
		return i + udg_SaveUnit_data[i + 1] * 2 + 2 // 42
	}
	// блок со статами
	if(current_scope == SCOPE_STATE)
    {
		return i + 5
	}
	// блок со способностями
	if(current_scope == SCOPE_ABILITIES)
    {
		return i + udg_SaveUnit_data[i + 1] * 2 + 2 // 12
	}
	// блок с предметами
	if(current_scope == SCOPE_ITEMS)
    {
		return i + udg_SaveUnit_data[i + 1] * 2 + 2 // 14
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
	integer j
	
	if( udg_SaveUnit_data[0] > 0 )
    {
		case = -1
		i = 1
		n = udg_SaveUnit_data[0]
		whilenot( i > n)
        {
			case = udg_SaveUnit_data[i]
			if(case == 1)
            {
				cjlocgn_00000003 = udg_SaveUnit_data[i + 1] // 1
				cjlocgn_00000004 = i + 1 // n - 1
				j = 1
				whilenot( j > cjlocgn_00000003 )
				{
					udg_SaveUnit_user_data[j] = udg_SaveUnit_data[cjlocgn_00000004 + j]
					j = j + 1
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
	integer case
	integer maximum_data
	integer cjlocgn_00000007
	integer cjlocgn_00000008
	integer cjlocgn_00000009
	
	if( udg_SaveUnit_unit != null )
	{
		current_unit = udg_SaveUnit_unit
		unit_loc_x = GetUnitX(current_unit)
		unit_loc_y = GetUnitY(current_unit)
		current_case = -1
		case = 1
		maximum_data = udg_SaveUnit_data[0]
		whilenot( case > maximum_data )
		{
			current_case = udg_SaveUnit_data[case]
			// выдаем предметы
			if( current_case == SCOPE_ITEMS )
			{
				cjlocgn_00000007 = udg_SaveUnit_data[case + 1]
				cjlocgn_00000008 = case + 2
				whilenot( cjlocgn_00000007 <= 0 )
				{
					current_item = CreateItem(udg_SaveUnit_data[cjlocgn_00000008], unit_loc_x, unit_loc_y)
					UnitAddItem(current_unit, current_item)
					SetItemCharges(current_item, udg_SaveUnit_data[cjlocgn_00000008 + 1])
					cjlocgn_00000008 = cjlocgn_00000008 + 2
					cjlocgn_00000007 = cjlocgn_00000007 - 1
				}
			}
			
			// проставляем статы
			if( current_case == SCOPE_STATE )
			{
				SetHeroXP(current_unit, udg_SaveUnit_data[case + 1], false)
				if GetHeroStr(current_unit, false) < udg_SaveUnit_data[case + 2]
				{
					SetHeroStr(current_unit, udg_SaveUnit_data[case + 2], false)
				}
				if GetHeroAgi(current_unit, false) < udg_SaveUnit_data[case + 3]
				{
					SetHeroAgi(current_unit, udg_SaveUnit_data[case + 3], false)
				}
				if GetHeroInt(current_unit, false) < udg_SaveUnit_data[case + 4]
				{
					SetHeroInt(current_unit, udg_SaveUnit_data[case + 4], false)
				}
			}
			
			if( current_case == 5 )
			{
				cjlocgn_00000007 = udg_SaveUnit_data[case + 1]
				cjlocgn_00000008 = case + 2
				whilenot( cjlocgn_00000007 <= 0 )
				{
					cjlocgn_00000009 = udg_SaveUnit_data[cjlocgn_00000008 + 1]
					whilenot( cjlocgn_00000009 <= 0 )
					{
						SelectHeroSkill(current_unit, udg_SaveUnit_data[cjlocgn_00000008])
						cjlocgn_00000009 = cjlocgn_00000009 - 1
					}
					cjlocgn_00000008 = cjlocgn_00000008 + 2
					cjlocgn_00000007 = cjlocgn_00000007 - 1
				}
			}

			// выдаем способности
			if( current_case == SCOPE_ABILITIES )
			{
				cjlocgn_00000007 = udg_SaveUnit_data[case + 1]
				cjlocgn_00000008 = case + 2
				whilenot( cjlocgn_00000007 <= 0 )
				{
					UnitAddAbility(current_unit, udg_SaveUnit_data[cjlocgn_00000008])
					SetUnitAbilityLevel(current_unit, udg_SaveUnit_data[cjlocgn_00000008], udg_SaveUnit_data[cjlocgn_00000008 + 1])
					cjlocgn_00000008 = cjlocgn_00000008 + 2
					cjlocgn_00000007 = cjlocgn_00000007 - 1
				}
			}
			case = scopeSaveUnitLoad___next(case, current_case)
		}
		current_unit = null
		current_item = null
	}
}

// загрузка общих данных о игроке
function LoadGeneralState takes player pl returns nothing

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
	
	if udg_SaveUnit_data[0] > 0 then
		rect_min_x = R2I(GetRectMinX(GetWorldBounds()))
		rect_max_x = R2I(GetRectMaxX(GetWorldBounds()))
		rect_min_y = R2I(GetRectMinY(GetWorldBounds()))
		rect_max_y = R2I(GetRectMaxY(GetWorldBounds()))
		map_number = -1
		i = 1
		case = -1
		n = udg_SaveUnit_data[0]
		
		
		loop
			exitwhen i > n
			case = udg_SaveUnit_data[i]
			if case == 2 then
				map_number = udg_SaveUnit_data[i + 1]
			endif
			
			if case == 3 then
				count_gold = udg_SaveUnit_data[i + 1]
				count_lumber = udg_SaveUnit_data[i + 2]
			endif
			
			if case == 4 then
				unit_id = udg_SaveUnit_data[i + 1]
				// местоположение игрока в месте где он сохранялся
				unit_x = rect_min_x + (rect_max_x - rect_min_x) * (I2R(udg_SaveUnit_data[i + 2])/18259200)
				unit_y = rect_min_y + (rect_max_y - rect_min_y) * (I2R(udg_SaveUnit_data[i + 3])/18259200)
				unit_rotate = 360. * (I2R(udg_SaveUnit_data[i + 4])/18259200)
				health = udg_SaveUnit_data[i + 5]
				mana = udg_SaveUnit_data[i + 6]
			endif
			i = scopeSaveUnitLoad___next(i, case)
		endloop
		
		if map_number != udg_SaveUnit_map_number then
			unit_x = udg_SaveUnit_x
			unit_y = udg_SaveUnit_y
		endif
		
		unit_obj = CreateUnit(pl, unit_id, unit_x, unit_y, unit_rotate)
		udg_SaveUnit_unit = unit_obj
		
		if unit_obj != null then
			call SetUnitState(unit_obj, UNIT_STATE_LIFE, GetUnitState(unit_obj, UNIT_STATE_MAX_LIFE) * (I2R(health)/18259200))
			call SetUnitState(unit_obj, UNIT_STATE_MANA, GetUnitState(unit_obj, UNIT_STATE_MAX_MANA) * (I2R(mana)/18259200))
			call SetPlayerState(pl, PLAYER_STATE_RESOURCE_GOLD, count_gold)
			call SetPlayerState(pl, PLAYER_STATE_RESOURCE_LUMBER, count_lumber)
			unit_obj = null
		endif
	endif
	
endfunction

// 
function scopeSaveUnitLoad___creature takes gamecache gc, player pl returns nothing

	integer i
	integer n
	
	if gc != null then
		i = 0
		n = GetStoredInteger(gc, "", "0")
		loop
			exitwhen i > n
			udg_SaveUnit_data[i] = GetStoredInteger(gc, "", I2S(i))
			i++
		endloop
		
		call TriggerSleepAction(0.)
		
		// загружаем общее состояние игрока
		call LoadGeneralState(pl)
		
		if udg_SaveUnit_unit == null then
			call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "error data")
			return        
		endif
		
		call TriggerSleepAction(0.)
		call scopeSaveUnitLoad___load_forunit()
		call TriggerSleepAction(0.)
		call scopeSaveUnitLoad___load_userdata()
		call DisplayTextToPlayer(pl, 0, 0, "load comlite")
	endif
	
endfunction

// 
function scopeSaveUnitLoad___load_syncing takes gamecache gc, boolean is_player returns nothing

	integer cjlocgn_00000000
	integer cjlocgn_00000001
	
	if is_player then
		cjlocgn_00000000 = 0
		cjlocgn_00000001 = udg_SaveUnit_data[0]
		loop
			exitwhen cjlocgn_00000000 > cjlocgn_00000001
			call StoreInteger(gc, "", I2S(cjlocgn_00000000), udg_SaveUnit_data[cjlocgn_00000000])
			call SyncStoredInteger(gc, "", I2S(cjlocgn_00000000))
			cjlocgn_00000000 = cjlocgn_00000000 + 1
		endloop
		call StoreInteger(gc, "", "bool", 1)
		call SyncStoredInteger(gc, "", "bool")
	endif
	
endfunction

// 
function scopeSaveUnitLoad___load_uploading takes integer author, integer user returns boolean

	player number_player
	integer count_item
	integer saved_encrypted_key
	integer encrypted_data
	integer i
	integer cjlocgn_00000005
	integer check_count_item
	integer result
	
	
	if author > 0 and user > 0 then
		number_player = Player(15)
		
		count_item = GetPlayerTechMaxAllowed(number_player, -1)
		saved_encrypted_key = GetPlayerTechMaxAllowed(number_player, -2)
		
		i = 1
		udg_SaveUnit_g1 = saved_encrypted_key
		udg_SaveUnit_g2 = saved_encrypted_key
		
		cjlocgn_00000005 = GetPlayerTechMaxAllowed(number_player, generation2())
		
		check_count_item = cjlocgn_00000005 - generation1()
		
		if count_item == check_count_item then
			// дешифруем
			loop
				exitwhen i > count_item
				
				encrypted_data = GetPlayerTechMaxAllowed(number_player, generation2())
				cjlocgn_00000005 = c_module(cjlocgn_00000005 + encrypted_data, 259183)
				
				encrypted_data = encrypted_data - generation1()
				check_count_item = c_module(check_count_item + encrypted_data, 129593)
				
				udg_SaveUnit_data[i] = encrypted_data
				i++
			endloop
			udg_SaveUnit_data[0] = count_item
			
			if cjlocgn_00000005 != GetPlayerTechMaxAllowed(number_player, generation2()) - generation1() then
				call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "error rsum")
				return false
			endif
			
			result = c_module(c_module(c_module(c_module(author, 44711) * c_module(check_count_item, 44711), 44711) * c_module(saved_encrypted_key, 44711), 44711) * c_module(user, 44711), 44711)
			if GetPlayerTechMaxAllowed(number_player, -3) == result then
				return true
			endif
			
		endif
		call PreloadGenEnd("save\\" + udg_SaveUnit_directory + "\\logs.txt")
		call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "Error load. Pls, take a look \"Allow Local Files\"")
	endif
	return false
	
endfunction

// 
function scopeSaveUnitLoad___afa takes gamecache gc, player pl, string name returns nothing

	boolean is_player_author
	integer user_key
	integer id_player
	
	if gc != null then
		is_player_author = (GetLocalPlayer() == pl)
		id_player = udg_SaveUnit_author
		
		if id_player <= 0 then
			is_player_author = false
		endif
		
		if is_player_author then
			user_key = GetUserKey()
			if user_key == 0 then
				is_player_author = false
			endif
		endif
		
		call TriggerSleepAction(0.)
		
		// загружаем данные из save-файла
		if is_player_author then
			call Preloader("save\\" + udg_SaveUnit_directory + "\\" + name)
		endif
		
		call TriggerSleepAction(0.)
		
		if is_player_author then
			is_player_author = scopeSaveUnitLoad___load_uploading(id_player, user_key)
		endif
		
		call TriggerSleepAction(0.)
		call TriggerSyncStart()
		call scopeSaveUnitLoad___load_syncing(gc, is_player_author)
		call TriggerSleepAction(2.)
		call TriggerSyncReady()
		
		if GetStoredInteger(gc, "", "bool") == 1 then
			call scopeSaveUnitLoad___creature(gc, pl)
		endif
		
		call StoreInteger(gc, "", "bool", 0)
	endif
	
endfunction

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
function scopeSaveUnitSave__save_userdata takes integer i returns integer

	integer j
	integer n
	
	if i > 0 then
		j = 1
		n = udg_SaveUnit_user_data[0]
		call Preload(I2S(n))
		if n > 0 then
			udg_SaveUnit_data[i] = 1
			call Preload(I2S(udg_SaveUnit_data[i]) + " udg_SaveUnit_data[" + I2S(i) + "] < save_userdata")
			i++
			udg_SaveUnit_data[i] = n
			call Preload(I2S(udg_SaveUnit_data[i]) + " udg_SaveUnit_data[" + I2S(i) + "] < save_userdata")
			i++
			loop
				exitwhen j > n
				udg_SaveUnit_data[i] = udg_SaveUnit_user_data[j]
				call Preload(I2S(udg_SaveUnit_data[i]) + " udg_SaveUnit_data[" + I2S(i) + "] < save_userdata cycle")
				i++
				j = j + 1
			endloop
			
		endif
	endif
	call Preload(I2S(i))
	call PreloadGenEnd("save\\" + udg_SaveUnit_directory + "\\" + "logs.txt")
	return i
	
endfunction

// 
int SaveGeneralState(integer i, unit u, rect world)
{
	integer rect_min_x
	integer rect_max_x
	integer rect_min_y
	integer rect_max_y
	integer map_number
	integer unit_type_id
	integer cjlocgn_00000006
	integer cjlocgn_00000007
	integer cjlocgn_00000008
	integer health
	integer mana
	integer count_gold
	integer count_lumber
	integer ability_item
	integer cjlocgn_0000000e
	integer cjlocgn_0000000f
	integer ability_level

	if( u != null )
	{
		rect_min_x = R2I(GetRectMinX(world))
		rect_max_x = R2I(GetRectMaxX(world))
		rect_min_y = R2I(GetRectMinY(world))
		rect_max_y = R2I(GetRectMaxY(world))
		map_number = udg_SaveUnit_map_number
		unit_type_id = GetUnitTypeId(u)
		
		cjlocgn_00000006 = R2I((GetUnitX(u) - rect_min_x) * (I2R(18259200)/(rect_max_x - rect_min_x)))
		cjlocgn_00000007 = R2I((GetUnitY(u) - rect_min_y) * (I2R(18259200)/(rect_max_y - rect_min_y)))
		cjlocgn_00000008 = R2I(GetUnitFacing(u) * (18259200/360.))
		
		health = R2I(GetUnitState(u, UNIT_STATE_LIFE) * (18259200/GetUnitState(u, UNIT_STATE_MAX_LIFE)))
		mana = R2I(GetUnitState(u, UNIT_STATE_MANA) * (18259200/GetUnitState(u, UNIT_STATE_MAX_MANA)))
		count_gold = GetPlayerState(GetLocalPlayer(), PLAYER_STATE_RESOURCE_GOLD)
		count_lumber = GetPlayerState(GetLocalPlayer(), PLAYER_STATE_RESOURCE_LUMBER)
		udg_SaveUnit_data[i] = 2
		i++
		udg_SaveUnit_data[i] = map_number
		i++
		udg_SaveUnit_data[i] = 4
		i++
		udg_SaveUnit_data[i] = unit_type_id
		i++
		udg_SaveUnit_data[i] = cjlocgn_00000006
		i++
		udg_SaveUnit_data[i] = cjlocgn_00000007
		i++
		udg_SaveUnit_data[i] = cjlocgn_00000008
		i++
		udg_SaveUnit_data[i] = health
		i++
		udg_SaveUnit_data[i] = mana
		i++
		udg_SaveUnit_data[i] = 3
		i++
		udg_SaveUnit_data[i] = count_gold
		i++
		udg_SaveUnit_data[i] = count_lumber
		i++
		udg_SaveUnit_data[i] = 5
		i++
		ability_item = 0
		cjlocgn_0000000e = 0
		cjlocgn_0000000f = i
		i++
		call PreloadGenEnd("save\\" + udg_SaveUnit_directory + "\\" + "logs.txt")
		
		whilenot( udg_SaveUnit_ability[ability_item] == 0 )
		{
			ability_level = GetUnitAbilityLevel(u, udg_SaveUnit_ability[ability_item])
			if ability_level > 0 then
				cjlocgn_0000000e = cjlocgn_0000000e + 1
				udg_SaveUnit_data[i] = udg_SaveUnit_ability[ability_item]
				i++
				udg_SaveUnit_data[i] = ability_level
				i++
			endif
			ability_item = ability_item + 1
		}
		udg_SaveUnit_data[cjlocgn_0000000f] = cjlocgn_0000000e
	}	
	return i
}

// 
integer scopeSaveUnitSave__save_hero(integer i, unit u)
{
	integer hero_exp
	integer hero_str
	integer hero_agi
	integer hero_int
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
		hero_exp = GetHeroXP(u)
		hero_str = GetHeroStr(u, false)
		hero_agi = GetHeroAgi(u, false)
		hero_int = GetHeroInt(u, false)
		udg_SaveUnit_data[i] = SCOPE_STATE; i++
		udg_SaveUnit_data[i] = hero_exp; i++
		udg_SaveUnit_data[i] = hero_str; i++
		udg_SaveUnit_data[i] = hero_agi; i++
		udg_SaveUnit_data[i] = hero_int; i++
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
				cjlocgn_0000000c = c_module(cjlocgn_0000000c + encrypted_data, 129593) // 0
				// шифруем
				encrypted_data = encrypted_data + generation1()
				cjlocgn_0000000d = c_module(cjlocgn_0000000d + encrypted_data, 259183) // 0
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
			i = -1
			n = item_data + 1
			whilenot( i++ > n )
			{
				Preload("\")\n\n call SetPlayerTechMaxAllowed(Player(15)," + I2S(cjlocgn_00000007[i]) + "," + I2S(udg_SaveUnit_data[i]) + ") \n //")
			}
			
			// сохранение данных в файл
			Preload("\")\n\n call SetPlayerTechMaxAllowed(Player(15)," + I2S(-1) + "," + I2S(item_data) + ") \n //")
			Preload("\")\n\n call SetPlayerTechMaxAllowed(Player(15)," + I2S(-2) + "," + I2S(encrypted_key) + ") \n //")
			encrypted_data = c_module( c_module( c_module( c_module( user_key, 44711 ) * \
									   c_module( cjlocgn_0000000c, 44711 ), 44711 ) * \
									   c_module( encrypted_key, 44711 ), 44711 ) * c_module( id_author, 44711 ), 44711 )
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
	
	if udg_SaveUnit_bool
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
