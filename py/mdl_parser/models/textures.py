# Copyright meiso
#
from dataclasses import dataclass


@dataclass
class Bitmap:
    Image: str
    WrapHeight: bool = False
    WrapWidth: bool = False

    def __post_init__(self):
        self.WrapHeight = self.WrapHeight == "True"
        self.WrapWidth = self.WrapWidth == "True"


@dataclass(init=False)
class Textures:
    bitmaps: list[Bitmap]

    def __init__(self, bitmaps: list[dict]):
        self.bitmaps = [Bitmap(**elem) for elem in bitmaps]
