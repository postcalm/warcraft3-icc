# Copyright meiso
#
from dataclasses import dataclass, field

from py.mdl_parser.mdl_types import MdlList, MdlNumber


@dataclass
class MDLModel:
    Name: str = ""
    NumGeosets: MdlNumber = "0"
    NumBones: MdlNumber = "0"
    BlendTime: MdlNumber = "0"
    MinimumExtent: MdlList[MdlNumber] = field(default_factory=lambda: ["0"])
    MaximumExtent: MdlList[MdlNumber] = field(default_factory=lambda: ["0"])
    BoundsRadius: MdlNumber = "0"

    def __post_init__(self):
        self.NumGeosets = MdlNumber(self.NumGeosets)
        self.NumBones = MdlNumber(self.NumBones)
        self.BlendTime = MdlNumber(self.BlendTime)
        self.MinimumExtent = MdlList(MdlNumber(m) for m in self.MinimumExtent)
        self.MaximumExtent = MdlList(MdlNumber(m) for m in self.MaximumExtent)
        self.BoundsRadius = MdlNumber(self.BoundsRadius)
