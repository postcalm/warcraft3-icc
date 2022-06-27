
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

return tools
