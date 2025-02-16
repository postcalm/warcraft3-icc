# Copyright meiso
#
from py.mdl_parser.controllers.controller import Controller
from py.mdl_parser.models.textures import TexturesModel


class Textures(Controller):
    """
    Текстуры модели
    """

    def model(self) -> TexturesModel:
        return super().model()
