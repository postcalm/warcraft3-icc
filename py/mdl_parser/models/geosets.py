# Copyright meiso
#
from copy import copy
from dataclasses import dataclass, field

from py.mdl_parser.mdl_types import MdlList, MdlNumber
from py.mdl_parser.models.materials import MaterialsModel


@dataclass
class VerticesModel:
    vertices: list[MdlList[MdlNumber]] = field(default=list)

    def __post_init__(self):
        self.vertices = [MdlList(MdlNumber(v) for v in vert) for vert in self.vertices]


@dataclass
class NormalsModel:
    normals: list[MdlList[MdlNumber]] = field(default=list)

    def __post_init__(self):
        self.normals = [MdlList(MdlNumber(n) for n in normals) for normals in self.normals]


@dataclass
class TVerticesModel:
    tvertices: list[MdlList[MdlNumber]] = field(default=list)

    def __post_init__(self):
        self.tvertices = [MdlList(MdlNumber(v) for v in vert) for vert in self.tvertices]


@dataclass
class VertexGroupModel:
    vertexes: list[MdlNumber] = field(default=list)

    def __post_init__(self):
        self.vertexes = [MdlNumber(vert) for vert in self.vertexes]


@dataclass
class TrianglesModel:
    tria: list[MdlList[MdlNumber]]

    def __post_init__(self):
        self.tria = [MdlList(MdlNumber(t) for t in tria) for tria in self.tria]


@dataclass
class MatricesModel:
    Matrices: MdlList[MdlNumber] = field(default=MdlList)

    def __post_init__(self):
        self.Matrices = MdlList(MdlNumber(m) for m in self.Matrices)


@dataclass
class FacesModel:
    Triangles: TrianglesModel

    def __init__(self, **kwargs):
        self.Triangles = TrianglesModel(kwargs.get("Triangles"))


@dataclass
class GroupsModel:
    groups: list[MatricesModel] = field(default=list)

    def __init__(self, *args):
        self.groups = [MatricesModel(**m) for m in args]


@dataclass(init=False)
class GeosetModel:
    Vertices: VerticesModel = None
    Normals: NormalsModel = None
    TVertices: TVerticesModel = None
    VertexGroup: VertexGroupModel = None
    Faces: FacesModel = None
    Groups: GroupsModel = None
    MinimumExtent: MdlList[MdlNumber] = None
    MaximumExtent: MdlList[MdlNumber] = None
    BoundsRadius: MdlNumber = None
    MaterialID: int = None

    def __init__(self, **kwargs):
        self.Vertices = VerticesModel(kwargs.get("Vertices"))
        self.Normals = NormalsModel(kwargs.get("Normals"))
        self.TVertices = TVerticesModel(kwargs.get("TVertices"))
        self.VertexGroup = VertexGroupModel(kwargs.get("VertexGroup"))
        self.Faces = FacesModel(**kwargs.get("Faces"))
        self.Groups = GroupsModel(*kwargs.get("Groups"))
        self.MinimumExtent = MdlList(MdlNumber(ext) for ext in kwargs.get("MinimumExtent"))
        self.MaximumExtent = MdlList(MdlNumber(ext) for ext in kwargs.get("MaximumExtent"))
        self.BoundsRadius = MdlNumber(kwargs.get("BoundsRadius"))
        self.MaterialID = int(kwargs.get("MaterialID"))


@dataclass(init=False)
class GeosetsModel:
    geosets: list[GeosetModel]

    def __init__(self, *args: dict):
        self.geosets = [GeosetModel(**arg.get("Geoset")) for arg in args]

    def extend(self, geosets: list[GeosetModel], old_materials: MaterialsModel):
        for geoset in geosets:
            old_material = old_materials.get_material_by_old(geoset.MaterialID)
            new_geoset = copy(geoset)
            new_geoset.MaterialID = old_material.layer.Id
            self.geosets.append(new_geoset)
