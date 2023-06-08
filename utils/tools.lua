require 'lfs'
require "utils.lib.DirTree"

local tools = {}

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

--- Вернуть каталог, если тот существует
---@param dirs string Список каталогов
---@return string
function GetCatalog(dirs)
    for i = 1, #dirs do
        if IsDir(dirs[i]) then
            return dirs[i]
        end
    end
end

--- Проверяет является ли элемент каталогом
---@param name string
---@return boolean
function IsDir(name)
    if type(name) ~= "string" then return false end
    local cd = lfs.currentdir()
    local is = lfs.chdir(name) and true or false
    lfs.chdir(cd)
    return is
end

--- Записать в файл содержимое другого файла
---@param dst file
---@param src string
---@return nil
function WriteToFile(dst, src)
    for line in io.lines(src) do
        dst:write(line, '\n')
    end
    dst:write('\n')
end

--- Копирует файлы в указанный каталог
---@param src string Источник
---@param dst string Место назначения
---@param ignore_files table Список игнорируемых файлов
---@return nil
function CopyFiles(src, dst, ignore_files)
    ignore_files = ignore_files or {}
    local skip = false
    local s
    local bytes
    local mode = ""

    for file, attr in DirTree(src) do
        if attr.mode == 'file' then
            s = split(file, "\\")
            s = s[#s]
            for _, i in pairs(ignore_files) do
                if s == i then skip = true end
            end
            if file == "." or file == ".." then skip = true end
            if not skip then
                bytes = s:match "[^.][BLP|blp|mdl|mdx]+$"
                if bytes ~= nil then mode = "b" end
                local infile = io.open(file, "r" .. mode)
                local instr = infile:read("*a")
                infile:close()

                local outfile = io.open(dst .. '\\' .. s, "w" .. mode)
                outfile:write(instr)
                outfile:close()
            end
            skip = false
        end
    end
end

return tools
