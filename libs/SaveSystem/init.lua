-- Copyright (c) Vlod www.xgm.ru
-- Copyright (c) meiso

--- Система сохранений
SaveSystem = {
    --- Юнит, которого требуется сохранить
    unit = nil,
    --- Идентификатор класса
    classid = 0,
    --- Список способностей юнита
    abilities = {},
    --- Книга заклинаний юнита
    spellbook = nil,
    --- Место воскрешения
    respawn = nil,
    --- Директория, где будут лежать сохранения
    directory = "test",
    --- Идентификатор автора
    author = 1546,
    --- Пользовательские данные
    user_data = {},
    --- Данные игрока и его юнита
    data = {},
    --- Флаг процесса сохранения
    process = false,
    hash1 = 0,
    hash2 = 0,
    -- Автор данного творения запихал все данные в один массив
    -- и дабы как-то различать что находится внутри него,
    -- добавил специальные числа, разграничиваниющие области эти данных
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

--- Условные идентификаторы классов для системы сохранений
CLASSES = {
    paladin = 1,
    priest  = 2,
}

--- Фактические идентификаторы классов
HEROES = {
    paladin = PALADIN,
    priest = PRIEST,
}
