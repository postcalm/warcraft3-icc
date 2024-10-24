# Copyright meiso
#
import os
from pathlib import Path
from dataclasses import dataclass
from build.settings import GAME_DIRS, PROJECT_DIR


@dataclass
class BaseRunner:

    map: str
    runner: str

    @property
    def game_dir(self) -> Path:
        return list(filter(lambda d: d.is_dir(), GAME_DIRS))[0]

    def run(self) -> None:
        cmd = f'start "" ' \
              f'"{self.game_dir / self.runner}" -loadfile ' \
              f'"{PROJECT_DIR / self.map}"'
        os.system(cmd)


@dataclass
class WorldEditor(BaseRunner):
    """Редактор"""
    runner: str = "World Editor.exe"


@dataclass
class Warcraft(BaseRunner):
    """Игра"""
    runner: str = "Warcraft III.exe"
