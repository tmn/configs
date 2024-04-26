{ pkgs 
, config 
, machine
, lib
, stdenv
, flakes
, ... }: 
let 
  sshKeys = import ../../metadata/ssh.nix;
in 
{
  imports = [
    ../../pkgs/system.nix
  ];

  security.sudo.extraRules = [
    {
      users = ["tmn"];
    }
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users.tmn = {
      imports = [../../home];

      home.file = {
        ".config/i3" = {
          source = ../rc/i3;
          recursive = true;
        };
      };
    };
  };

  networking = {
    hostName = machine.hostname;
    computerName = machine.hostname;
    localHostName = machine.hostname;

    # interfaces = {
    #   "enp2s0" = {
    #     useDHCP = true;
    #   };

    #   "wlp3s0" = {
    #     useDHCP = true;
    #   };
    # };
  };
}
