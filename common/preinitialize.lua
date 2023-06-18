---@author meiso

Paladin = {
    hero = nil,
    consecration_effect = nil,
}

Priest = {
    hero = nil,
    spirit_of_redemption = false,
}

DeathKnight = {
    hero = nil,
    blood_runes = 2,
    frost_runes = 2,
    unholy_runes = 2,
    death_runes = 0,
}

LordMarrowgar = {
    unit = nil,
    coldflame = nil,
    coldflame_effect = false,
    bonespike_effect = false,
    whirlwind_effect = false,
}

LadyDeathwhisper = {
    unit = nil,
    mana_shield = nil,
    mana_is_over = false,
    dominate_mind_effect = false,
    death_and_decay_effect = false,
    phase = 1,
}

CultAdherent = {
    unit = nil,
    summoned = false,
    morphed = false,
}

CultFanatic = {
    unit = nil,
    summoned = false,
    morphed = false,
}

--- Кэш для системы экипировки
EQUIP_CACHE = nil

--- Система выбора героев
HeroSelector = {
    --- Основной фрейм
    table = nil,
    --- Фрейм паладина
    paladin = nil,
    --- Фрейм жреца
    priest = nil,
    --- Фрейм рыцаря смерти
    dk = nil,
    --- Фрейм друида
    druid = nil,
    --- Фрейм шамана
    shaman = nil,
    --- Фрейм воина
    warrior = nil,
    --- Фрейм мага
    mage = nil,
    --- Фрейм разбойника
    rogue = nil,
    --- Фрейм чернокнижника
    warlock = nil,
    --- Фрейм охотника
    hunter = nil,
    --- Выбранный герой
    hero = nil,
    --- Список выбранных героев
    selected_heroes = {},
}
