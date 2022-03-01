--- Created by meiso.
--- DateTime: 25.02.2022 22:21

--- Аналог python функции zip().
--- Объединяет в таблицы элементы из последовательностей
--- переданных в качестве аргументов
function zip(...)
    local args = table.pack(...)
    local array = {}
    local len = #args[1]

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
