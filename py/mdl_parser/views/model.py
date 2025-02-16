# Copyright meiso
#
from py.mdl_parser.views.view import MDLObjectView


class MDLView(MDLObjectView):

    def view(self) -> str:
        name = getattr(self.model, "Name")
        lines = [f'Model "{name}" {{']
        for k in list(self._data_fields.keys())[1:]:
            spaces = f"\t"
            lines.append(f"{spaces}{k} {getattr(self.model, k)},")
        lines.append("}")
        text = "\n".join(lines)
        return text
