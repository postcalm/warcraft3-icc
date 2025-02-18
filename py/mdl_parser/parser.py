# Copyright meiso
#
import re
from typing import Any


class _MdlParser:

    def __init__(self, model: str):
        self.model = model
        self.sections = {}
        if model:
            self._parse()

    def get(self, section: str, default: Any = None) -> dict | list:
        return self.sections.get(section, default)

    def _parse(self):
        with open(self.model) as handle:
            section = []
            current_set = ""
            opening, closing = 0, 0
            geosets: dict[str, list] = {"Geosets": []}
            for line in handle.readlines():
                if line.startswith("//"):
                    continue
                if line.startswith("Version"):
                    current_set = "Version"
                    section.append(line.strip())
                    opening = 1
                    continue
                if line.startswith("Model"):
                    current_set = "Model"
                    section.append(line.strip())
                    opening = 1
                    continue
                if line.startswith("Textures"):
                    current_set = "Textures"
                    section.append(line.strip())
                    opening = 1
                    continue
                if line.startswith("Materials"):
                    current_set = "Materials"
                    section.append(line.strip())
                    opening = 1
                    continue
                if line.startswith("Geoset"):
                    current_set = "Geoset"
                    section.append(line.strip())
                    opening = 1
                    continue
                if line.startswith("PivotPoints"):
                    current_set = "PivotPoints"
                    section.append(line.strip())
                    opening = 1
                    continue
                if "{" in line:
                    opening += 1
                if "}" in line:
                    closing += 1
                section.append(line.strip())
                if opening == closing:
                    if current_set == "Geoset":
                        geosets["Geosets"].append(self._parse_section(current_set, section))
                        self.sections.update(geosets)
                    else:
                        self.sections.update(self._parse_section(current_set, section))
                    current_set = ""
                    section.clear()
                    opening, closing = 0, 0

    def _parse_section(self, name: str, section: list) -> dict:
        func = {
            "Version": self._parse_version,
            "Model": self._parse_model,
            "Textures": self._parse_textures,
            "Materials": self._parse_materials,
            "Geoset": self._parse_geosets,
            "PivotPoints": self._parse_pivot,
        }.get(name, lambda *_: {})
        return func(name, section)  # noqa

    def _parse_version(self, name: str, section: list) -> dict:
        data: dict[str, dict] = {name: {}}
        for elem in section[1:-1]:
            var = self._parse_str(elem)
            data[name].update(self._todict(var))
        return data

    def _parse_model(self, name: str, section: list):
        data: dict[str, dict] = {name: {}}
        for elem in section[:-1]:
            if "Model" in elem:
                var = re.search("\"(.*)\"", elem).group(1)
                data[name].update(self._todict(["Name", var]))
            elif "MinimumExtent" in elem or "MaximumExtent" in elem:
                var = self._parse_str(elem)
                data[name].update(self._todict([var[0], var[1:]]))
            else:
                var = self._parse_str(elem)
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
            var = self._parse_str(elem)
            if len(var) < 2:
                var.append("True")
            bitmap.update(self._todict(var))
        return data

    def _parse_materials(self, name: str, section: list) -> dict:
        data: dict[str, list] = {name: []}
        layer = {}
        mstart, lstart = 0, 0
        for elem in section[1:-1]:
            if "Material" in elem:
                mstart = 1
                continue
            if "Layer" in elem:
                lstart = 2
                continue
            if "}" in elem and mstart == 1:
                data[name].append([layer])
                layer = {}
                mstart = 0
                continue
            if "}" in elem and lstart == 2:
                lstart = 0
                continue
            var = self._parse_str(elem, ["static"])
            layer.update(self._todict(var))
        return data

    def _parse_geosets(self, name: str, section: list) -> dict:
        data: dict[str, dict] = {name: {}}
        sections = iter(section[1:-1])
        groups = []
        faces, triangles = {}, []
        faces_start = 0
        group_start = 0

        def endpoint():
            return "}" in elem and len(elem.strip()) == 1

        while True:
            try:
                elem = next(sections)
                if "Vertices" in elem:
                    group = []
                    while True:
                        elem = next(sections)
                        if endpoint():
                            break
                        group.append(self._parse_str(elem))
                    data[name].update(self._todict(["Vertices", group]))
                    elem = next(sections)
                if "Normals" in elem:
                    group = []
                    while True:
                        elem = next(sections)
                        if endpoint():
                            break
                        group.append(self._parse_str(elem))
                    data[name].update(self._todict(["Normals", group]))
                    elem = next(sections)
                if "TVertices" in elem:
                    group = []
                    while True:
                        elem = next(sections)
                        if endpoint():
                            break
                        group.append(self._parse_str(elem))
                    data[name].update(self._todict(["TVertices", group]))
                    elem = next(sections)
                if "VertexGroup" in elem:
                    group = []
                    while True:
                        elem = next(sections)
                        if endpoint():
                            break
                        group.extend(self._parse_str(elem))
                    data[name].update(self._todict(["VertexGroup", group]))
                    elem = next(sections)
                if "Faces" in elem:
                    faces_start = 1
                if "Triangles" in elem and faces_start:
                    while True:
                        elem = next(sections)
                        if endpoint():
                            break
                        var = self._parse_str(elem)
                        triangles.append(var)
                    faces.update({"Triangles": triangles})
                if "Groups" in elem:
                    group_start = 1
                if "Matrices" in elem and group_start:
                    var = self._parse_str(elem)
                    groups.append(self._todict([var[0], var[1:]]))
                if "MinimumExtent" in elem or "MaximumExtent" in elem:
                    var = self._parse_str(elem)
                    data[name].update(self._todict([var[0], var[1:]]))
                if "MaterialID" in elem or "BoundsRadius" in elem:
                    var = self._parse_str(elem)
                    data[name].update(self._todict(var))
                if "}" in elem and group_start:
                    data[name].update(self._todict(["Groups", groups]))
                    group_start = 0
                if "}" in elem and faces_start:
                    data[name].update(self._todict(["Faces", faces]))
                    faces_start = 0
            except StopIteration:
                break
        return data

    def _parse_pivot(self, name: str, section: list) -> dict:
        data: dict[str, dict] = {name: {}}
        for elem in section[1:-1]:
            var = self._parse_str(elem)
            data[name].update(self._todict(["points", var]))
        return data

    def _parse_str(self, string: str, replace: list[str] = None) -> list:
        var = re.sub("[{},\"]", "", string)
        replace = replace or []
        for rep in replace:
            var = var.replace(rep, "")
        return var.strip().split(" ")

    def _todict(self, var: list) -> dict:
        it = iter(var)
        return dict(zip(it, it))
