# Copyright meiso
#
from py.mdl_parser.models.geosets import Geosets
from py.mdl_parser.models.materials import Materials
from py.mdl_parser.models.model import Model
from py.mdl_parser.models.textures import Textures
from py.mdl_parser.models.version import Version
from py.mdl_parser.parser import _MdlParser


class Mdl:

    def __init__(self, model):
        self.parser = _MdlParser(model)

    @property
    def version(self) -> Version:
        return Version(**self.parser.get("Version", {}))

    @property
    def model(self) -> Model:
        return Model(**self.parser.get("Model", {}))

    @property
    def textures(self) -> Textures:
        return Textures(self.parser.get("Textures", []))

    @property
    def materials(self) -> Materials:
        return Materials(self.parser.get("Materials", []))

    @property
    def geosets(self):
        return Geosets(*self.parser.get("Geosets", []))
