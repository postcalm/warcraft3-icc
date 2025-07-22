---@author meiso

---@class HeroAnimations Структура, описывающая анимации персонажа.
--- Анимации необходимо смотреть в самой модели через MdlVis
---@param attack number
---@param spell_cast number
---@param move_forward number
---@param move_backward number
---@param idle number
HeroAnimations = {}
HeroAnimations.__index = HeroAnimations

setmetatable(HeroAnimations, {
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
    end,
})

---@private
function HeroAnimations:_init(args)
    self.attack = args.attack
    self.spell_cast = args.spell_cast
    self.move_forward = args.move_forward
    self.move_backward = args.move_backward
    self.idle = args.idle
end

HERO_ANIMATIONS = {
    paladin = HeroAnimations {
        attack = 37,
        move_forward = 5,
        move_backward = 13,
        idle = 11
    },
    priest = HeroAnimations {
        attack = 26,
        spell_cast = 71,
        move_forward = 9,
        move_backward = 6,
        idle = 2
    }
}
