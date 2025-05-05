
-- Точка входа для инициализации всего
function EntryPoint()
    ENABLE_LOGGER_STDOUT = true
    -- Загрузка шаблонов фреймов
    loadTOCFile("templates.toc")
    HeroSelector.Init()

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
	
    FogEnableOff()
    FogMaskEnableOff()
end
