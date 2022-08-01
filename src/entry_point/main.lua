
-- Точка входа для инициализации всего
function EntryPoint()
    -- Механики
    BattleSystem.Init()

    -- Боссы
    LordMarrowgar.Init()
    LadyDeathwhisper.Init()

    -- Персонажи
    Priest.Init()
    Paladin.Init()

    -- Манекены
    --DummyForHealing()
end
