---@author Vlod | WWW.XGM.RU
---@author meiso | WWW.XGM.RU

--- Система сохранений
SaveSystem = {
    directory = "test",
    hash1 = 0,
    hash2 = 0,
    scope = {
        --- Область, за которой следует номер карты
        map        = 2,
        --- Область, за которой следуют данные о ресурсах игрока
        resources  = 3,
        --- Область, за которой следуют данные о юните (положение, хп, мана)
        hero_data  = 4,
        --- Область, за которой следуют данные о количестве skill points
        hero_skill = 5,
        --- Область, за которой следуют данные о характеристиках
        state      = 6,
        --- Область, за которой следуют данные о способностях героя
        abilities  = 7,
        --- Область, за которой следуют данные об имеющихся предметах
        items      = 8,
    },
    -- Числа, расшифровать смысл которых, так и не получилось
    magic_number = {
        one   = 18259200,
        two   = 44711,
        three = 259183,
        four  = 129593,
        five  = 259200,
        six   = 54773,
        seven = 7141,
        eight = 421,
        nine  = 259199,
    },
}

CLASSES = {paladin = 1,
           priest  = 2,
}