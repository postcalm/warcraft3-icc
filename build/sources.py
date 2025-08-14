# Copyright meiso
#
"""
Файлы должны собираться в чёткой последовательности:
- файлы с общими константами и первичные файлы инициализации игры и юнитов
- кастомные типы данных
- файлы ядра (движка) игры
- интерфейсы над близардовскими функциями
- реализации различных игровых модулей
- реализации героев и юнитов

Прим.: "верхние" модули могут использовать модули из уровня "ниже", если инициализация "верхнего" модуля
происходит в точке входа. Например, core-модули объявляются раньше, но часть из них инициализируется
только в точке входа, а значит могут использовать модули объявленные ниже.

Пример:
```
ModuleA = {}

function ModuleA.Init()
    ModuleB.Method()
end

ModuleB = {}
function ModuleB.Method() return end

function EntryPoint()
    ModuleA.Init()
end

```

"""
COMMON_FILES = (
    "src/common/buffs.lua",
    "src/common/color.lua",
    "src/common/counter.lua",
    "src/common/items.lua",
    "src/common/logger.lua",
    "src/common/measures.lua",
    "src/common/objects.lua",
    "src/common/other.lua",
    "src/common/tools.lua",
    "src/common/players.lua",
    "src/common/spells.lua",
    "src/common/units.lua",
)
TYPES_FILES = (
    "src/types/unordered_list.lua",
    "src/types/vector.lua",
)
INIT_FILES = (
    "src/preinitialize.lua",
    "src/session.lua",
    "src/heroes/animations.lua",
    "src/heroes/paladin/init.lua",
    "src/heroes/priest/init.lua",
)
CORE_FILES = (
    "src/core/screen.lua",
    "src/core/grid.lua",
    "src/core/detector.lua",
    "src/core/keyboard.lua",
    "src/core/camera.lua",
    "src/core/movement.lua",
)
IFACES_FILES = (
    "src/blzwraps",
)
COMBAT_SYSTEM_FILES = (
    "src/modules/CombatSystem/agro.lua",
    "src/modules/CombatSystem/global.lua",
)
SAVE_SYSTEM_FILES = (
    "src/modules/SaveSystem/init.lua",
    "src/modules/SaveSystem/modules",
    "src/modules/SaveSystem/userData.lua",
    "src/modules/SaveSystem/heroData.lua",
    "src/modules/SaveSystem/saveSystem.lua",
    "src/modules/SaveSystem/heroes.lua",
    "src/modules/SaveSystem/newHero.lua",
    "src/modules/SaveSystem/saveHero.lua",
    "src/modules/SaveSystem/loadHero.lua",
)
EQUIPMENT_SYSTEM_FILES = (
    "src/modules/EquipmentSystem",
)
BUFF_SYSTEM_FILES = (
    "src/modules/BuffSystem/buff.lua",
    "src/modules/BuffSystem/buffSystem.lua",
    "src/modules/BuffSystem/helpers.lua",
)
BATTLE_TEXT_VIEW_SYSTEM_FILES = (
    "src/modules/battleTextViewSystem.lua",
)
WRAPPER_FILES = (
    "src/modules/wrappers.lua",
)
HERO_SELECTOR_FILES = (
    "src/modules/HeroSelector/framesDesc.lua",
    "src/modules/HeroSelector/heroSelector.lua",
)
SOURCES_FILES = (
    "src/abilities.lua",
    "src/modules/respawn.lua",
)
UNITS_FILES = (
    "src/units/dummy",
    "src/units/enemies",
    "src/units/lord_marrowgar",
    "src/units/lady_deathwhisper",
    "src/units/trashSpawn.lua",
)
HEROES_SPELLS_FILES = (
    "src/heroes/paladin/spells",
    "src/heroes/priest/spells",
)

ALL_SOURCE_FILES = (
    *COMMON_FILES,
    *TYPES_FILES,
    *INIT_FILES,
    *CORE_FILES,
    *COMBAT_SYSTEM_FILES,
    *IFACES_FILES,
    *SAVE_SYSTEM_FILES,
    *EQUIPMENT_SYSTEM_FILES,
    *BUFF_SYSTEM_FILES,
    *BATTLE_TEXT_VIEW_SYSTEM_FILES,
    *WRAPPER_FILES,
    *HERO_SELECTOR_FILES,
    *SOURCES_FILES,
    *UNITS_FILES,
    *HEROES_SPELLS_FILES,
)
