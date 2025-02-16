# Copyright meiso
#
from py.mdl_parser.controllers.controller import Controller
from py.mdl_parser.models.geosets import GeosetsModel


class Geosets(Controller):
    """
    Геосеты модели
    """

    def model(self) -> GeosetsModel:
        return super().model()
