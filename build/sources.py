# Copyright meiso
# 
COMMON_FILES = (
    "common",
)
INIT_FILES = (
    "src/paladin/init.lua",
    "src/priest/init.lua",
)
CLASSES_FILES = (
    "classes",
)
SAVE_SYSTEM_FILES = (
    "libs/SaveSystem/init.lua",
    "libs/SaveSystem/modules",
    "libs/SaveSystem/userData.lua",
    "libs/SaveSystem/heroData.lua",
    "libs/SaveSystem/saveSystem.lua",
    "libs/SaveSystem/heroes.lua",
    "libs/SaveSystem/newHero.lua",
    "libs/SaveSystem/saveHero.lua",
    "libs/SaveSystem/loadHero.lua",
)
EQUIPMENT_SYSTEM_FILES = (
    "libs/EquipmentSystem",
)
BUFF_SYSTEM_FILES = (
    "libs/BuffSystem",
)
BATTLE_SYSTEM_FILES = (
    "libs/battleSystem.lua",
)
WRAPPER_FILES = (
    "libs/wrappers.lua",
)
HERO_SELECTOR_FILES = (
    "libs/HeroSelector/frames_desc.lua",
    "libs/HeroSelector/heroSelector.lua",
)
SOURCE_FILES = (
    "src/abilities.lua",
    "src/dummy",
    "src/enemies",
    "src/lord_marrowgar",
    "src/lady_deathwhisper",
    "src/paladin/spells",
    "src/priest/spells",
)

ALL_SOURCE_FILES = (
    *COMMON_FILES,
    *INIT_FILES,
    *CLASSES_FILES,
    *SAVE_SYSTEM_FILES,
    *EQUIPMENT_SYSTEM_FILES,
    *BUFF_SYSTEM_FILES,
    *BATTLE_SYSTEM_FILES,
    *WRAPPER_FILES,
    *HERO_SELECTOR_FILES,
    *SOURCE_FILES,
)
