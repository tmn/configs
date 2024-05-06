import argparse

class Cli:
    parser = None

    def __init__(self) -> None:
        self.parser = argparse.ArgumentParser(description="Cava Package Manager")
        # self.parser.add_argument("<cmd>", type=str)
        # self.parser.add_argument("-i", "--install")

        subparser = self.parser.add_subparsers(help="Install package")
        parser_install = subparser.add_parser("install")
        parser_install.add_argument("pkg")

        self.parser.parse_args(["install", "i"])

        self.parser.parse_args() 
