# Copyright meiso
#
from decimal import Decimal
from typing import Any, Union


class MdlList(list):

    def _format(self, val):
        format_ = "{}"
        if isinstance(val, float):
            dec = Decimal(str(val)) % 1
            length = dec.as_tuple().exponent * -1
            format_ = f"{{:.{length}f}}"
        return format_.format(val)

    def __str__(self):
        return self.__repr__()

    def __repr__(self):

        elems = ", ".join(map(self._format, self))
        return f"{{{elems}}}"


class MdlNumber:

    def __new__(cls, number, *args, **kwargs):
        if isinstance(number, MdlNumber):
            return number
        try:
            return int(number)
        except ValueError:
            return float(number)

    def __add__(self, other: Union["MdlNumber", int, float]) -> int | float:
        return MdlNumber(self + other)
