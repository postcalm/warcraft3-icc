import shutil
import os
from pathlib import Path
from build.settings import PROJECT_DIR

test_map = PROJECT_DIR / "Test.w3x"
release_map = PROJECT_DIR / "ICC.w3x"

skip_files = (
    "template.fdf",
    "readme.html",
)

spell_icons = (
    "icons/paladin",
    "icons/priest",
)
other_icons = (
    "icons/classes",
)
model_files = (
    "frames",
    "models/creatures/Paladin",
    "models/creatures/Priest",
    "models/spells/Paladin",
)


def copy_files(src: Path, dst: Path, prefix_filename: str = ""):
    for f in os.listdir(src):
        if f in skip_files:
            continue
        if Path(src / f).is_dir():  # noqa
            copy_files(src / f, dst, prefix_filename)  # noqa
        else:
            shutil.copy(src / f, dst / f"{prefix_filename}{f}")  # noqa


def copy_spell_icons(src: Path, dst: Path):
    cmdbtn = dst / "ReplaceableTextures" / "CommandButtons"
    cmddisbtn = dst / "ReplaceableTextures" / "CommandButtonsDisabled"
    copy_files(src, cmdbtn, "BTN")
    copy_files(src, cmddisbtn, "DISBTN")


def copy():
    for si in spell_icons:
        print(f"Copying {si} to a test map ...")
        copy_spell_icons(Path(si), test_map)
    print("Success\n")

    for oi in other_icons:
        print(f"Copying {oi} to a test map ...")
        copy_files(Path(oi), test_map / "ReplaceableTextures" / "icons")
    print("Success\n")

    for mf in model_files:
        print(f"Copying {mf} to a test map ...")
        copy_files(Path(mf), test_map)
    print("Success\n")
