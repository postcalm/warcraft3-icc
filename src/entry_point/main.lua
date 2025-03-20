
-- Точка входа для инициализации всего
function EntryPoint()
    ENABLE_LOGGER_STDOUT = true
    -- Загрузка шаблонов фреймов
    loadTOCFile("templates.toc")

    -- Механики
    BuffSystem.LoadFrame()
    BattleTextViewSystem.Init()
    EquipSystem.RegisterItems()

    SaveSystem.gamecache = InitGameCache("savesystem")
    SaveSystem.map_number = 1
    SaveSystem.InitSaveEvent()
    SaveSystem.InitLoadEvent()

    -- Боссы
    --LordMarrowgar.Init()
    --LadyDeathwhisper.Init()

    -- Персонажи
    --Priest.Init()
    Paladin.Init(Location(930., -11000.))

    Movement.Init()
    FogEnableOff()
    FogMaskEnableOff()
end
