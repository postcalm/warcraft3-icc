from pathlib import Path
from dataclasses import dataclass
import copy

PROJECT_DIR = Path.cwd()
PATCHER = PROJECT_DIR / "build" / "custom-code-replacer.exe"


@dataclass
class Settings:
    game_dirs: list
    map: str
    custom_code: str
    files: tuple
    entry_point: str
    tag: str

    def copy(self):
        return copy.copy(self)

    def __repr__(self):
        return f"<{self.__class__.__name__}>({self.__dict__})"
