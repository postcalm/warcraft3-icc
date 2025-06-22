# Copyright meiso
#
from pathlib import Path

from build.settings import Settings

CUSTOM_CODE_EXT = ".cst"
MAP_CUSTOM_CODE = f"map{CUSTOM_CODE_EXT}"
WCT_CUSTOM_CODE = f"wct{CUSTOM_CODE_EXT}"

test_map_settings = Settings(
    map="Test.w3x",
    entry_point="tests/main.lua",
    map_custom_code=Path(MAP_CUSTOM_CODE),
    wct_custom_code=Path(WCT_CUSTOM_CODE),
)

lower_tier_settings = Settings(
    map="LowerTier.w3x",
    entry_point="src/entry_point/main.lua",
    map_custom_code=Path(MAP_CUSTOM_CODE),
    wct_custom_code=Path(WCT_CUSTOM_CODE),
)


MAPS = {
    "test": test_map_settings,
    "lower": lower_tier_settings,
}
