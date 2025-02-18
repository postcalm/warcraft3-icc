# Copyright meiso
#
from dataclasses import dataclass

from py.mdl_parser.mdl_types import MdlNumber, MdlList


@dataclass
class PivotPointsModel:
    points: MdlList[MdlNumber] = "800"

    def __post_init__(self):
        self.points = MdlList(MdlNumber(p) for p in self.points)
