# Copyright meiso
#
from argparse import ArgumentParser, Namespace

from py.mdl_parser.mdl import Mdl


def parse_args() -> Namespace:
    parser = ArgumentParser()
    parser.add_argument("model", help="Path to model")
    return parser.parse_args()


def main(args: Namespace) -> None:
    mdl = Mdl(args.model)


if __name__ == "__main__":
    main(parse_args())
