# Copyright meiso
#
from dataclasses import dataclass


@dataclass
class Model:
    Name: str
    NumGeosets: int
    NumBones: int
    BlendTime: int
    MinimumExtent: list[float]
    MaximumExtent: list[float]
    BoundsRadius: float

    def __post_init__(self):
        self.NumGeosets = int(self.NumGeosets)
        self.NumBones = int(self.NumBones)
        self.BlendTime = int(self.BlendTime)
        self.MinimumExtent = [float(m) for m in self.MinimumExtent]
        self.MaximumExtent = [float(m) for m in self.MaximumExtent]
        self.BoundsRadius = float(self.BoundsRadius)
