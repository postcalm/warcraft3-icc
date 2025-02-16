# Copyright meiso
#
from typing import Any

from py.mdl_parser.views.view import View


class Controller:

    def __init__(self, model: object, view: View):
        self._model = model
        self._view = view

    def model(self) -> Any:
        return self._model

    def view(self) -> str:
        return self._view.view()
