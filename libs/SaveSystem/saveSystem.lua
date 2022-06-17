
---
function SaveSystem.creature(gc, pl)
    if gc ~= nil then
        local count = GetStoredInteger(gc, "1", "1")
        for i = 1, count do
            udg_SaveUnit_data[i] = GetStoredInteger(gc, I2S(i), I2S(i))
        end
        TriggerSleepAction(0.)

        -- загружаем общее состояние игрока
        SaveSystem.LoadBaseState(pl)

        if SaveSystem.unit == nil then
            DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "error data")
            return
        end

        TriggerSleepAction(0.)
        SaveSystem.LoadUnitData()
        TriggerSleepAction(0.)
        SaveSystem.LoadUserData()
        DisplayTextToPlayer(pl, 0, 0, "load complite")
    end
end

--- Синхронизирует данные между игроками
function SaveSystem.Syncing(gc, is_player)
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
function SaveSystem.load_uploading(author, user)
    local encrypted_data
    if author > 0 and user > 0 then
        local player_s = Player(25)
        local max_count_data = GetPlayerTechMaxAllowed(player_s, -1)
        local saved_encrypted_key = GetPlayerTechMaxAllowed(player_s, -2)
        SaveSystem.hash1 = saved_encrypted_key
        SaveSystem.hash2 = saved_encrypted_key

        local cjlocgn_00000005 = GetPlayerTechMaxAllowed(player_s, SaveSystem.generation2())
        local check_max_count_data = cjlocgn_00000005 - SaveSystem.generation1()

        if max_count_data == check_max_count_data then
            -- дешифруем
            for i = 2, max_count_data do
                encrypted_data = GetPlayerTechMaxAllowed(player_s, SaveSystem.generation2())
                cjlocgn_00000005 = math.fmod(cjlocgn_00000005 + encrypted_data, SaveSystem.magic_number.three)

                encrypted_data = encrypted_data - SaveSystem.generation1()
                check_max_count_data = math.fmod(check_max_count_data + encrypted_data, SaveSystem.magic_number.four)

                udg_SaveUnit_data[i] = encrypted_data
            end
            udg_SaveUnit_data[1] = max_count_data

            if cjlocgn_00000005 ~= GetPlayerTechMaxAllowed(player_s, SaveSystem.generation2()) - SaveSystem.generation1() then
                DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "error rsum")
                return false
            end

            local result = math.fmod(math.fmod(math.fmod(math.fmod(author, SaveSystem.magic_number.two) *
                               math.fmod(check_max_count_data, SaveSystem.magic_number.two), SaveSystem.magic_number.two) *
                               math.fmod(saved_encrypted_key, SaveSystem.magic_number.two), SaveSystem.magic_number.two) *
                               math.fmod(user, SaveSystem.magic_number.two), SaveSystem.magic_number.two)
            if GetPlayerTechMaxAllowed(player_s, -3) == result then
                return true
            end
        end
        DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "Error load. Pls, take a look \"Allow Local Files\"")
    end
    return false
end

---
function SaveSystem.afa(gc, pl, file_name)
    local is_player_author = false
    local user_key
    local id_player

    if gc ~= nil then
        is_player_author = GetLocalPlayer() == pl
        id_player = SaveSystem.author

        if id_player <= 0 then
            is_player_author = false
        end

        if is_player_author then
            user_key = SaveSystem.GetUserKey()
            if user_key == 0 then
                is_player_author = false
            end
        end

        TriggerSleepAction(0.)

        -- загружаем данные из save-файла
        if is_player_author then
            Preloader("save\\"..SaveSystem.directory.."\\"..file_name)
        end

        TriggerSleepAction(0.)

        if is_player_author then
            is_player_author = SaveSystem.load_uploading(id_player, user_key)
        end

        TriggerSleepAction(0.)
        TriggerSyncStart()
        SaveSystem.Syncing(gc, is_player_author)
        TriggerSleepAction(2.)
        TriggerSyncReady()

        if GetStoredInteger(gc, "bool", "bool") == 1 then
            SaveSystem.creature(gc, pl)
        end

        StoreInteger(gc, "bool", "bool", 0)
    end
end

---
function SaveSystem.Load()
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

        SaveSystem.afa(udg_SaveUnit_gamecache, GetTriggerPlayer(), save_file)

        for i = 1, udg_SaveUnit_data[1] do
            Preload(I2S(udg_SaveUnit_data[i]).." data["..I2S(i).."] < load")
        end
        for i = 1, SaveSystem.user_data[1] do
            Preload(I2S(SaveSystem.user_data[i]).." user_data["..I2S(i).."] < load")
        end
        PreloadGenEnd("save\\"..SaveSystem.directory.."\\".."log_load.txt")
        PreloadGenClear()
    end
end

---
function SaveSystem.ada(is_player, file_name, u)
    local user_key
    local id_author = SaveSystem.author
    local handle_world
    local encrypted_key = GetRandomInt(1, SaveSystem.magic_number.nine)
    local cjlocgn_00000004 = GetRandomInt(1, SaveSystem.magic_number.nine)
    local salt = GetRandomInt(1, SaveSystem.magic_number.nine)
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
            user_key = SaveSystem.GetUserKey()
            if user_key == 0 then
                user_key = SaveSystem.CreateUserKey(salt, value_for_key)
            end
        end

        if is_player then
            item_data = SaveSystem.SaveUnitData(item_data, u)
        end

        if is_player then
            item_data = SaveSystem.SaveBaseState(item_data, u, handle_world)
        end

        if SaveSystem.user_data[1] > 0 then
            if is_player then
                if SaveSystem.user_data[1] + item_data < 1200 then
                    item_data = SaveSystem.SaveUserData(item_data)
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
            SaveSystem.hash1 = encrypted_key
            SaveSystem.hash2 = encrypted_key

            for i = 1, item_data do
                -- получаем данные
                encrypted_data = udg_SaveUnit_data[i]
                cjlocgn_0000000c = math.fmod(cjlocgn_0000000c + encrypted_data, SaveSystem.magic_number.four)
                -- шифруем
                encrypted_data = encrypted_data + SaveSystem.generation1()
                cjlocgn_0000000d = math.fmod(cjlocgn_0000000d + encrypted_data, SaveSystem.magic_number.three)
                -- записываем
                udg_SaveUnit_data[i] = encrypted_data
                cjlocgn_00000007[i] = SaveSystem.generation2()
            end

            udg_SaveUnit_data[item_data + 1] = cjlocgn_0000000d + SaveSystem.generation1()
            cjlocgn_00000007[item_data + 1] = SaveSystem.generation2()
        end

        TriggerSleepAction(0.)

        if is_player then
            SaveSystem.hash1 = cjlocgn_00000004
            n = item_data + 1
            for i = 1, n do
                cjlocgn_0000000e = R2I((I2R(SaveSystem.generation1()) / SaveSystem.magic_number.nine) * n)
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
            local a = math.fmod(user_key, SaveSystem.magic_number.two) * math.fmod(cjlocgn_0000000c, SaveSystem.magic_number.two)
            local b = math.fmod(a, SaveSystem.magic_number.two) * math.fmod(encrypted_key, SaveSystem.magic_number.two)
            local c = math.fmod(b, SaveSystem.magic_number.two) * math.fmod(id_author, SaveSystem.magic_number.two)
            encrypted_data = math.fmod(c, SaveSystem.magic_number.two)
            Preload("\")\n\n call SetPlayerTechMaxAllowed(Player(25),"..I2S(-3)..","..I2S(encrypted_data)..") \n //")
            PreloadGenEnd("save\\"..SaveSystem.directory.."\\"..file_name)
            PreloadGenClear()

            DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "save complite")
        end
    end
end

---
function SaveSystem.Save()
    local file
    if udg_SaveUnit_bool then
        udg_SaveUnit_bool = false
        local handle_player = GetTriggerPlayer()
        local full_command_from_chat = GetEventPlayerChatString()

        -- если не понятно кого сохранять - сообщаем об этом в чат
        if SaveSystem.unit == nil then
            DisplayTextToPlayer(handle_player, 0, 0, "unit is not selected")
            return
        end

        -- определяем имя save-файла
        if StringLength(full_command_from_chat) > 6 then
            file = SubString(full_command_from_chat, 6, 16)..".txt"
        else
            file = "default.txt"
        end

        SaveSystem.ada((GetLocalPlayer() == handle_player), file, SaveSystem.unit)
        udg_SaveUnit_bool = true
    end
end
