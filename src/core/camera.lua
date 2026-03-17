---@author meiso

---@class Camera
Camera = {
    -- дистанция камеры
    dist = 800.,
    -- скорость поворота
    rotate_spd = 10,
    -- время обновления камеры
    update_time = 0.02,
    -- высота камеры по оси z
    angle = -20.,
    ---@type table[Unit]
    units = {},
    ---@type Logger
    logger = Logger("camera"),
    ---@type table[Timer]
    timers = {},
}

--- Регистрирует камеру для игрока
function Camera.Register(unit, player)
    Camera.logger:Info("Initialize Camera")
    local player_id = GetConvertedPlayerId(player)

    if Camera.units[player_id] == nil then
        Camera.units[player_id] = unit
    end

    if Camera.timers[player_id] == nil then
        Camera.timers[player_id] = Timer(Camera.update_time)
    end
    local timer = Camera.timers[player_id]
    SetCameraTargetControllerNoZForPlayer(player, Camera.units[player_id]:GetId(), 0, 0, false)
    timer:SetFunc(function() Camera._update(player_id) end)
    timer:EnablePeriodic()
    timer:Start()
    Camera.logger:Info("Start camera!")
end

--- Повернуть камеру влево
---@return nil
function Camera.TurnLeft(player_id)
    local facing = Camera.units[player_id]:GetFacing() + Camera.rotate_spd
    Camera.units[player_id]:SetFacing(facing)
end

--- Повернуть камеру вправо
---@return nil
function Camera.TurnRight(player_id)
    local facing = Camera.units[player_id]:GetFacing() - Camera.rotate_spd
    Camera.units[player_id]:SetFacing(facing)
end

---@private
function Camera._update(player_id)
    local unit = Camera.units[player_id]
    Camera.logger:Debug("Unit is", unit:GetName())
    local zoffset = 90. + unit:GetZ()
    local facing = unit:GetFacing()
    local loc = PolarProjectionBJ(unit:GetLoc(), -400., facing)
    Camera._detect_collision(player_id)
    -- правим камеру по высоте
    if GetLocationZ(loc) - unit:GetZ() > 200 then
        Camera._set_angle(player_id, Camera.angle)
    else
        Camera._set_angle(player_id, Camera.angle / 2)
    end
    Camera._set_offset(player_id, zoffset)
    Camera._set_facing(player_id, facing)
end

---@private
function Camera._detect_collision(player_id)
    local unit = Camera.units[player_id]
    -- коллизии вычисляются по следующей логике:
    -- расстояние между камера-юнит больше чем расстояние камера-блок
    -- и расстояние между камера-юнит больше чем расстояние блок-юнит
    local block_loc = GetDestructableLoc(Camera._get_near_block(player_id))
    local camera_loc = GetCameraEyePositionLoc()
    -- приводим значения к удобной форме
    local camera_unit_dist = DistanceBetweenPoints(camera_loc, unit:GetLoc()) // 10 * 10
    local block_unit_dist = DistanceBetweenPoints(block_loc, unit:GetLoc()) // 10 * 10
    local block_camera_dist = DistanceBetweenPoints(block_loc, camera_loc) // 10 * 10
    -- сначала проверяем расстояние между камера-юнит и блок-камера, чтобы дистанция камеры не скакала
    if camera_unit_dist > block_camera_dist then
        -- проверяем расстояние между блок-юнит и камера-юнит
        if block_unit_dist <= camera_unit_dist then
            Camera.logger:Debug("set block dist:", block_unit_dist)
            Camera._set_dist(player_id, block_unit_dist)
        end
    else
        Camera.logger:Debug("set camera dist:", Camera.dist)
        Camera._set_dist(player_id, Camera.dist)
    end
end

--- Вычисляет ближайший блок к игроку
---@private
function Camera._get_near_block(player_id)
    local unit = Camera.units[player_id]
    local block
    local min_dist = Camera.dist
    local unit_loc_x = unit:GetX()
    local unit_loc_y = unit:GetY()
    local border = 200
    local unit_loc = Rect(
            unit_loc_x - border,
            unit_loc_y - border,
            unit_loc_x + border,
            unit_loc_y + border
    )
    local near_func = function()
        local find = GetEnumDestructable()
        local dest_id = GetDestructableTypeId(find)
        if dest_id == VISION_BLOCKER or dest_id == TRACK_BOTH_BLOCKER then
            local dist = DistanceBetweenPoints(GetDestructableLoc(find), unit:GetLoc())
            if dist < min_dist then
                min_dist = dist
                block = find
            end
        end
    end
    EnumDestructablesInRectAll(unit_loc, near_func)
    return block
end

---@private
function Camera._set_dist(player_id, dist)
    SetCameraFieldForPlayer(PLAYERS[player_id], CAMERA_FIELD_TARGET_DISTANCE, dist, 0.25)
    Camera.logger:Debug("set camera fields: dist -", dist, "for player", player_id, PLAYERS[player_id])
end

---@private
function Camera._set_angle(player_id, angle)
    SetCameraFieldForPlayer(PLAYERS[player_id], CAMERA_FIELD_ANGLE_OF_ATTACK, angle, 0.25)
    Camera.logger:Debug("set camera fields: angle -", angle, "for player", player_id, PLAYERS[player_id])
end

---@private
function Camera._set_offset(player_id, offset)
    SetCameraFieldForPlayer(PLAYERS[player_id], CAMERA_FIELD_ZOFFSET, offset, 0.25)
    Camera.logger:Debug("set camera fields: zoffset -", offset, "for player", player_id, PLAYERS[player_id])
end

---@private
function Camera._set_facing(player_id, facing)
    SetCameraFieldForPlayer(PLAYERS[player_id], CAMERA_FIELD_ROTATION, facing, 0.25)
    Camera.logger:Debug("set camera fields: facing -", facing, "for player", player_id, PLAYERS[player_id])
end
