import os
from pathlib import Path
from io import IOBase
from dataclasses import dataclass
from build.settings import Settings, PROJECT_DIR


@dataclass
class Builder:

    settings: Settings

    def create_custom_code(self):
        with open(PROJECT_DIR / self.settings.custom_code, "w+", encoding="utf8") as custom_code:
            custom_code.write(self.settings.tag + "\n")
            self._w2f(custom_code, self.settings.files)  # noqa
            custom_code.write(self.settings.tag)

    def replace_in_map(self):
        path = PROJECT_DIR / self.settings.map / "war3map.lua"

    def _w2f(self, file: IOBase, src_files: tuple | list):
        for sf in src_files:
            sf = PROJECT_DIR / sf
            if sf.is_file():
                file.write(sf.read_text(encoding='utf8'))
            else:
                self._w2f(file, sf.glob("**/*.lua"))
