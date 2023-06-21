from argparse import ArgumentParser, Namespace
from build.builder import Builder
from build.maps import test_map_settings


if __name__ == '__main__':
    Builder(test_map_settings).create_custom_code()
