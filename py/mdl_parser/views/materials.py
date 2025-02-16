# Copyright meiso
#
from py.mdl_parser.views.view import MDLObjectView


class LayerView(MDLObjectView):

    _static_vars = ["TextureID", "Alpha"]

    def view(self) -> str:
        outer_spaces = f"\t\t"
        lines = [f"{outer_spaces}{self.model_name} {{"]
        for k in list(self._data_fields.keys())[2:]:
            spaces = f"\t\t\t"
            mod = "static " if k in self._static_vars else ""
            lines.append(f'{spaces}{mod}{k} {getattr(self.model, k)},')
        lines.append(f"{outer_spaces}}}")
        text = "\n".join(lines)
        return text


class MaterialView(MDLObjectView):

    def view(self) -> str:
        spaces = f"\t"
        layer = getattr(self.model, "layer")
        lines = [
            f"{spaces}{self.model_name} {{",
            f"{LayerView(layer).view()}",
            f"{spaces}}}"
        ]
        return "\n".join(lines)


class MaterialsView(MDLObjectView):

    def view(self) -> str:
        materials = getattr(self.model, "materials", [])
        count = len(materials)
        lines = [f"{self.model_name} {count} {{"]
        for material in materials:
            lines.append(MaterialView(material).view())
        lines.append("}")
        text = "\n".join(lines)
        return text
