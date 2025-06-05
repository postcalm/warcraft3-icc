# Copyright meiso
#
"""
Файлы должны собираться в чёткой последовательности:
- файлы с общими константами и первичные файлы инициализации игры и юнитов
- файлы ядра (движка) игры
- интерфейсы над близардовскими функциями
- реализации различных игровых систем
- реализации героев и юнитов
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
INIT_FILES = (
    "src/preinitialize.lua",
    "src/characters/paladin/init.lua",
    "src/characters/priest/init.lua",
)
CORE_FILES = (
    "src/core/pool.lua",
    "src/core/keyboard.lua",
    "src/core/camera.lua",
    "src/core/movement.lua",
)
IFACES_FILES = (
    "src/blzwraps",
)
AGRO_SYSTEM_FILES = (
    "src/libs/CombatSystem",
)
SAVE_SYSTEM_FILES = (
    "src/libs/SaveSystem/init.lua",
    "src/libs/SaveSystem/modules",
    "src/libs/SaveSystem/userData.lua",
    "src/libs/SaveSystem/heroData.lua",
    "src/libs/SaveSystem/saveSystem.lua",
    "src/libs/SaveSystem/heroes.lua",
    "src/libs/SaveSystem/newHero.lua",
    "src/libs/SaveSystem/saveHero.lua",
    "src/libs/SaveSystem/loadHero.lua",
)
EQUIPMENT_SYSTEM_FILES = (
    "src/libs/EquipmentSystem",
)
BUFF_SYSTEM_FILES = (
    "src/libs/BuffSystem",
)
BATTLE_TEXT_VIEW_SYSTEM_FILES = (
    "src/libs/battleTextViewSystem.lua",
)
WRAPPER_FILES = (
    "src/libs/wrappers.lua",
)
HERO_SELECTOR_FILES = (
    "src/libs/HeroSelector/framesDesc.lua",
    "src/libs/HeroSelector/heroSelector.lua",
)
SOURCES_FILES = (
    "src/abilities.lua",
    "src/session.lua",
)
UNITS_FILES = (
    "src/units/dummy",
    "src/units/enemies",
    "src/units/lord_marrowgar",
    "src/units/lady_deathwhisper",
)
CHARACTER_SPELLS_FILES = (
    "src/characters/paladin/spells",
    "src/characters/priest/spells",
)

ALL_SOURCE_FILES = (
    *COMMON_FILES,
    *INIT_FILES,
    *CORE_FILES,
    *AGRO_SYSTEM_FILES,
    *IFACES_FILES,
    *SAVE_SYSTEM_FILES,
    *EQUIPMENT_SYSTEM_FILES,
    *BUFF_SYSTEM_FILES,
    *BATTLE_TEXT_VIEW_SYSTEM_FILES,
    *WRAPPER_FILES,
    *HERO_SELECTOR_FILES,
    *SOURCES_FILES,
    *UNITS_FILES,
    *CHARACTER_SPELLS_FILES,
)
