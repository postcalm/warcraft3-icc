require 'lfs'

local tools = {}

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
---@param src string
---@param dst string
---@param ignore_files table Список игнорируемых файлов
---@return nil
function CopyFiles(src, dst, ignore_files)
    dofile(lfs.currentdir() .. [[\utils\lib\DirTree.lua]])
    ignore_files = ignore_files or {}
    local skip = false

    for file in lfs.dir(src) do
        for _, i in pairs(ignore_files) do
            if file == i then skip = true end
        end
        if file == "." or file == ".." then skip = true end
        if not skip then
            local infile = io.open(src .. '\\' .. file, "r")
            local instr = infile:read("*a")
            infile:close()

            local outfile = io.open(dst .. '\\' .. file, "w")
            outfile:write(instr)
            outfile:close()
        end
        skip = false
    end
end

return tools
