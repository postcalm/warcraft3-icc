-- Copyright (c) meiso

--- Возвращает ключ игрока
---@return int Ключ игрока
function SaveSystem.GetUserKey()
    if SaveSystem.author > 0 then
        Preloader("save\\" .. SaveSystem.directory .. "\\" .. "user.txt")
        local public_key = GetPlayerTechMaxAllowed(Player(25), -1)
        local secret_key = GetPlayerTechMaxAllowed(Player(25), 0)
        if public_key == nil then
            return 0
        end
        if public_key <= 0 or public_key / 8286 > SaveSystem.magic_number.nine then
            return 0
        end

        SaveSystem.hash1 = public_key

        secret_key = secret_key - SaveSystem.generation1()
        if secret_key <= 0 then
            return 0
        end
        return secret_key
    end
    return 0
end

--- Генерирует ключ игрока
---@param salt integer "Соль" для ключа
---@param val integer Значение для генерации ключа
---@return integer Ключ игрока
function SaveSystem.CreateUserKey(salt, val)
    if SaveSystem.author > 0 then
        SaveSystem.hash1 = salt
        PreloadGenClear()
        Preload("\")\n call SetPlayerTechMaxAllowed(Player(25)," .. I2S(-1) .. "," .. I2S(salt) .. ") \n //")
        Preload("\")\n call SetPlayerTechMaxAllowed(Player(25)," .. I2S(0) .. "," .. I2S(val + SaveSystem.generation1()) .. ") //")
        PreloadGenEnd("save\\" .. SaveSystem.directory .. "\\" .. "user.txt")
        return val
    end
    return 0
end

--- Сохраняет пользовательские данные
---@param i integer
---@return integer
function SaveSystem.SaveUserData(i)
    if i > 0 then
        local n = SaveSystem.user_data[1]
        if n > 0 then
            SaveSystem.data[i] = 1
            i = i + 1
            SaveSystem.data[i] = n
            i = i + 1
            for j = 2, n do
                SaveSystem.data[i] = SaveSystem.user_data[j]
                i = i + 1
            end
        end
    end
    return i
end

--- Загружает пользовательские данные
---@return nil
function SaveSystem.LoadUserData()
    if SaveSystem.data[1] > 0 then
        local case = -1
        local i = 2
        local count = SaveSystem.data[1]
        while i < count do
            case = SaveSystem.data[i]
            if case == 1 then
                local max_count_data = SaveSystem.data[i + 1]
                local cjlocgn_00000004 = i + 1
                for j = 2, max_count_data do
                    SaveSystem.user_data[j] = SaveSystem.data[cjlocgn_00000004 + j]
                end
                SaveSystem.user_data[1] = max_count_data
            end
            i = SaveSystem.next_scope(i, case)
        end
    end
end

