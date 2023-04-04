-- Copyright (c)  meiso

--- Аналог python функции zip().
--- Объединяет в таблицы элементы из последовательностей переданных в качестве аргументов
function zip(...)
    local args = table.pack(...)
    local array = {}
    local len = #args[1]

    --опеределяем самую маленькую последовательность
    for i = 1, args.n do
        if #args[i] < len then
            len = #args[i]
        end
    end

    for i = 1, len do
        local array_mini = {}
        for j = 1, args.n do
            table.insert(array_mini, args[j][i])
        end
        table.insert(array, array_mini)
    end
    return array
end

--- Разбивает строку по разделителю
---@param inputstr string Строка
---@param sep string Разделитель. По умолчанию пробел
---@return table
function split(inputstr, sep)
    local s = sep or " "
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. s .. "]+)") do
        table.insert(t, str)
    end
    return t
end

--- Загружает toc-файл
---@param file string Путь до toc-файла
---@return nil
function loadTOCFile(file)
    if not BlzLoadTOCFile(file) then
        print("Failed to load: ", file)
    end
end

--- Округляет число
---@param number number
---@return number
function round(number)
    return number >= 0 and math.floor(number + 0.5) or math.ceil(number - 0.5)
end
