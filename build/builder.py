import re
import os
from io import IOBase
from dataclasses import dataclass
from build.settings import Settings, PROJECT_DIR, PATCHER


@dataclass
class Builder:
    settings: Settings

    def build(self):
        """Собрать исходный код карты"""
        self.create_custom_code()
        self.replace_in_map()
        self.set_version()

    def create_custom_code(self):
        """Создать кастомный код из исходников"""
        with open(PROJECT_DIR / self.settings.custom_code, "w+", encoding="utf8") as custom_code:
            custom_code.write(self.settings.tag + "\n")
            self._w2f(custom_code, self.settings.files)  # noqa
            self._w2f(custom_code, (self.settings.entry_point,))  # noqa
            custom_code.write(self.settings.tag)

    def replace_in_map(self):
        """Заменить исходный код в карте"""
        path = PROJECT_DIR / self.settings.map / "war3map.lua"
        content = path.read_text(encoding="utf8")
        with open(path.absolute(), "w+", encoding="utf8") as war3map:
            # повторно заменяем кастомный код
            content = re.sub(
                f"{self.settings.tag}.*{self.settings.tag}",
                self.settings.custom_code.read_text(encoding="utf8"),
                content
            )
            war3map.write(content)

    def path_wct(self):
        """Пропатчить wct карты"""
        wct = PROJECT_DIR / self.settings.map / "war3map.wct"
        os.system(f'start "" '
                  f'"{PATCHER}" '
                  f'"{wct}" '
                  f'"{self.settings.custom_code.absolute()}"')

    def set_version(self):
        """Задать версию карты"""
        version = (PROJECT_DIR / "version").read_text()
        wts = PROJECT_DIR / self.settings.map / "war3map.wts"
        rpl = re.sub(r"\d.\d.\d", version, wts.read_text(encoding="utf8"))
        wts.write_text(rpl, encoding="utf8")

    def _w2f(self, file: IOBase, src_files: tuple | list):
        """Рекурсивно записывает файлы"""
        for sf in src_files:
            sf = PROJECT_DIR / sf
            if sf.is_file():
                file.write(sf.read_text(encoding="utf8"))
            else:
                self._w2f(file, sf.glob("**/*.lua"))  # noqa
