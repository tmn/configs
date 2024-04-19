{ pkgs
, config
, lib
, ...
}:
let
  sshKeys = import ../metadata/ssh.nix;
in
{
  options = { };
  config = {
    users = {
      users = {
        tmn = {
          isNormalUser = true;
          uid = 1000;
          extraGroups = [ "wheel" ];
          openssh.authroizedKeys.keys = sshKeys.main;
          shell = pkgs.zsh;
        };

        tri = {
          isNormalUser = true;
          uid = 501;
          extraGroups = [ "staff" "everyone" "localaccounts" "admin" ];
          openssh.authroizedKeys.keys = sshKeys.main;
          shell = pkgs.zsh;
        };
      };

      groups = { };
    };
  };
}
