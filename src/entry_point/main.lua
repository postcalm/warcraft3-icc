
-- Точка входа для инициализации всего
function EntryPoint()
    -- Загрузка шаблонов фреймов
    loadTOCFile("templates.toc")

    -- Механики
    BattleSystem.Init()
    EquipSystem.RegisterItems()

    -- Боссы
    LordMarrowgar.Init()
    LadyDeathwhisper.Init()

    -- Персонажи
    Priest.Init()
    Paladin.Init()

    -- Манекены
    --DummyForHealing()
end
