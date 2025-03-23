---@author meiso

-- Точка входа для инициализации всего
function TestEntryPoint()
    ENABLE_LOGGER_STDOUT = true
    --LOGGER_LEVEL = LogLevel.DEBUG
    -- Загрузка шаблонов фреймов
    loadTOCFile("templates.toc")
    --HeroSelector.Init()
    BuffSystem.LoadFrame()

    -- Механики
    BattleTextViewSystem.Init()
    EquipSystem.RegisterItems()

    --SaveSystem.InitNewHeroEvent()
    SaveSystem.gamecache = InitGameCache("savesystem")
    SaveSystem.map_number = 1
    SaveSystem.InitSaveEvent()
    SaveSystem.InitLoadEvent()

    -- Персонажи
    Priest.Init(Location(300., -490.))
    Paladin.Init(Location(-400., -490.))
    --DeathKnight.Init(Location(-400., -520.))

    --Movement.Init()

    -- Манекены
    --DummyForHealing(Location(300., 200.))
    DummyForDPS(Location(-400., 200.))
    --SpawnTrashDummies(5)
end
