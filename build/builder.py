import re
import subprocess
from io import IOBase
from dataclasses import dataclass
from build.settings import Settings, PROJECT_DIR, PATCHER


@dataclass
class Builder:
    settings: Settings

    def build(self):
        self.create_custom_code()
        self.replace_in_map()
        self.set_version()

    def create_custom_code(self):
        with open(PROJECT_DIR / self.settings.custom_code, "w+", encoding="utf8") as custom_code:
            custom_code.write(self.settings.tag + "\n")
            self._w2f(custom_code, self.settings.files)  # noqa
            self._w2f(custom_code, (self.settings.entry_point,))  # noqa
            custom_code.write(self.settings.tag)

    def replace_in_map(self):
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
        wct = PROJECT_DIR / self.settings.map / "war3map.wct"
        subprocess.run(f'start "" '
                       f'"{PATCHER}" '
                       f'"{wct}" '
                       f'"{self.settings.custom_code.absolute()}"')

    def set_version(self):
        version = (PROJECT_DIR / "version").read_text()
        wts = PROJECT_DIR / self.settings.map / "war3map.wts"
        rpl = re.sub(r"\d.\d.\d", version, wts.read_text(encoding="utf8"))
        print("rpl", rpl)
        wts.write_text(rpl, encoding="utf8")

    def _w2f(self, file: IOBase, src_files: tuple | list):
        for sf in src_files:
            sf = PROJECT_DIR / sf
            if sf.is_file():
                file.write(sf.read_text(encoding="utf8"))
            else:
                self._w2f(file, sf.glob("**/*.lua"))  # noqa
