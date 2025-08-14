---@author meiso
--- Thanks Nelloy xgm.guru

--- Модуль, определяющий размер экрана
Screen = {
    pos = Vector(0, 0),
    size = Vector(0.8, 0.6),
    width = 0,
    height = 0,
}

--- Регистрирует модуль
function Screen.Register()
    local timer = Timer(1, Screen._update, true)
    timer:Start()
end

---@private
function Screen._update()
    local current_width = BlzGetLocalClientWidth()
    local current_height = BlzGetLocalClientHeight()

    if current_width == Screen.width and current_height == Screen.height then
        return
    end

    Screen.width = current_width
    Screen.height = current_height

    local default_zone_width = current_height * 0.8 / 0.6
    Screen.size.x = 0.8 * current_width / default_zone_width
    Screen.pos.x = (Screen.size.x - 0.8) / 2 * -1
end
