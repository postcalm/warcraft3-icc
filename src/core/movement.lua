---@author meiso

---@class Movement
Movement = {
    ---@type Unit
    unit = nil,
    to_up = false,
    to_down = false,
    to_left = false,
    to_right = false,
    animate = false,
    ---@type Logger
    logger = Logger("movement"),
}

--- Инициализация системы передвижения
function Movement.Init()
    Movement.logger:Info("Initialize movement system")
    Camera.Register()
    KeyboardController.Register(OSKEY_W, OSKEY_A, OSKEY_S, OSKEY_D)
    Movement.unit = Camera.unit
    Movement._set_default_anim()
    local movement = Timer(0.03)
    movement:SetFunc(Movement._update)
    movement:EnablePeriodic()
    movement:Start()
    Movement.logger:Info("Movement system start!")
end

---@private
function Movement._update()
    Movement._process()
    Movement._rotate_camera()
    Movement._move()
    Movement._play_anim()
end

---@private
function Movement._process()
    for _, k in pairs(KeyboardController.keys:All()) do
        if k.key == OSKEY_W then
            Movement.to_up = k.pressed
        end
        if k.key == OSKEY_S then
            Movement.to_down = k.pressed
        end
        if k.key == OSKEY_A then
            Movement.to_left = k.pressed
        end
        if k.key == OSKEY_D then
            Movement.to_right = k.pressed
        end
    end
end

---@private
function Movement._rotate_camera()
    if Movement.to_left then
        Camera.TurnLeft()
        SelectUnitForPlayerSingle(Movement.unit:GetId(), GetLocalPlayer())
        Movement.logger:Debug("to left")
    elseif Movement.to_right then
        Camera.TurnRight()
        SelectUnitForPlayerSingle(Movement.unit:GetId(), GetLocalPlayer())
        Movement.logger:Debug("to right")
    end
end

---@private
function Movement._move()
    local unit = Movement.unit
    if Movement.to_up then
        SetUnitPositionLoc(unit:GetId(), PolarProjectionBJ(unit:GetLoc(), 10.0, unit:GetFacing()))
        SelectUnitForPlayerSingle(unit:GetId(), GetLocalPlayer())
        Movement.logger:Debug("to up")
    elseif Movement.to_down then
        SetUnitPositionLoc(unit:GetId(), PolarProjectionBJ(unit:GetLoc(), -10.0, unit:GetFacing()))
        SelectUnitForPlayerSingle(unit:GetId(), GetLocalPlayer())
        Movement.logger:Debug("to down")
    end
end

---@private
function Movement._play_anim()
    if Movement.to_up and not Movement.animate then
        SetUnitAnimationByIndex(Movement.unit:GetId(), 5)
        Movement.animate = true
    elseif Movement.to_down and not Movement.animate then
        SetUnitAnimationByIndex(Movement.unit:GetId(), 13)
        Movement.animate = true
    end
    if not Movement.to_up and not Movement.to_down and Movement.animate then
        Movement._set_default_anim()
    end
end

---@private
function Movement._set_default_anim()
    SetUnitAnimation(Movement.unit:GetId(), "Portrait")
    Movement.animate = false
end
