# Copyright meiso
#
from py.mdl_parser.views.view import MDLObjectView


class PivotPointsView(MDLObjectView):

    def view(self) -> str:
        lines = [f"{self.model_name} 1 {{"]
        for k in self._data_fields.keys():
            spaces = f"\t"
            lines.append(f"{spaces}{getattr(self.model, k)},")
        lines.append("}")
        text = "\n".join(lines)
        return text
