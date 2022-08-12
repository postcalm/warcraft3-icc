
-- Точка входа для инициализации всего
function TestEntryPoint()
    -- Загрузка шаблонов фреймов
    loadTOCFile("templates.toc")
    HeroSelector.Init()

    -- Механики
    BattleSystem.Init()

    -- Персонажи
    Priest.Init(Location(300., -490.))
    Paladin.Init(Location(-400., -490.))

    -- Манекены
    DummyForHealing(Location(300., 200.))
    DummyForDPS(Location(-400., 200))

end
