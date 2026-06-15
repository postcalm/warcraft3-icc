import struct


class War3Reader:
    """"""

    def __init__(self, buffer: bytes):
        self._buffer = buffer
        self._offset = 0

    def read_int(self):
        value = struct.unpack("<l", self._buffer[self._offset:self._offset + 4])
        self._offset += 4
        print(value)
        return value[0]

    def read_short(self):
        value = struct.unpack("<h", self._buffer[self._offset:self._offset + 2])
        self._offset += 2
        return value[0]

    def read_float(self):
        value = struct.unpack("<f", self._buffer[self._offset:self._offset + 4])
        self._offset += 4
        # print(value)
        return round(value[0], 3)

    def read_byte(self):
        value = struct.unpack("<c", self._buffer[self._offset:self._offset + 1])
        self._offset += 1
        return int.from_bytes(value[0], byteorder="little")

    def read_string(self):
        array = []
        while self._buffer[self._offset] != 0:
            array.append(self._buffer[self._offset])
            self._offset += 1
        self._offset += 1

        return "".join(map(chr, array))

    def read_chars(self, length: int = 1, allow_null: bool = False):
        array = []
        for i in range(length):
            array.append(self._buffer[self._offset])
            self._offset += 1

        def _convert(char):
            if not allow_null and char == 0:
                return "0"
            return chr(char)

        return "".join(map(_convert, array))

    def read_four_cc(self):
        return self.read_chars(4, True)

    def is_exhausted(self):
        return self._offset == len(self._buffer)
