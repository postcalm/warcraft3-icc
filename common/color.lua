-- Copyright (c) meiso

function _dec2hex(red, green, blue)
    red = string.format("%%x", red)
    green = string.format("%%x", green)
    blue = string.format("%%x", blue)
    return "00" .. red .. green .. blue
end

-- Формат: transparency-red-green-blue
Color = {
    dec2hex = _dec2hex,
    ORANGE = _dec2hex(235, 185, 60),
    RED = _dec2hex(255, 0, 0),
}

--- Задать цвет тексту
---@param color Color Цвет
function set_color(text, color)
    return "|c" .. color .. text .. "|r"
end

