import itertools
from enum import Enum

from translator.models.terrain import Terrain
from translator.war3reader import War3Reader


def chunks(array: list, size: int):
    rows = []
    for i in range(0, len(array), size):
        rows.append(array[i:i + size])
    return rows


def flatten(array: list):
    return list(itertools.chain(*array))


class Tileset(str, Enum):
    """"""


class TerrainTranslator:
    """"""

    def json2war(self):
        pass

    def war2json(self, buffer: bytes):
        reader = War3Reader(buffer)
        terrain = Terrain()

        header = reader.read_chars(4)
        version = reader.read_int()
        terrain.tileset = reader.read_chars()
        terrain.custom_tileset = reader.read_int() == 1

        num_palette = reader.read_int()
        palette = []
        for i in range(num_palette):
            palette.append(reader.read_chars(4))
        terrain.tile_palette = palette

        num_cliff = reader.read_int()
        cliffs = []
        for i in range(num_cliff):
            cliffs.append(reader.read_chars(4))
        terrain.cliff_tile_palette = cliffs

        terrain.map.width = reader.read_int() - 1
        terrain.map.height = reader.read_int() - 1
        terrain.map.offset.x = reader.read_float()
        terrain.map.offset.y = reader.read_float()

        array_ground_height = []
        array_water_height = []
        array_boundary_flag = []
        array_flags = []
        array_ground_texture = []
        array_ground_variation = []
        array_cliff_variation = []
        array_cliff_texture = []
        array_layer_height = []

        while not reader.is_exhausted():
            ground_height = reader.read_short()
            water_height_and_boundary = reader.read_short()
            water_height = water_height_and_boundary & 32_767
            boundary_flag = (water_height_and_boundary & 0x4000) == 0x4000

            if version == 12:
                flags_and_ground_texture = reader.read_short()
                flags = flags_and_ground_texture & 0b1111_1111_1100_0000  # upper 10 bits
                ground_texture = flags_and_ground_texture & 0b0000_0000_0011_1111  # lower 6 bits
            else:  # version 11
                flags_and_ground_texture = reader.read_byte()
                flags = flags_and_ground_texture & 0b1111_0000  # upper 4 bits
                ground_texture = flags_and_ground_texture & 0b0000_1111  # lower 4 bits

            ground_and_cliff_variation = reader.read_byte()
            ground_variation = ground_and_cliff_variation & 0b1111_1000  # upper 5 bits
            cliff_variation = ground_and_cliff_variation & 0b0000_0111  # lower 3 bits

            cliff_texture_and_layer_height = reader.read_byte()
            cliff_texture = cliff_texture_and_layer_height & 0b1111_0000  # upper 4 bits
            layer_height = cliff_texture_and_layer_height & 0b0000_1111  # lower 4 bits

            array_ground_height.append(ground_height)
            array_water_height.append(water_height)
            array_boundary_flag.append(boundary_flag)
            array_flags.append(flags)
            array_ground_texture.append(ground_texture)
            array_ground_variation.append(ground_variation)
            array_cliff_variation.append(cliff_variation)
            array_cliff_texture.append(cliff_texture)
            array_layer_height.append(layer_height)

        size = terrain.map.width + 1
        terrain.ground_height = flatten(chunks(array_ground_height, size)[::-1])
        terrain.water_height = flatten(chunks(array_water_height, size)[::-1])
        terrain.boundary_flag = flatten(chunks(array_boundary_flag, size)[::-1])
        terrain.flags = flatten(chunks(array_flags, size)[::-1])
        terrain.ground_texture = flatten(chunks(array_ground_texture, size)[::-1])
        terrain.ground_variation = flatten(chunks(array_ground_variation, size)[::-1])
        terrain.cliff_variation = flatten(chunks(array_cliff_variation, size)[::-1])
        terrain.cliff_texture = flatten(chunks(array_cliff_texture, size)[::-1])
        terrain.layer_height = flatten(chunks(array_layer_height, size)[::-1])

        return {
            "header": header,
            "version": version,
            **terrain.dump(),
        }
