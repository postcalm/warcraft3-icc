# Copyright meiso
#
from pathlib import Path

from py.mdl_parser.controllers.geosets import Geosets
from py.mdl_parser.controllers.materials import Materials
from py.mdl_parser.controllers.model import Model
from py.mdl_parser.controllers.pivot import PivotPoints
from py.mdl_parser.controllers.textures import Textures
from py.mdl_parser.controllers.version import Version
from py.mdl_parser.models.geosets import GeosetsModel
from py.mdl_parser.models.materials import MaterialsModel
from py.mdl_parser.models.model import MDLModel
from py.mdl_parser.models.pivot import PivotPointsModel
from py.mdl_parser.models.textures import TexturesModel
from py.mdl_parser.models.version import VersionModel
from py.mdl_parser.parser import _MdlParser
from py.mdl_parser.views.geosets import GeosetsView
from py.mdl_parser.views.materials import MaterialsView
from py.mdl_parser.views.model import MDLView
from py.mdl_parser.views.pivot import PivotPointsView
from py.mdl_parser.views.textures import TexturesView
from py.mdl_parser.views.version import VersionView


class Mdl:

    def __init__(self, model: str = None):
        self._model_path = model
        self.parser = _MdlParser(model)

        self._version = None
        self._model = None
        self._textures = None
        self._materials = None
        self._geosets = None
        self._pivot_points = None

    @property
    def version(self) -> Version:
        model = VersionModel(**self.parser.get("Version", {}))
        if not self._version:
            self._version = Version(model, VersionView(model))
        return self._version

    @version.setter
    def version(self, version: Version) -> None:
        self._version = version

    @property
    def model(self) -> Model:
        model = MDLModel(**self.parser.get("Model", {}))
        if not self._model:
            self._model = Model(model, MDLView(model))
        return self._model

    @model.setter
    def model(self, model: Model) -> None:
        self._model = model

    @property
    def textures(self) -> Textures:
        model = TexturesModel(self.parser.get("Textures", []))
        if not self._textures:
            self._textures = Textures(model, TexturesView(model))
        return self._textures

    @textures.setter
    def textures(self, textures: Textures) -> None:
        self._textures = textures

    @property
    def materials(self) -> Materials:
        model = MaterialsModel(self.parser.get("Materials", []))
        if not self._materials:
            self._materials = Materials(model, MaterialsView(model))
        return self._materials

    @materials.setter
    def materials(self, materials: Materials) -> None:
        self._materials = materials

    @property
    def geosets(self) -> Geosets:
        model = GeosetsModel(*self.parser.get("Geosets", []))
        if not self._geosets:
            self._geosets = Geosets(model, GeosetsView(model))
        return self._geosets

    @geosets.setter
    def geosets(self, geosets: Geosets) -> None:
        self._geosets = geosets

    @property
    def pivot_points(self) -> PivotPoints:
        model = PivotPointsModel(**self.parser.get("PivotPoints", {}))
        if not self._pivot_points:
            self._pivot_points = PivotPoints(model, PivotPointsView(model))
        return self._pivot_points

    @pivot_points.setter
    def pivot_points(self, points: PivotPoints) -> None:
        self._pivot_points = points

    def merge(self, model: "Mdl") -> "Mdl":
        new = Mdl()
        new.version = self.version
        new.model = self.model
        new.model.model().NumGeosets += model.model.model().NumGeosets
        new.textures = self.textures
        new.textures.model().extend(
            model.textures.model().bitmaps
        )
        new.materials = self.materials
        new.materials.model().extend(
            model.materials.model().materials,
            model.textures.model(),
            new.textures.model()
        )
        new.geosets = self.geosets
        new.geosets.model().extend(
            model.geosets.model().geosets,
            new.materials.model()
        )
        new.pivot_points = self.pivot_points
        return new

    def save(self, filename: str = None, folder: str = "models"):
        filename = filename or self._model_path
        with Path(folder, filename).open("w") as handle:
            handle.write(f"{self.version.view()}\n")
            handle.write(f"{self.model.view()}\n")
            handle.write(f"{self.textures.view()}\n")
            handle.write(f"{self.materials.view()}\n")
            handle.write(f"{self.geosets.view()}\n")
            handle.write(f"{self.pivot_points.view()}\n")
