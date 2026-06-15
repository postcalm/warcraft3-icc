# Copyright meiso
#
import os
import shutil
from pathlib import Path

from build.settings import PROJECT_DIR

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
    "models/creatures/heroes/Paladin",
    "models/creatures/heroes/Priest",
    "models/creatures/heroes/spirithealer",
    "models/creatures/heroes/sylvanas",
    "models/creatures/heroes/jaina",
    "models/creatures/lower tier/Lord Marrowgar",
    "models/creatures/lower tier/Lady Deathwhisper",
    "models/creatures/lower tier/bonegolem",
    "models/creatures/lower tier/nerubiancaster",
    "models/creatures/lower tier/nerubianpriest",
    "models/creatures/lower tier/coldwraith",
    "models/creatures/lower tier/ancientskeletal",
    "models/creatures/lower tier/DeathspeakerAttendant",
    "models/creatures/lower tier/CultFanatic",
    "models/creatures/lower tier/DeathboundWard",
    "models/spells/Paladin",
    "models/spells/Lady Deathwisper",
    "models/spells/Bone Spike Graveyard",
)
ui_files = (
    "frames",
)


def copy_files(
        src: Path,
        dst: Path,
        prefix_filename: str = "",
        recursive: bool = True,
) -> None:
    print(f"Copy {src} to {dst} as '{prefix_filename}'")
    os.makedirs(dst, exist_ok=True)
    for f in os.listdir(src):
        if f in skip_files:
            continue
        if Path(src / f).is_dir():
            if recursive:
                copy_files(src / f, dst, prefix_filename)
            else:
                shutil.copytree(src / f, dst / f, dirs_exist_ok=True)
        else:
            shutil.copy(src / f, dst / f"{prefix_filename}{f}")


def copy_spell_icons(src: Path, dst: Path):
    cmdbtn = dst / "ReplaceableTextures" / "CommandButtons"
    cmddisbtn = dst / "ReplaceableTextures" / "CommandButtonsDisabled"
    copy_files(src, cmdbtn, "BTN")
    copy_files(src, cmddisbtn, "DISBTN")


def copy(target_map: str):
    p = PROJECT_DIR / target_map
    for si in spell_icons:
        print(f"Copying {si} to a {target_map} map ...")
        copy_spell_icons(Path(si), p)
    print("Success\n")

    for oi in other_icons:
        print(f"Copying {oi} to a {target_map} map ...")
        copy_files(Path(oi), p / "ReplaceableTextures" / "icons")
    print("Success\n")

    for mf in model_files:
        print(f"Copying {mf} to a {target_map} map ...")
        copy_files(Path(mf), p, recursive=False)

    for ui in ui_files:
        print(f"Copying {ui} to a {target_map} map ...")
        shutil.copytree(Path(ui), p, dirs_exist_ok=True)
    print("Success\n")
