require 'lfs'

local tools = {}

function GetCatalog(dirs)
    for i = 1, #dirs do
        if IsDir(dirs[i]) then
            return dirs[i]
        end
    end
end

function IsDir(name)
    if type(name) ~= "string" then return false end
    local cd = lfs.currentdir()
    local is = lfs.chdir(name) and true or false
    lfs.chdir(cd)
    return is
end

function WriteToFile(customCode, path)
    for line in io.lines(path) do
        customCode:write(line, '\n')
    end
    customCode:write('\n')
end

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
