--https://stackoverflow.com/questions/11201262/how-to-read-data-from-a-file-in-lua
local open = io.open
function FileContent(path)
    local file = open(path, 'rb') -- r read mode and b binary mode
    if not file then return nil end
    local content = file:read '*a' -- *a or *all reads the whole file
    file:close()
    return content
end