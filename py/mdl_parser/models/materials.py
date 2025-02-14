# Copyright meiso
#
from dataclasses import dataclass


@dataclass
class Layer:
    FilterMode: str
    TextureID: int
    Alpha: int

    def __post_init__(self):
        self.TextureID = int(self.TextureID)
        self.Alpha = int(self.Alpha)


@dataclass
class Material:
    layer: Layer


@dataclass(init=False)
class Materials:
    materials: list[Material]

    def __init__(self, materials: list[list[dict]]):
        self.materials = [Material(Layer(**elem[0])) for elem in materials]
