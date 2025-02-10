# Copyright meiso
#
import re
from dataclasses import dataclass
from typing import Any


@dataclass
class Version:
    FormatVersion: int

    def __post_init__(self):
        self.FormatVersion = int(self.FormatVersion)


@dataclass
class Bitmap:
    Image: str
    WrapHeight: bool = False
    WrapWidth: bool = False


@dataclass
class Textures:
    bitmaps: list[Bitmap]


class _MdlParser:

    def __init__(self, model):
        self.model = model
        self.sections = {}
        self._parse()

    def get(self, section: str, default: Any = None) -> dict:
        return self.sections.get(section, default)

    def _parse(self):
        with open(self.model) as handle:
            section = []
            current_set = ""
            opening, closing = 0, 0
            for line in handle.readlines():
                if line.startswith("//"):
                    continue
                if line.startswith("Version"):
                    current_set = "Version"
                    section.append(line.strip())
                    opening = 1
                    continue
                if line.startswith("Textures"):
                    current_set = "Textures"
                    section.append(line.strip())
                    opening = 1
                    continue
                if "{" in line:
                    opening += 1
                if "}" in line:
                    closing += 1
                section.append(line.strip())
                if opening == closing:
                    self.sections.update(self._parse_section(current_set, section))
                    current_set = ""
                    section.clear()
                    opening, closing = 0, 0

    def _parse_section(self, name: str, section: list) -> dict:
        func = {
            "Version": self._parse_version,
            "Textures": self._parse_textures,
        }.get(name, lambda *_: {})
        return func(name, section)  # noqa

    def _parse_version(self, name: str, section: list) -> dict:
        data: dict[str, dict] = {name: {}}
        for elem in section[1:-1]:
            var = re.sub("[{},]", "", elem).split(" ")
            data[name].update(self._todict(var))
        return data

    def _parse_textures(self, name: str, section: list) -> dict:
        data: dict[str, list] = {name: []}
        bitmap = {}
        for elem in section[1:-1]:
            if "Bitmap" in elem:
                continue
            if "}" in elem:
                data[name].append(bitmap)
                bitmap = {}
                continue
            var = re.sub("[{},\"]", "", elem).split(" ")
            if len(var) < 2:
                var.append("True")
            bitmap.update(self._todict(var))
        return data

    def _todict(self, var: list) -> dict:
        it = iter(var)
        return dict(zip(it, it))


class Mdl:

    def __init__(self, model):
        self.parser = _MdlParser(model)

    @property
    def version(self) -> Version:
        print(self.parser.get("Version", {}))
        return Version(**self.parser.get("Version", {}))

    @property
    def textures(self) -> Textures:
        print(self.parser.get("Textures", {}))
        return Textures(*self.parser.get("Textures", {}))
