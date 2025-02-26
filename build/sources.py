# Copyright meiso
# 
COMMON_FILES = (
    "src/common",
)
INIT_FILES = (
    "src/preinitialize.lua",
    "src/characters/paladin/init.lua",
    "src/characters/priest/init.lua",
)
CLASSES_FILES = (
    "src/classes",
)
AGRO_SYSTEM_FILES = (
    "src/libs/AgroSystem",
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
BATTLE_SYSTEM_FILES = (
    "src/libs/battleSystem.lua",
)
WRAPPER_FILES = (
    "src/libs/wrappers.lua",
)
HERO_SELECTOR_FILES = (
    "src/libs/HeroSelector/frames_desc.lua",
    "src/libs/HeroSelector/heroSelector.lua",
)
SOURCES_FILES = (
    "src/abilities.lua",
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
    *AGRO_SYSTEM_FILES,
    *CLASSES_FILES,
    *SAVE_SYSTEM_FILES,
    *EQUIPMENT_SYSTEM_FILES,
    *BUFF_SYSTEM_FILES,
    *BATTLE_SYSTEM_FILES,
    *WRAPPER_FILES,
    *HERO_SELECTOR_FILES,
    *SOURCES_FILES,
    *UNITS_FILES,
    *CHARACTER_SPELLS_FILES,
)
