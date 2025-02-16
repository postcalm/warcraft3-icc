# Copyright meiso
#
from py.mdl_parser.views.view import MDLObjectView


class VersionView(MDLObjectView):

    def view(self) -> str:
        lines = [f"{self.model_name} {{"]
        for k in self._data_fields.keys():
            spaces = f"\t"
            lines.append(f"{spaces}{k} {getattr(self.model, k)},")
        lines.append("}")
        text = "\n".join(lines)
        return text
