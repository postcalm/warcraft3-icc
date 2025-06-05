
-- Точка входа для инициализации всего
function EntryPoint()
    ENABLE_LOGGER_STDOUT = true
    --LOGGER_LEVEL = LogLevel.DEBUG
    Session.cache = GameCache("session")
    -- Загрузка шаблонов фреймов
    loadTOCFile("templates.toc")
    HeroSelector.Init()

    -- Механики
    --BuffSystem.LoadFrame()
    --BattleTextViewSystem.Init()
    --EquipSystem.RegisterItems()

    --SaveSystem.gamecache = InitGameCache("savesystem")
    --SaveSystem.map_number = 1
    --SaveSystem.InitNewHeroEvent()
    --SaveSystem.InitSaveEvent()
    --SaveSystem.InitLoadEvent()

    -- Боссы
    --LordMarrowgar.Init()
    --LadyDeathwhisper.Init()
	
    FogEnableOff()
    FogMaskEnableOff()
end
