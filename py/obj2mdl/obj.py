from __future__ import annotations

from dataclasses import dataclass, field


@dataclass
class ObjResult:
    """"""
    models: list[ObjModel] = field(default_factory=list)
    material_libs: list[str] = field(default_factory=list)


@dataclass
class ObjModel:
    """"""
    name: str = "untitled"
    vertices: list[ObjVertex] = field(default_factory=list)
    texture_coords: list[ObjTextureVertex] = field(default_factory=list)
    vertex_normals: list[ObjVertex] = field(default_factory=list)
    faces: list[ObjFace] = field(default_factory=list)


@dataclass
class ObjFace:
    """"""
    material: str = None
    group: str = None
    smoothing_group: int = None
    vertices: list[ObjFaceVertex] = field(default_factory=list)


@dataclass
class ObjFaceVertex:
    """"""
    vertex_index: int = None
    texture_coords_index: int = None
    vertex_normal_index: int = None


@dataclass
class ObjVertex:
    """"""
    x: float = 0.
    y: float = 0.
    z: float = 0.


@dataclass
class ObjTextureVertex:
    """"""
    u: float = 0.
    v: float = 0.
    w: float = 0.


class ObjFile:
    """"""

    def __init__(self, content: str = "", name: str = "untitled"):
        self.content = content
        self.model_name = name
        self.current_material = ""
        self.current_group = ""
        self.smoothing_group = 0
        self.result = ObjResult()

    def parse(self):
        for line in self.content.split("\n"):
            if "#" in line:
                continue
            items = line.split(" ")
            print(items)
            match items[0].lower():
                case "o":
                    self.parse_obj(items)
                case "g":
                    self.parse_group(items)
                case "v":
                    self.parse_vertex_coords(items)
                case "vt":
                    self.parse_texture_coords(items)
                case "vn":
                    self.parse_vertex_normal(items)
                case "s":
                    self.parse_smooth_shading_statement(items)
                case "f":
                    self.parse_polygon(items)
                case "mtllib":
                    self.parse_mtl_lib(items)
                case "usemtl":
                    self.parse_use_mtl(items)
                case _:
                    pass

    @property
    def current_model(self):
        if len(self.result.models) == 0:
            self.result.models.append(
                ObjModel()
            )
        return self.result.models[-1]

    def parse_obj(self, items: list[str]) -> None:
        name = items[1] if len(items) >= 2 else self.model_name
        self.result.models.append(
            ObjModel(name)
        )
        self.current_group = ""
        self.smoothing_group = 0

    def parse_group(self, items: list[str]):
        if len(items) < 2:
            raise ValueError("'Group statements must have exactly 1 argument (eg. g group_1)")
        self.current_group = items[1]

    def parse_vertex_coords(self, items: list[str]):
        length = len(items)
        x = float(items[1]) if length >= 2 else 0.
        y = float(items[2]) if length >= 3 else 0.
        z = float(items[3]) if length >= 4 else 0.
        self.current_model.vertices.append(ObjVertex(x, y, z))

    def parse_texture_coords(self, items: list[str]):
        length = len(items)
        u = float(items[1]) if length >= 2 else 0.
        v = float(items[2]) if length >= 3 else 0.
        w = float(items[3]) if length >= 4 else 0.
        self.current_model.texture_coords.append(ObjTextureVertex(u, v, w))

    def parse_vertex_normal(self, items: list[str]):
        length = len(items)
        x = float(items[1]) if length >= 2 else 0.
        y = float(items[2]) if length >= 3 else 0.
        z = float(items[3]) if length >= 4 else 0.
        self.current_model.vertex_normals.append(ObjVertex(x, y, z))

    def parse_polygon(self, items: list[str]):
        total_vertices = len(items) - 1
        if total_vertices < 3:
            raise ValueError("Face statement has less than 3 vertices")

        face = ObjFace(
            group=self.current_group,
            material=self.current_material,
            smoothing_group=self.smoothing_group,
        )
        for i in range(total_vertices):
            vertex_string = items[i + 1]
            vertex_values = vertex_string.split("/")

            vertex_index = int(vertex_values[0])
            texture_coords_index = 0
            vertex_normal_index = 0
            if len(vertex_values) > 1 and not vertex_values[1]:
                texture_coords_index = int(vertex_values[1])
            if len(vertex_values) > 2:
                vertex_normal_index = int(vertex_values[2])

            if not vertex_index:
                raise ValueError("Faces uses invalid vertex index of 0")

            if vertex_index < 0:
                vertex_index = len(self.current_model.vertices) + 1 + vertex_index

            face.vertices.append(
                ObjFaceVertex(vertex_index, texture_coords_index, vertex_normal_index)
            )
        self.current_model.faces.append(face)

    def parse_mtl_lib(self, items: list[str]):
        if len(items) >= 2:
            self.result.material_libs.append(items[1])

    def parse_use_mtl(self, items: list[str]):
        if len(items) >= 2:
            self.current_material = items[1]

    def parse_smooth_shading_statement(self, items: list[str]):
        if len(items) >= 2:
            raise ValueError("Smoothing group statements must have exactly 1 argument (eg. s <number|off>)")

        group_number = 0 if items[1].lower() == "off" else int(items[1])
        self.smoothing_group = group_number

_content = """
# Exported using wow.export v0.2.1
o Mesh
mtllib adt_33_34.mtl
v -533.333984375 -53.800743103027344 -1066.666015625
v -537.5006510416666 -54.296165466308594 -1066.666015625
v -541.6673177083334 -54.70833969116211 -1066.666015625
vn -0.06299212598425197 0.9921259842519685 0.07874015748031496
vn -0.06299212598425197 0.984251968503937 0.13385826771653545
vn -0.05511811023622047 0.9763779527559056 0.18110236220472442
vn -0.047244094488188976 0.9763779527559056 0.1968503937007874
vt 0.5351550292968751 0.902342529296875
vt 0.5429675292968753 0.902342529296875
vt 0.5507800292968751 0.902342529296875
vt 0.5585925292968751 0.902342529296875
f 3964/3964/3964 3972/3972/3972 3973/3973/3973
f 3965/3965/3965 3956/3956/3956 3973/3973/3973
f 3965/3965/3965 3957/3957/3957 3956/3956/3956
"""

objf = ObjFile(_content)
objf.parse()
print(objf.result)
