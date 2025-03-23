---@author meiso

---@class Camera
Camera = {
    ---@type Unit
    unit = nil,
    ---@type Logger
    logger = Logger("camera"),
}

--- Регистрирует камеру для игрока
function Camera.Register()
    Camera.logger:Info("Initialize Camera")
    --TODO: брать персонажа выбранного игроком
    Camera.unit = Paladin.hero
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
    local dist = 650.
    local zoffset = 90. + Camera.unit:GetZ()
    local facing = Camera.unit:GetFacing()
    local loc = PolarProjectionBJ(Camera.unit:GetLoc(), -400., facing)
    Camera._set_dist(dist)
    if GetLocationZ(loc) - Camera.unit:GetZ() > 200 then
        Camera._set_angle(-24.)
    else
        Camera._set_angle(-12.)
    end
    Camera._set_offset(zoffset)
    Camera._set_facing(facing)
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
