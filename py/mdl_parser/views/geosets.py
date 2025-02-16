# Copyright meiso
#
from py.mdl_parser.models.geosets import VerticesModel, NormalsModel, TVerticesModel, VertexGroupModel, FacesModel, \
    GroupsModel
from py.mdl_parser.views.view import MDLObjectView


class VerticesView(MDLObjectView):

    def view(self) -> str:
        outer_spaces = f"\t"
        vertices = getattr(self.model, "vertices", [])
        lines = [f"{outer_spaces}{self.model_name} {len(vertices)} {{"]
        for v in vertices:
            spaces = f"\t\t"
            lines.append(f"{spaces}{v},")
        lines.append(f"{outer_spaces}}}")
        text = "\n".join(lines)
        return text


class NormalsView(MDLObjectView):

    def view(self) -> str:
        outer_spaces = f"\t"
        normals = getattr(self.model, "normals", [])
        lines = [f"{outer_spaces}{self.model_name} {len(normals)} {{"]
        for n in normals:
            spaces = f"\t\t"
            lines.append(f"{spaces}{n},")
        lines.append(f"{outer_spaces}}}")
        text = "\n".join(lines)
        return text


class TVerticesView(MDLObjectView):

    def view(self) -> str:
        outer_spaces = f"\t"
        vertices = getattr(self.model, "tvertices", [])
        lines = [f"{outer_spaces}{self.model_name} {len(vertices)} {{"]
        for v in vertices:
            spaces = f"\t\t"
            lines.append(f"{spaces}{v},")
        lines.append(f"{outer_spaces}}}")
        text = "\n".join(lines)
        return text


class VertexGroupView(MDLObjectView):

    def view(self) -> str:
        outer_spaces = f"\t"
        vertexes = getattr(self.model, "vertexes", [])
        lines = [f"{outer_spaces}{self.model_name} {{"]
        for v in vertexes:
            spaces = f"\t\t"
            lines.append(f"{spaces}{v},")
        lines.append(f"{outer_spaces}}}")
        text = "\n".join(lines)
        return text


class TrianglesView(MDLObjectView):

    def view(self) -> str:
        outer_spaces = f"\t\t"
        triangles = getattr(self.model, "tria")
        lines = [f"{outer_spaces}{self.model_name} {{"]
        for t in triangles:
            spaces = f"\t\t\t"
            lines.append(f"{spaces}{t},")
        lines.append(f"{outer_spaces}}}")
        text = "\n".join(lines)
        return text


class MatricesView(MDLObjectView):

    def view(self) -> str:
        spaces = f"\t\t"
        matrices = getattr(self.model, "Matrices")
        return f"{spaces}{self.model_name} {matrices},"


class FacesView(MDLObjectView):

    def view(self) -> str:
        spaces = f"\t"
        triangles = getattr(self.model, "Triangles")
        count, elems = len(triangles.tria), len(triangles.tria[0])
        lines = [
            f"{spaces}{self.model_name} {count} {count * elems} {{",
            TrianglesView(triangles).view(),
            f"{spaces}}}"
        ]
        text = "\n".join(lines)
        return text


class GroupsView(MDLObjectView):

    def view(self) -> str:
        spaces = f"\t"
        groups = getattr(self.model, "groups")
        count, elems = len(groups), len(groups[0].Matrices)
        lines = [f"{spaces}{self.model_name} {count} {count * elems} {{"]
        for g in groups:
            lines.append(f"{MatricesView(g).view()}")
        lines.append(f"{spaces}}}")
        text = "\n".join(lines)
        return text


class GeosetView(MDLObjectView):

    def view(self) -> str:
        lines = [f"{self.model_name} {{"]
        for k in self._data_fields.keys():
            spaces = f"\t"
            attr = getattr(self.model, k)
            if isinstance(attr, VerticesModel):
                lines.append(VerticesView(attr).view())
            elif isinstance(attr, NormalsModel):
                lines.append(NormalsView(attr).view())
            elif isinstance(attr, TVerticesModel):
                lines.append(TVerticesView(attr).view())
            elif isinstance(attr, VertexGroupModel):
                lines.append(VertexGroupView(attr).view())
            elif isinstance(attr, FacesModel):
                lines.append(FacesView(attr).view())
            elif isinstance(attr, GroupsModel):
                lines.append(GroupsView(attr).view())
            else:
                lines.append(f"{spaces}{k} {attr},")
        lines.append("}")
        text = "\n".join(lines)
        return text


class GeosetsView(MDLObjectView):

    def view(self) -> str:
        geosets = getattr(self.model, "geosets")
        lines = [GeosetView(g).view() for g in geosets]
        return "\n".join(lines)
