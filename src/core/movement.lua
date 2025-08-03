---@author meiso

---@class Movement
Movement = {
    ---@type table[Unit]
    units = {},
    to_up = {},
    to_down = {},
    to_left = {},
    to_right = {},
    animate = {},
    speed = 10,
    ---@type Timer
    timers = {},
    ---@type Logger
    logger = Logger("movement"),
}

--- Инициализация системы передвижения
function Movement.Init(unit, player)
    Movement.logger:Info("Initialize movement system")
    local player_id = GetConvertedPlayerId(player)

    Camera.Register(unit, player)
    KeyboardController.Register(player_id, OSKEY_W, OSKEY_A, OSKEY_S, OSKEY_D)

    if Movement.units[player_id] == nil then
        Movement.units[player_id] = unit
    end
    if Movement.timers[player_id] == nil then
        Movement.timers[player_id] = Timer(0.02)
    end

    Movement._set_default_anim(player_id)
    local timer = Movement.timers[player_id]
    timer:SetFunc(function() Movement._update(player_id) end)
    timer:EnablePeriodic()
    timer:Start()
    Movement.logger:Info("Movement system start!")
end

---@private
function Movement._update(player_id)
    Movement._process(player_id)
    Movement._rotate_camera(player_id)
    Movement._move(player_id)
    Movement._play_anim(player_id)
end

---@private
function Movement._process(player_id)
    for _, k in pairs(KeyboardController.keys:All()) do
        if k.key == OSKEY_W and player_id == k.player_id then
            Movement.to_up[player_id] = k.pressed
        end
        if k.key == OSKEY_S and player_id == k.player_id then
            Movement.to_down[player_id] = k.pressed
        end
        if k.key == OSKEY_A and player_id == k.player_id then
            Movement.to_left[player_id] = k.pressed
        end
        if k.key == OSKEY_D and player_id == k.player_id then
            Movement.to_right[player_id] = k.pressed
        end
    end
end

---@private
function Movement._rotate_camera(player_id)
    local unit = Movement.units[player_id]
    if Movement.to_left[player_id] then
        Camera.TurnLeft(player_id)
        SelectUnitForPlayerSingle(unit:GetId(), PLAYERS[player_id])
        Movement.logger:Debug("to left")
    elseif Movement.to_right[player_id] then
        Camera.TurnRight(player_id)
        SelectUnitForPlayerSingle(unit:GetId(), PLAYERS[player_id])
        Movement.logger:Debug("to right")
    end
end

---@private
function Movement._move(player_id)
    local unit = Movement.units[player_id]
    if Movement.to_up[player_id] then
        SetUnitPositionLoc(unit:GetId(), PolarProjectionBJ(unit:GetLoc(), Movement.speed, unit:GetFacing()))
        SelectUnitForPlayerSingle(unit:GetId(), PLAYERS[player_id])
        Movement.logger:Debug("forward")
    elseif Movement.to_down[player_id] then
        SetUnitPositionLoc(unit:GetId(), PolarProjectionBJ(unit:GetLoc(), -Movement.speed, unit:GetFacing()))
        SelectUnitForPlayerSingle(unit:GetId(), PLAYERS[player_id])
        Movement.logger:Debug("backward")
    end
end

---@private
function Movement._play_anim(player_id)
    local class_ = Session.selected_class[PLAYERS[player_id]]
    ---@type HeroAnimations
    local animations = HERO_ANIMATIONS[class_]
    if Movement.to_up[player_id] and not Movement.animate[player_id] then
        Movement.units[player_id]:SetAnimation { index = animations.move_forward }
        Movement.animate[player_id] = true
    elseif Movement.to_down[player_id] and not Movement.animate[player_id] then
        Movement.units[player_id]:SetAnimation { index = animations.move_backward }
        Movement.animate[player_id] = true
    end
    if not Movement.to_up[player_id] and not Movement.to_down[player_id] and Movement.animate[player_id] then
        Movement._set_default_anim(player_id)
    end
end

---@private
function Movement._set_default_anim(player_id)
    local class_ = Session.selected_class[PLAYERS[player_id]]
    ---@type HeroAnimations
    local animations = HERO_ANIMATIONS[class_]
    Movement.units[player_id]:SetAnimation { index = animations.idle}
    Movement.animate[player_id] = false
end
