# Copyright meiso
#
from py.mdl_parser.views.view import MDLObjectView


class BitmapView(MDLObjectView):

    def view(self) -> str:
        outer_spaces = f"\t"
        lines = [f"{outer_spaces}{self.model_name} {{"]
        for k in list(self._data_fields.keys())[1:]:
            spaces = f"\t\t"
            attr = getattr(self.model, k)
            if isinstance(attr, bool):
                if attr:
                    lines.append(f"{spaces}{k},")
            else:
                lines.append(f'{spaces}{k} "{attr}",')
        lines.append(f"{outer_spaces}}}")
        text = "\n".join(lines)
        return text


class TexturesView(MDLObjectView):

    def view(self) -> str:
        bitmaps = getattr(self.model, "bitmaps", [])
        count = len(bitmaps)
        lines = [f"{self.model_name} {count} {{"]
        for bitmap in bitmaps:
            lines.append(BitmapView(bitmap).view())
        lines.append("}")
        text = "\n".join(lines)
        return text
