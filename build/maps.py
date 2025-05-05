# Copyright meiso
#
from pathlib import Path

from build.settings import Settings

test_map_settings = Settings(
    map="Test.w3x",
    entry_point="tests/main.lua",
    map_custom_code=Path("map.cc"),
    wct_custom_code=Path("wct.cc"),
)

lower_tier_settings = Settings(
    map="LowerTier.w3x",
    entry_point="src/entry_point/main.lua",
    map_custom_code=Path("map.cc"),
    wct_custom_code=Path("wct.cc"),
)


MAPS = {
    "test": test_map_settings,
    "lower": lower_tier_settings,
}
