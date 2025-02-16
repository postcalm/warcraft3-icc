# Copyright meiso
#
from abc import ABC, abstractmethod


class View(ABC):

    @abstractmethod
    def view(self) -> str:
        raise NotImplementedError


class MDLObjectView(View, ABC):

    def __init__(self, model: object):
        self.model = model

    @property
    def model_name(self):
        return self.model.__class__.__name__.replace("Model", "")

    @property
    def _data_fields(self) -> dict:
        return self.model.__annotations__
