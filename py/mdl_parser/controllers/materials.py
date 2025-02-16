# Copyright meiso
#
from py.mdl_parser.controllers.controller import Controller
from py.mdl_parser.models.materials import MaterialsModel


class Materials(Controller):
    """
    Материалы модели
    """

    def model(self) -> MaterialsModel:
        return super().model()
