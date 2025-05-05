# Copyright meiso
#
import re
import subprocess
from io import IOBase
from dataclasses import dataclass
from pathlib import Path

from build.settings import Settings, PROJECT_DIR, PATCHER


@dataclass
class Builder:
    """
    Сборщик исходного кода
    """

    settings: Settings

    def build(self):
        """
        Собрать исходный код карты
        """
        self.create_custom_code(self.settings.map_custom_code)
        self.create_custom_code(self.settings.wct_custom_code)
        self.replace_in_map()
        self.patch_wct()
        self.patch_imp()
        self.set_version()

    def create_custom_code(self, filename: str | Path):
        """
        Создать кастомный код из исходников.

        Создаёт два разных custom-code файла:
        - один для перезаписи war3map через python
        - второй для перезаписи wct через patcher
        """
        print("Creating custom code...")
        wfun = {
            "map": self._map_cc,
            "wct": self._wct_cc,
        }.get(Path(filename).stem)
        with open(PROJECT_DIR / filename, "w+", encoding="utf8") as custom_code:
            custom_code.write(self.settings.tag + "\n")
            wfun(custom_code, self.settings.files)  # noqa
            wfun(custom_code, (self.settings.entry_point,))  # noqa
            custom_code.write(self.settings.tag)
        print("Success")

    def replace_in_map(self):
        """
        Заменить исходный код в карте
        """
        path = PROJECT_DIR / self.settings.map / "war3map.lua"
        print(f"Replacing custom code into {path}...")
        content = path.read_text(encoding="utf8")
        with open(path.absolute(), "w+", encoding="utf8") as war3map:
            print(f"Use custom code {self.settings.map_custom_code.absolute()}")
            # повторно заменяем кастомный код
            content = re.sub(
                rf"{self.settings.tag}(.*?){self.settings.tag}",
                self.settings.map_custom_code.read_text(encoding="utf8"),
                content,
                flags=re.DOTALL,
            )
            war3map.write(content + r"")
        print("Success")

    def patch_wct(self):
        """
        Патчит wct файл
        """
        wct = PROJECT_DIR / self.settings.map / "war3map.wct"
        custom_code = PROJECT_DIR / self.settings.wct_custom_code
        print(f"Replacing custom code into {wct}...")
        print(f"Use custom code {self.settings.wct_custom_code.absolute()}")
        cmd = (f'start "" '
               f'"{PATCHER}" '
               f'"{wct}" '
               f'"{custom_code}"')
        subprocess.run(cmd, shell=True)
        print("Success")

    def patch_imp(self):
        imp = PROJECT_DIR / self.settings.map / "war3map.imp"
        print(f"Patching {imp}...")
        content = imp.read_bytes()
        content = content.replace(b"/", b"\\")
        imp.write_bytes(content)
        print("Success")

    def set_version(self):
        """
        Задать версию карты
        """
        version = (PROJECT_DIR / "version").read_text().strip()
        wts = PROJECT_DIR / self.settings.map / "war3map.wts"
        rpl = re.sub(r"\d.\d.\d", version, wts.read_text(encoding="utf8"))
        wts.write_text(rpl, encoding="utf8")

    def _map_cc(self, file: IOBase, src_files: tuple | list):
        for sf in src_files:
            sf = PROJECT_DIR / sf
            if sf.is_file():
                text = f'{sf.read_text(encoding="utf8")}\n'.replace("\\", "\\\\").replace("%%", "%")
                file.write(text)
            else:
                self._map_cc(file, sf.glob("**/*.lua"))  # noqa

    def _wct_cc(self, file: IOBase, src_files: tuple | list):
        for sf in src_files:
            sf = PROJECT_DIR / sf
            if sf.is_file():
                text = f'{sf.read_text(encoding="utf8")}\n'.replace("%%", "%")
                file.write(text)
            else:
                self._wct_cc(file, sf.glob("**/*.lua"))  # noqa
