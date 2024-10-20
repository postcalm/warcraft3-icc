# Copyright meiso
#
from pathlib import Path
from build.settings import Settings

test_map_settings = Settings(
    map="Test.w3x",
    entry_point="tests/main.lua",
    custom_code=Path("test-custom-code.lua"),
)

lower_tier_settings = Settings(
    map="ICC.w3x",
    entry_point="src/entry_point/main.lua",
    custom_code=Path("custom-code.lua"),
)


MAPS = {
    "test": test_map_settings,
    "lower": lower_tier_settings,
}
