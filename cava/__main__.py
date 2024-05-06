import os
import subprocess

from .tools.homebrew import Brew
from .cli import Cli

def main():
    manager = Brew()
    print(f"Name: {manager.name}")
    print(f"Manager: {manager.id}")

    # subprocess.run(["ls", "-l"])

    cli = Cli()

if __name__ == "__main__":
    main()