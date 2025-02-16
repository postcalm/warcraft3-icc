# Copyright meiso
#
from dataclasses import dataclass

from py.mdl_parser.mdl_types import MdlNumber


@dataclass
class VersionModel:
    FormatVersion: MdlNumber = "800"

    def __post_init__(self):
        self.FormatVersion = MdlNumber(self.FormatVersion)
