---@author meiso

-- Based on TriggerHappy implementation (hiveworkshop.com)
-- Lua implementation by Luashine (hiveworkshop.com)

--[[
Features:
 * file overwrite is implemented;
 * only line-by-line recording

!!Attempt!!
Heavily loads the system due to overwriting. Do not use in a real game, or very carefully.
]]--

-- FileIO v1.1.0-lua1.0.1
FileIO = {
    BACKWARDS_COMPATIBILITY = false,
    AbilityList = {
        "Amls", "Aroc", "Amic", "Amil", "Aclf", "Acmg", "Adef", "Adis", "Afbt", "Afbk",
        "ACmo", "ACwe", "ACbn", "ACua", "ACah", "ACnr", "ACat", "ACds", "ACtb", "ACbz",
    },
    AbilityCount = nil, -- set below
    PreloadLimit = 200,

    -- readonly
    -- some vJass stuff to ensure read/writes are from within one scope (code section)
    -- unused ReadEnabled = true,
    -- readonly
    -- unused Counter =
    -- readonly
    List = {},
    cc2Int = function(str)
        local n = 0
        local len = #str
        for i = len, 1, -1 do
            n = n + (str:byte(i, i) << 8 * (len - i))
        end
        return n
    end,
    int2cc = function(int)
        return string.char((int & 0xff000000) >> 24, (int & 0x00ff0000) >> 16, (int & 0x0000ff00) >> 8, int & 0x000000ff):match("[^\0]+")
    end,
}
FileIO.AbilityCount = #FileIO.AbilityList

function FileIO.hasInvalidChars(str)
    -- Original Jass FileIO did not permit double-quotes and backslash
    -- return str:find("[\0\"\\]") and true or false
    -- Instead we'll escape them properly before writing to file
    return str:find("[\0]") and true or false
end

do
    local subst = {
        -- only relevant if we saved it as  pure Lua
        -- the Jass2Lua transpiler works correctly on multiline Jass strings
        --["\n"] = "\\n",
        ["\\"] = "\\\\",
        ['"'] = '\"'
    }
    function FileIO.escapeChars(str)
        -- \n removed, no functional difference to 1.0.0
        return (str:gsub('["\\]', subst))
    end
end

function FileIO:open(fileName)
    if self.file then
        error("FileIO: Cannot use :open() on an existing file")
    end
    local file = {}
    setmetatable(file, { __index = self })
    file.fileName = fileName
    file.buffer = {}

    return file
end

function FileIO:write(contents)
    -- this is used to signify an empty string vs a null one
    local prefix = "-"
    --if self.hasInvalidChars(contents) then
    --    error("FileIO: Invalid character in input: " .. tostring(contents))
    --end
    --contents = FileIO.escapeChars(contents)

    self.buffer = {}

    -- Begin file generation
    PreloadGenClear()
    PreloadGenStart()
    -- loop start
    local abilCount = 0
    local bufOffset = 1

    if isTable(contents) then
        for _, chunk in ipairs(contents) do
            local level = 0
            if abilCount >= self.AbilityCount then
                error("FileIO: String exceeds max length: " .. tostring(self.AbilityCount * self.PreloadLimit))
            end

            Preload(string.format(
                    '" )\ncall BlzSetAbilityTooltip(\037d, "\037s", \037d)\n//',
                    self.cc2Int(self.AbilityList[abilCount + 1]),
                    prefix .. chunk,
                    level
            ))
            bufOffset = bufOffset + self.PreloadLimit
            abilCount = abilCount + 1
        end
    else
        local len = #contents
        while bufOffset < len do
            --print(string.format("bufOffset=\037d, len=\037d", bufOffset, len))
            local level = 0
            if abilCount >= self.AbilityCount then
                error("FileIO: String exceeds max length: " .. tostring(self.AbilityCount * self.PreloadLimit))
            end

            Preload(string.format(
                    '" )\ncall BlzSetAbilityTooltip(\037d, "\037s", \037d)\n//',
                    self.cc2Int(self.AbilityList[abilCount + 1]),
                    prefix .. contents,
                    level
            ))
            bufOffset = bufOffset + self.PreloadLimit
            abilCount = abilCount + 1
        end
    end -- loop end
    Preload('" )\nendfunction\nfunction a takes nothing returns nothing\n //')
    PreloadGenEnd(self.fileName)
    return self
end

function FileIO:clear()
    return self:write("")
end

function FileIO:readPreload()
    local originalDesc = {}
    for n = 1, self.AbilityCount do
        originalDesc[n] = BlzGetAbilityTooltip(self.cc2Int(self.AbilityList[n]), 0)
        --print("Saving orig ab desc: ".. n ..": "..  originalDesc[n])
    end

    -- Execute the preload file
    Preloader(self.fileName)

    local level = 0
    local chunk = ""
    local output = ""
    local output_buffer = {}
    local i = 0

    while true do
        if i == self.AbilityCount then
            break
        end
        level = 0

        -- Make sure the tooltip has changed
        chunk = BlzGetAbilityTooltip(self.cc2Int(self.AbilityList[i + 1]), level)
        --print("Loaded chunk=".. tostring(chunk))
        if chunk == originalDesc[i + 1] then
            if i == 0 and output == "" then
                -- empty file
                return output_buffer
            end
            return output_buffer
        end

        if not self.BACKWARDS_COMPATIBILITY then
            if i == 0 then
                if chunk:sub(1, 1) ~= "-" then
                    -- empty file
                    return output_buffer
                end
                -- exclude first "-" symbol
                chunk = chunk:sub(2)
            end
        end

        -- remove prefix
        if i > 0 then
            chunk = chunk:sub(2)
        end
        -- restore original
        --print("Restoring original tooltip i=".. i)
        BlzSetAbilityTooltip(self.cc2Int(self.AbilityList[i + 1]), originalDesc[i + 1], level)
        output = output .. chunk
        output_buffer[i + 1] = chunk

        i = i + 1
    end

    return output_buffer
end

function FileIO:create(fileName)
    return self:open(fileName):write("")
end

function FileIO:close()
    local output = ""
    for _, msg in  ipairs(self:readPreload()) do
        output = output .. msg
    end
    if #self.buffer > 0 then
        self:write(output .. table.concat(self.buffer))
    end
end

function FileIO:readEx(toClose)
    local output = ""
    for _, msg in  ipairs(self:readPreload()) do
        output = output .. msg
    end
    local buf = table.concat(self.buffer)

    if toClose then
        self:close()
    end
    if output == nil then
        return buf
    end

    if buf ~= nil then
        output = output .. buf
    end

    return output
end

function FileIO:read()
    return self:readEx(false)
end

function FileIO:readAndClose()
    return self:readEx(true)
end

function FileIO:appendBuffer(str)
    table.insert(self.buffer, str)
    return self
end

function FileIO:readBuffer()
    return table.concat(self.buffer)
end

function FileIO:writeBuffer(str)
    if type(str) == "table" then
        self.buffer = str
    elseif type(str) == "string" then
        self.buffer = { str }
    else
        error("Expected new buffer of type table/string, received: " .. type(str))
    end
    return nil
end

function FileIO:Write(fileName, text)
    self:open(fileName):write(text):close()
    return nil
end

function FileIO:Read(fileName)
    return self:open(fileName):readEx(true)
end
