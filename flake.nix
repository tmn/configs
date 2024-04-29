{
  description = "Tris configuration";

  inputs = {
    utils.url = "github:numtide/flake-utils";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager-unstable = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    ragenix = {
      url = "github:yaxitech/ragenix";
      inputs."flake-utils".follows = "utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-unstable
    , nixpkgs-master
    , nix-darwin
    , home-manager
    , home-manager-unstable
    , ragenix
    , flake-utils
    , ...
    } @ flakes:
    let
      supportedSystems = [ "x86_64-linux" "x86_64-darwin" "aarch64-darwin" "aarch64-linux" ];
      system = "aarch64-darwin";

      overlays = [
        ragenix.overlays.default
      ];

      commonModules = pkgBase: [
        ragenix.nixosModules.age
        {
          nixpkgs = {
            inherit overlays;
            config.allowUnfree = true;
          };
        }
        {
          nix = {
            nixPath = [ "nixpkgs=${pkgBase}" ];
          };
        }
        {
          system.configurationRevision = self.rev or self.dirtyRev or null;
        }

        ./common
      ];
      pkgs = import nixpkgs { inherit system overlays; };

      darwinInputs = (with pkgs; [
        libiconv
      ]);

      macBox = machine: pkgBase: homeBase:
        pkgBase.lib.darwinSystem {
          system = machine.arch;
          modules =
            (commonModules pkgBase)
            ++ [
              (./. + "/machines/${machine.hostname}")
              homeBase.darwinModules.home-manager
            ];


          specialArgs = {
            inherit flakes;
            inherit machine;
          };
        };

      nixosBox = arch: pkgBase: homeBase: name:
        pkgBase.lib.nixosSystem {
          system = arch;
          modules =
            (commonModules pkgBase)
            ++ [
              (./. + "/machines/${name}")
            ]
            ++ (
              if builtins.isNull homeBase
              then [ ]
              else [
                homeBase.nixosModules.home-manager
                ./common/home.nix
              ]
            );
          specialArgs = {
            inherit flakes;
          };
        };
    in
    {
      nixosConfiguration = {
        "thinkie" = nixosBox "x86_64-linux" nixpkgs home-manager "thinkie";
      };

      darwinConfigurations = {
        # $ darwin-rebuild build --flake .#tequila
        tequila =
          let
            machine = {
              arch = "aarch64-darwin";
              username = "tmn";
              hostname = "tequila";
              homeDir = /Users/tmn;
            };
          in
          macBox machine nix-darwin home-manager;

        dev.wrk =
          let
            machine = {
              arch = "aarch64-darwin";
              username = "tri";
              hostname = "dev.wrk";
              homeDir = /Users/tri;
            };
          in
          macBox machine nix-darwin home-manager;
      };

      devShell = pkgs.mkShell {
        buildInputs = darwinInputs;

        shellAliases = {
          cargo = "${pkgs.cargo}/bin/cargo";
        };

        shellHook = ''
          export LIBRARY_PATH="${pkgs.libiconv}/lib:$LIBRARY_PATH"
        '';
      };

      # Expose the package set, including overlays, for convenience.
      # darwinPackages = self.darwinConfigurations."simple".pkgs;
    };
}
