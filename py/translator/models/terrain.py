from dataclasses import dataclass, field

from translator.models.map import Map


@dataclass
class Terrain:
    """"""

    tileset: str = "L"
    custom_tileset: bool = False
    map: Map = Map()
    tile_palette: list[str] = field(default_factory=list)
    cliff_tile_palette: list[str] = field(default_factory=list)
    ground_height: list[int] = field(default_factory=list)
    water_height: list[int] = field(default_factory=list)
    boundary_flag: list[bool] = field(default_factory=list)
    flags: list[int] = field(default_factory=list)
    ground_texture: list[int] = field(default_factory=list)
    ground_variation: list[int] = field(default_factory=list)
    cliff_variation: list[int] = field(default_factory=list)
    cliff_texture: list[int] = field(default_factory=list)
    layer_height: list[int] = field(default_factory=list)

    def dump(self) -> dict:
        return {
            "tileset": self.tileset,
            "customTileset": self.custom_tileset,
            "tilePalette": self.tile_palette,
            "cliffTilePalette": self.cliff_tile_palette,
            "map": {
                "width": self.map.width,
                "height": self.map.height,
                "offset": {
                    "x": self.map.offset.x,
                    "y": self.map.offset.y,
                },
            },
            "groundHeight": self.ground_height,
            "waterHeight": self.water_height,
            "boundaryFlag": self.boundary_flag,
            "flags": self.flags,
            "groundTexture": self.ground_texture,
            "groundVariation": self.ground_variation,
            "cliffVariation": self.cliff_variation,
            "cliffTexture": self.cliff_texture,
            "layerHeight": self.layer_height,
        }
