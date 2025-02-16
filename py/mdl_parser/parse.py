# Copyright meiso
#
from argparse import ArgumentParser, Namespace

from py.mdl_parser.mdl import Mdl


def parse_args() -> Namespace:
    parser = ArgumentParser()
    parser.add_argument("model", help="Path to model")
    parser.add_argument("--save", "-s", help="Save with new file name")
    parser.add_argument("--merge", "-m", help="Merge with other model")
    return parser.parse_args()


def main(args: Namespace) -> None:
    mdl = Mdl(args.model)
    if args.merge:
        old = Mdl(args.merge)
        new = mdl.merge(old)
        if args.save:
            new.save(args.save)


if __name__ == "__main__":
    main(parse_args())
