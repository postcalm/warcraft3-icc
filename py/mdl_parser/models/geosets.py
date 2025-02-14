# Copyright meiso
#
from dataclasses import dataclass


@dataclass
class Vertices:
    vertices: list[list[float]]

    def __post_init__(self):
        self.vertices = [[float(v) for v in vert] for vert in self.vertices]


@dataclass
class Normals:
    normals: list[list[float]]

    def __post_init__(self):
        self.normals = [[float(n) for n in normals] for normals in self.normals]


@dataclass
class TVertices:
    tvertices: list[list[float]]

    def __post_init__(self):
        self.tvertices = [[float(v) for v in vert] for vert in self.tvertices]


@dataclass
class VertexGroup:
    vertexes: list[int]

    def __post_init__(self):
        self.vertexes = [int(vert) for vert in self.vertexes]


@dataclass
class Triangles:
    tria: list[list[int]]

    def __post_init__(self):
        self.tria = [[int(t) for t in tria] for tria in self.tria]


@dataclass
class Matrices:
    matrices: list[int]


@dataclass
class Anim:
    MinimumExtent: list[float]
    MaximumExtent: list[float]
    BoundsRadius: float


@dataclass()
class Faces:
    Triangles: Triangles

    def __init__(self, **kwargs):
        self.Triangles = Triangles(kwargs.get("Triangles"))


@dataclass
class Groups:
    matrices: Matrices


@dataclass(init=False)
class Geoset:
    Vertices: Vertices = None
    Normals: Normals = None
    TVertices: TVertices = None
    VertexGroup: VertexGroup = None
    Faces: Faces = None
    Groups: Groups = None
    MinimumExtent: list[float] = None
    MaximumExtent: list[float] = None
    BoundsRadius: float = None
    MaterialID: int = None

    def __init__(self, **kwargs):
        self.Vertices = Vertices(kwargs.get("Vertices"))
        self.Normals = Normals(kwargs.get("Normals"))
        self.TVertices = TVertices(kwargs.get("TVertices"))
        self.VertexGroup = VertexGroup(kwargs.get("VertexGroup"))
        self.Faces = Faces(**kwargs.get("Faces"))
        self.Groups = Groups(kwargs.get("Groups"))
        self.MinimumExtent = [float(ext) for ext in kwargs.get("MinimumExtent")]
        self.MaximumExtent = [float(ext) for ext in kwargs.get("MaximumExtent")]
        self.BoundsRadius = float(kwargs.get("BoundsRadius"))
        self.MaterialID = int(kwargs.get("MaterialID"))


@dataclass(init=False)
class Geosets:
    geosets: list[Geoset]

    def __init__(self, *args: dict):
        self.geosets = [Geoset(**arg.get("Geoset")) for arg in args]
