import json
from pathlib import Path

from py.translator.translators.terrain import TerrainTranslator
from py.translator.war3reader import War3Reader

# первые 4 байта - id - W3E!
# 5 байт - версия карты (11)
# _TEST_FILE_MAP = Path(r"E:\Warcraft III\Maps\warcraft3-icc\Test.w3x\war3map.w3e")
_TEST_FILE_MAP = Path(r"../test/data/war3map_11.w3e")
# _TEST_FILE_MAP = Path(r"E:\Warcraft III\Maps\warcraft3-icc\LowerTier.w3x\war3map.w3e")


def main():
    translator = TerrainTranslator()
    data = translator.war2json(_TEST_FILE_MAP.read_bytes())
    # expected = json.loads(Path(r"..\test\data\terrain.json").read_text())
    Path("terrain.json").write_text(json.dumps(data, indent=2))
    print()


if __name__ == "__main__":
    main()
