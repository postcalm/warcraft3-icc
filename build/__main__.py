from argparse import ArgumentParser, Namespace
from build.builder import Builder
from build.maps import test_map_settings

MAPS = (
    "test",
    "lower",
)


def parse_arguments():
    parser = ArgumentParser()
    parser.add_argument("map", choices=MAPS, help="Собираемая карта")
    parser.add_argument("--run", action="store_true", help="Запустить карту в игре")
    parser.add_argument("--edit", action="store_true", help="Запустить карту в редакторе")
    return parser.parse_args()


def main(args: Namespace):
    print(args)
    Builder(test_map_settings).build()


if __name__ == '__main__':
    main(parse_arguments())
