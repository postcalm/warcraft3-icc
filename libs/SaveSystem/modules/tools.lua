
--- Возвращает итератор на следующую область для считывания данных
---@param index int Текущее значение итератора
---@param current_scope int Текущая область
---@return int Положение следующей области
function SaveSystem.next_scope(index, current_scope)
    if current_scope == SaveSystem.scope.map then
        return index + 2
    end
    if current_scope == SaveSystem.scope.resources then
        return index + 3
    end
    if current_scope == SaveSystem.scope.hero_data then
        return index + 7
    end
    if current_scope == SaveSystem.scope.hero_skill then
        return index + udg_SaveUnit_data[index + 1] * 2 + 2
    end
    -- блок со статами
    if current_scope == SaveSystem.scope.state then
        return index + 5
    end
    -- блок со способностями
    if current_scope == SaveSystem.scope.abilities then
        return index + udg_SaveUnit_data[index + 1] * 2 + 2
    end
    -- блок с предметами
    if current_scope == SaveSystem.scope.items then
        return index + udg_SaveUnit_data[index + 1] * 2 + 2
    end

    -- вернем что угодно, чтобы выйти из цикла
    return GetRandomInt(100000, 2000000)
end

---
function SaveSystem.generation1()
    SaveSystem.hash1 = SaveSystem.hash1 * SaveSystem.magic_number.seven + SaveSystem.magic_number.six
    SaveSystem.hash1 = math.fmod(SaveSystem.hash1, SaveSystem.magic_number.five)
    return SaveSystem.hash1
end

---
function SaveSystem.generation2()
    SaveSystem.hash2 = SaveSystem.hash2 * SaveSystem.magic_number.eight + SaveSystem.magic_number.six
    SaveSystem.hash2 = math.fmod(SaveSystem.hash2, SaveSystem.magic_number.five)
    return SaveSystem.hash2
end
