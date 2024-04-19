{ pkgs
, config
, machine
, lib
, stdenv
, flakes
, ...
}:
let
  sshKeys = import ../../metadata/ssh.nix;
in
{
  # ...
  imports = [
    ../../common/darwin.nix
    ../../pkgs/system.nix

    ../../pkgs/java.nix
    ../../pkgs/homebrew.nix
    ../../pkgs/node.nix
  ];

  age.identityPaths = [ "/Users/${machine.username}/.ssh/id_ed25519" ];

  nix = {
    settings = {
      trusted-users = [ machine.username ];
    };
  };

  nixpkgs = {
    hostPlatform = machine.arch;
  };

  users.users.tmn = {
    name = machine.username;
    home = machine.homeDir;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users."${machine.username}" = {
      imports = [ ../../home ];

      home.file = {
        ".ssh/authorized_keys".text = lib.concatStringsSep "\n" (sshKeys.main);
      };
    };
  };

  networking = {
    hostName = machine.hostname;
    computerName = machine.hostname;
    localHostName = machine.hostname;
  };
}
