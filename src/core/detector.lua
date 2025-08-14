---@author meiso
--- Thanks Nelloy xgm.guru

--- Модуль, определяющий положение мыши на экране
MouseDetector = {
    ROI = 3,
    GRID_SIZE = 7,
    precision = 0.01,
    grid = nil,
    pos = nil,
    size = nil,
}

function MouseDetector.Init()
    local timer = Timer(0.5)
    MouseDetector.pos = Screen.pos
    MouseDetector.size = Screen.size

    MouseDetector.grid = ScreenGrid()

    timer:EnablePeriodic()
    timer:SetFunc(function()
        MouseDetector.pos = Screen.pos
        MouseDetector.size = Screen.size
        MouseDetector.grid.pos = MouseDetector.pos
        MouseDetector.grid.size = MouseDetector.size
        MouseDetector._getBetterPosition()
    end)
    timer:Start()
end

function MouseDetector._getBetterPosition()
    local timer = Timer(0.025)
    timer:SetFunc(function()
        timer:Destroy()

        local found, pos, size = MouseDetector.grid:MouseROI()
        MouseDetector.pos = pos
        MouseDetector.size = size

        if not found then
            return
        end

        --print(MouseDetector.pos, MouseDetector.size, ((MouseDetector.ROI - 1) / 2))
        local new_pos = MouseDetector.pos - MouseDetector.size * ((MouseDetector.ROI - 1) / 2)
        local new_size = MouseDetector.size * MouseDetector.ROI
        --print("new", new_pos, new_size)
        MouseDetector.grid:SetPosition(new_pos)
        MouseDetector.grid:SetSize(new_size)

        print("pos", MouseDetector.pos)
        print("size", MouseDetector.size)
        if MouseDetector.size.x > MouseDetector.precision or MouseDetector.size.y > MouseDetector.precision then
            MouseDetector._getBetterPosition()
        end
    end)
    timer:Start()
end
