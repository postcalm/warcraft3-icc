---@author meiso

Color = {
    ORANGE = "00ebb93c",
    RED = "00ff0000",
}

--- Задать цвет тексту
---@param text string Текст
---@param color Color Цвет
function set_color(text, color)
    return "|c" .. color .. text .. "|r"
end
