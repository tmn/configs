{ config
, lib
, flakes
, pkgs
, ...
}: {
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
