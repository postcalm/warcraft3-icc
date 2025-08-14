---@author meiso
--- Thanks Nelloy xgm.guru

---@class ScreenGrid
ScreenGrid = {
    COLUMNS = 7,
    ROWS = 7,
    pos = Vector(0, 0),
    size = Vector(0, 0),
    ---@type table[Frame]
    buttons = {},
    ---@type table[Frame]
    tools = {},
}

ScreenGrid.__index = ScreenGrid

setmetatable(ScreenGrid, {
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
    end,
})

---@param position Vector
function ScreenGrid:SetPosition(position)
    self.pos = position
    self:_update()
end

---@param size Vector
function ScreenGrid:SetSize(size)
    self.size = size
    self:_update()
end

---@return (boolean, Vector, Vector)
function ScreenGrid:MouseROI()
    local width = self.size.x / self.COLUMNS
    local height = self.size.y / self.ROWS
    local found

    for x = 1, self.COLUMNS do
        for y = 1, self.ROWS do
            found = self.tools[x][y]:IsVisible()
            if found then
                print(self.pos, Vector(x * width, y * height))
                return true, self.pos + Vector(x * width, y * height), Vector(width, height)
            end
        end
    end

    return false, nil, nil
end

---@private
function ScreenGrid:_init()
    local parent = Frame:GetFrameByName("ConsoleUIBackdrop", 0)
    ---@type Frame
    local button
    ---@type Frame
    local tool

    for x = 1, self.COLUMNS do
        self.buttons[x] = {}
        self.tools[x] = {}
        for y = 1, self.ROWS do
            button = Frame("ScriptDialogButton", parent)
            button:SetAlpha(25)
            button:SetAbsPoint(FRAMEPOINT_BOTTOMLEFT, 0, 0)
            button:SetSize(0, 0)
            self.buttons[x][y] = button

            tool = Frame:CreateFrameByType("FRAME", "FaceFrame", parent)
            tool:SetAlpha(0)
            tool:SetAbsPoint(FRAMEPOINT_BOTTOMLEFT, 0, 0)
            tool:SetSize(0, 0)
            self.tools[x][y] = tool

            button:SetCustomTooltip(tool)
        end
    end
end

---@private
function ScreenGrid:_update()
    local size = Vector(
            self.size.x / self.COLUMNS,
            self.size.y / self.ROWS
    )
    ---@type Frame
    local button

    for x = 1, self.COLUMNS do
        for y = 1, self.ROWS do
            button = self.buttons[x][y]
            button:SetSize(size.x, size.y)
            button:SetAbsPoint(FRAMEPOINT_BOTTOMLEFT, self.pos.x + x * size.x, self.pos.y + y * size.y)
        end
    end
end
