---@author meiso

---@class Camera
Camera = {
    dist = 650.,
    ---@type Unit
    unit = nil,
    ---@type Logger
    logger = Logger("camera"),
}

--- Регистрирует камеру для игрока
function Camera.Register(unit)
    Camera.logger:Info("Initialize Camera")
    Camera.unit = unit
    SetCameraTargetUnit(Camera.unit:GetId())

    local camera = Timer(0.04)
    camera:SetFunc(Camera._update)
    camera:EnablePeriodic()
    camera:Start()
    Camera.logger:Info("Start camera!")
end

--- Повернуть камеру влево
---@return nil
function Camera.TurnLeft()
    local facing = Camera.unit:GetFacing() + 10
    Camera.unit:SetFacing(facing)
end

--- Повернуть камеру вправо
---@return nil
function Camera.TurnRight()
    local facing = Camera.unit:GetFacing() - 10
    Camera.unit:SetFacing(facing)
end

---@private
function Camera._update()
    Camera.logger:Debug("Unit is", Camera.unit:GetName())
    local zoffset = 90. + Camera.unit:GetZ()
    local facing = Camera.unit:GetFacing()
    local loc = PolarProjectionBJ(Camera.unit:GetLoc(), -400., facing)
    Camera._detect_collision()
    if GetLocationZ(loc) - Camera.unit:GetZ() > 200 then
        Camera._set_angle(-24.)
    else
        Camera._set_angle(-12.)
    end
    Camera._set_offset(zoffset)
    Camera._set_facing(facing)
end

---@private
function Camera._detect_collision()
    -- коллизии вычисляются по следующей логике:
    -- расстояние между камера-юнит больше чем расстояние камера-блок
    -- и расстояние между камера-юнит больше чем расстояние блок-юнит
    local block_loc = GetDestructableLoc(Camera._get_near_block())
    local camera_loc = GetCameraEyePositionLoc()
    -- приводим значения к удобной форме
    local camera_unit_dist = DistanceBetweenPoints(camera_loc, Camera.unit:GetLoc()) // 10 * 10
    local block_unit_dist = DistanceBetweenPoints(block_loc, Camera.unit:GetLoc()) // 10 * 10
    local block_camera_dist = DistanceBetweenPoints(block_loc, camera_loc) // 10 * 10
    -- сначала проверяем расстояние между камера-юнит и блок-камера, чтобы дистанция камеры не скакала
    if camera_unit_dist > block_camera_dist then
        -- проверяем расстояние между блок-юнит и камера-юнит
        if block_unit_dist <= camera_unit_dist then
            Camera.logger:Debug("set block dist:", block_unit_dist)
            Camera._set_dist(block_unit_dist)
        end
    else
        Camera.logger:Debug("set camera dist:", Camera.dist)
        Camera._set_dist(Camera.dist)
    end
end

--- Вычисляет ближайший блок к игроку
---@private
function Camera._get_near_block()
    local block
    local min_dist = Camera.dist
    local unit_loc_x = Camera.unit:GetX()
    local unit_loc_y = Camera.unit:GetY()
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
            local dist = DistanceBetweenPoints(GetDestructableLoc(find), Camera.unit:GetLoc())
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
function Camera._set_dist(dist)
    SetCameraDistance(dist)
    Camera.logger:Debug("set camera fields: dist -", dist)
end

---@private
function Camera._set_angle(angle)
    SetCameraAngle(angle)
    Camera.logger:Debug("set camera fields: angle -", angle)
end

---@private
function Camera._set_offset(offset)
    SetCameraZOffset(offset)
    Camera.logger:Debug("set camera fields: zoffset -", offset)
end

---@private
function Camera._set_facing(facing)
    SetCameraRotation(facing)
    Camera.logger:Debug("set camera fields: facing -", facing)
end
