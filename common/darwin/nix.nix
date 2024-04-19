{ pkgs
, ...
}: {
  services.nix-daemon.enable = true;
  programs.zsh.enable = true;

  nix = { };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  system.stateVersion = 4;
}
