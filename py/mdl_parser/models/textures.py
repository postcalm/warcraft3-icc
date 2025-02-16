# Copyright meiso
#
from copy import copy
from dataclasses import dataclass


@dataclass
class BitmapModel:
    Id: int = None
    Image: str = ""
    WrapHeight: bool = False
    WrapWidth: bool = False

    def __post_init__(self):
        self.WrapHeight = self.WrapHeight == "True"
        self.WrapWidth = self.WrapWidth == "True"


@dataclass(init=False)
class TexturesModel:
    bitmaps: list[BitmapModel]

    def __init__(self, bitmaps: list[dict]):
        self.bitmaps = [BitmapModel(i, **elem) for i, elem in enumerate(bitmaps)]

    def find_bitmap(self, image: str) -> BitmapModel:
        for b in self.bitmaps:
            if b.Image == image:
                return b

    def get_bitmap(self, index: int) -> BitmapModel:
        for b in self.bitmaps:
            if b.Id == index:
                return b

    def extend(self, bitmaps: list[BitmapModel]):
        id_ = self.bitmaps[-1].Id
        for bitmap in bitmaps:
            not_in = not any(b for b in self.bitmaps if b.Image == bitmap.Image)
            if not_in:
                id_ += 1
                new_bitmap = copy(bitmap)
                new_bitmap.Id = id_
                self.bitmaps.append(new_bitmap)
