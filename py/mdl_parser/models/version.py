# Copyright meiso
#
from dataclasses import dataclass


@dataclass
class Version:
    FormatVersion: int

    def __post_init__(self):
        self.FormatVersion = int(self.FormatVersion)
