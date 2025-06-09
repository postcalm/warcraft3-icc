# Copyright meiso
#
import shutil
from pathlib import Path

from build.builder import BuildCounter
from build.settings import MAP_FOLDER, PROJECT_DIR, RELEASE_FOLDER


def prepare_release(map_name):
    RELEASE_FOLDER.mkdir(exist_ok=True)
    set_full_version(map_name)


def set_full_version(map_name):
    print("Setting full version...")
    counter = BuildCounter().current()
    version = (PROJECT_DIR / "version").open().read().strip()
    name = Path(map_name).stem
    ext = Path(map_name).suffix
    full_version = f"{version}.{counter}"
    new_name = f"{name}-{full_version}{ext}"
    print("New name:", new_name)
    shutil.copy(MAP_FOLDER / map_name, RELEASE_FOLDER / new_name)
    print("Success")
