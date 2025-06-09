# Copyright meiso
#
import sys
from argparse import ArgumentParser, Namespace

from build.builder import Builder
from build.runner import Warcraft, WorldEditor
from build.copy_files import copy
from build.maps import MAPS
from build.utils import prepare_release


# Чтобы кастомный код заработал, надо в самой карте через редактор
# вставить тег --CUSTOM_CODE дважды.
# По этим меткам будет производиться замена кода


def parse_arguments():
    parser = ArgumentParser()
    parser.add_argument("map", choices=MAPS.keys(), help="Собираемая карта")
    parser.add_argument("--run", action="store_true", help="Запустить карту в игре")
    parser.add_argument("--edit", action="store_true", help="Запустить карту в редакторе")
    parser.add_argument("--release", action="store_true", help="Задать версию и подготовить карту")
    return parser.parse_args()


def main(args: Namespace):
    m = MAPS.get(args.map)
    if args.release:
        prepare_release(m.map)
        sys.exit(0)
    copy(m.map)
    Builder(m).build()
    if args.edit:
        WorldEditor(m.map).run()
    if args.run:
        Warcraft(m.map).run()


if __name__ == '__main__':
    main(parse_arguments())
