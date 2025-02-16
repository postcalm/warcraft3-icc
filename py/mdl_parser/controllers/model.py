# Copyright meiso
#
from py.mdl_parser.controllers.controller import Controller
from py.mdl_parser.models.model import MDLModel


class Model(Controller):
    """
    Модель
    """

    def model(self) -> MDLModel:
        return super().model()
