from pathlib import Path
from dataclasses import dataclass
import copy
from build.sources import ALL_SOURCE_FILES

PROJECT_DIR: Path = Path.cwd()
PATCHER: Path = PROJECT_DIR / "build" / "custom-code-replacer.exe"
GAME_DIRS: tuple[Path, ...] = (
    Path("E:/Warcraft III/x86_64"),
    Path("E:/Games/Warcraft III/x86_64"),
)


@dataclass
class Settings:
    map: str = "NOT_SET"
    custom_code: Path = "NOT_SET"
    files: tuple = ALL_SOURCE_FILES
    entry_point: str = "NOT_SET"
    tag: str = "--CUSTOM_CODE"

    def copy(self):
        return copy.copy(self)

    def __repr__(self):
        return f"<{self.__class__.__name__}>({self.__dict__})"
