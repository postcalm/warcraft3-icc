--- Created by meiso.
--- DateTime: 25.02.2022

--- Аналог python функции zip().
--- Объединяет в таблицы элементы из последовательностей
--- переданных в качестве аргументов
function zip(...)
    local args = table.pack(...)
    local array = {}
    local len = #args[1]

    --опеределяем самую маленькую последовательность
    for i = 1, args.n do
        if #args[i] < len then len = #args[i] end
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

---@param number number
---@return number
function Round(number)
    return number >= 0 and math.floor(number + 0.5) or math.ceil(number - 0.5)
end

function convertLength(len)
    return Round(Round(len) / 100)
end