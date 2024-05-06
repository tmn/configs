class Package(type):
    def __init__(cls, name, bases, dct):
        # print(f"Test: ${cls}")
        # print(f"Name: ${name}")

        # print(dct)

        if "id" not in dct:
            cls.id = name.lower().replace("_", "-")

        if "name" not in dct:
            cls.name = name

class Homebrew(metaclass=Package):
    id: str

    cli_errors: list[str]
    
    def __init__(self):
        self.cli_errors = []


    

class Brew(Homebrew):   
    def installed(self):
        pass

    def search(self, query: str):
        pass