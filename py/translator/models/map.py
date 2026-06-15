from dataclasses import dataclass


@dataclass
class Offset:
    """"""
    x: int | None = None
    y: int | None = None


@dataclass
class Map:
    """"""

    width: int | None = None
    height: int | None = None
    offset: Offset = Offset()
