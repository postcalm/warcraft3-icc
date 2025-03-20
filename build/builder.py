# Copyright meiso
#
import re
from io import IOBase
from dataclasses import dataclass

from build.settings import Settings, PROJECT_DIR


@dataclass
class Builder:
    """Сборщик исходного кода"""

    settings: Settings

    def build(self):
        """Собрать исходный код карты"""
        self.create_custom_code()
        self.replace_in_map()
        self.set_version()

    def create_custom_code(self):
        """Создать кастомный код из исходников"""
        print("Creating custom code...")
        with open(PROJECT_DIR / self.settings.custom_code, "w+", encoding="utf8") as custom_code:
            custom_code.write(self.settings.tag + "\n")
            self._w2f(custom_code, self.settings.files)  # noqa
            self._w2f(custom_code, (self.settings.entry_point,))  # noqa
            custom_code.write(self.settings.tag)
        print("Success")

    def replace_in_map(self):
        """Заменить исходный код в карте"""
        path = PROJECT_DIR / self.settings.map / "war3map.lua"
        print(f"Replacing custom code into {path}...")
        content = path.read_text(encoding="utf8")
        with open(path.absolute(), "w+", encoding="utf8") as war3map:
            print(f"Use custom code {self.settings.custom_code.absolute()}")
            # повторно заменяем кастомный код
            content = re.sub(
                rf"{self.settings.tag}(.*?){self.settings.tag}",
                self.settings.custom_code.read_text(encoding="utf8"),
                content,
                flags=re.DOTALL,
            )
            war3map.write(content)
        print("Success")

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
                # при чтении из кастомного кода, python автоматически преобразует все служебные символы
                # потому, косую черту запишем через двойную.
                # % управляющий символ в lua - преобразуем сами
                # в custom-code при этом всегда будут ошибки!
                text = f'{sf.read_text(encoding="utf8")}\n'.replace("\\", "\\\\").replace("%%", "%")
                file.write(text)
            else:
                self._w2f(file, sf.glob("**/*.lua"))  # noqa
