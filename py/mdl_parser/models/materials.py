# Copyright meiso
#
from copy import copy
from dataclasses import dataclass

from py.mdl_parser.models.textures import TexturesModel


@dataclass
class LayerModel:
    Id: int = 0
    OldId: int = None
    FilterMode: str = "None"
    TextureID: int = 0
    Alpha: int = 0

    def __post_init__(self):
        self.TextureID = int(self.TextureID)
        self.Alpha = int(self.Alpha)

    def __setattr__(self, key, value):
        if key == "Id":
            self.OldId = self.Id
        super().__setattr__(key, value)


@dataclass
class MaterialModel:
    layer: LayerModel


@dataclass(init=False)
class MaterialsModel:
    materials: list[MaterialModel]

    def __init__(self, materials: list[list[dict]]):
        self.materials = [MaterialModel(LayerModel(i, **elem[0])) for i, elem in enumerate(materials)]

    def extend(self, materials: list[MaterialModel], old_textures: TexturesModel, new_textures: TexturesModel):
        id_ = self.materials[-1].layer.Id
        for material in materials:
            old_bitmap = old_textures.get_bitmap(material.layer.TextureID)
            new_bitmap = new_textures.find_bitmap(old_bitmap.Image)
            id_ += 1
            new_material = copy(material)
            new_material.layer.Id = id_
            new_material.layer.TextureID = new_bitmap.Id
            self.materials.append(new_material)

    def get_material_by_old(self, index: int) -> MaterialModel:
        for m in self.materials:
            if m.layer.OldId == index:
                return m
