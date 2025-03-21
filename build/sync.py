# Copyright meiso
#
"""
Скрипт для синхронизации изменений между картами.
Копирует ключевые файлы из одной карты в другую.
"""
import shutil
from argparse import ArgumentParser, Namespace, SUPPRESS
from pathlib import Path


FILES = {
    "w3a": "war3map.w3a",
    "w3h": "war3map.w3h",
    "w3u": "war3map.w3u",
    "wtg": "war3map.wtg",
    "w3t": "war3map.w3t",
    "wct": "war3map.wct",
    "wts": "war3map.wts",
    "misc": "war3mapMisc.txt",
}


def parse_args() -> Namespace:
    parser = ArgumentParser(add_help=False)
    parser.add_argument("from_", help="Откуда копировать")
    parser.add_argument("to_", help="Куда копировать")
    parser.add_argument("-a", dest="w3a", action="store_true", help="Скопировать способности")
    parser.add_argument("-h", dest="w3h", action="store_true", help="Скопировать бафы")
    parser.add_argument("-u", dest="w3u", action="store_true", help="Скопировать юнитов")
    parser.add_argument("-tg", dest="wtg", action="store_true", help="Скопировать триггеры")
    parser.add_argument("-t", dest="w3t", action="store_true", help="Скопировать предметы")
    parser.add_argument("-ct", dest="wct", action="store_true", help="Скопировать нестандартный код и текстовые триггеры")
    parser.add_argument("-ts", dest="wts", action="store_true", help="Скопировать строки")
    parser.add_argument("-misc", dest="misc", action="store_true", help="Скопировать константы")
    parser.add_argument("--help", action="help", default=SUPPRESS, help="Показать помощь о скрипте и выйти")
    return parser.parse_args()


def copy_file_map(from_: str, to_: str, file: str) -> None:
    f = FILES[file]
    shutil.copy(Path(from_, f), Path(to_, f))
    print("Copied", f)


def main(args: Namespace) -> None:
    print("From", args.from_, "into", args.to_)
    if args.w3a:
        copy_file_map(args.from_, args.to_, "w3a")
    if args.w3h:
        copy_file_map(args.from_, args.to_, "w3h")
    if args.w3u:
        copy_file_map(args.from_, args.to_, "w3u")
    if args.wtg:
        copy_file_map(args.from_, args.to_, "wtg")
    if args.w3t:
        copy_file_map(args.from_, args.to_, "w3t")
    if args.wct:
        copy_file_map(args.from_, args.to_, "wct")
    if args.wts:
        copy_file_map(args.from_, args.to_, "wts")
    if args.misc:
        copy_file_map(args.from_, args.to_, "misc")
    print("Nothing copied")


if __name__ == "__main__":
    main(parse_args())
