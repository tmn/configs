{ config
, pkgs
, lib
, ...
}: {
  home = {
    sessionPath = [
      (lib.mkIf (pkgs.stdenv.isDarwin && pkgs.stdenv.isAarch64) "/opt/homebrew/bin")
      (lib.mkIf (pkgs.stdenv.isDarwin && pkgs.stdenv.isAarch64) "/opt/homebrew/sbin")

      "$HOME/.local/bin"
      "$HOME/.cargo/bin"
      "$HOME/.nixpkgs/bin"
      "$HOME/.config/emacs/bin"

      ## Move these to darwin specific config
      "/Applications/Emacs.app/Contents/MacOS"
      "/Applications/Emacs.app/Contents/MacOS/bin"
    ];

    sessionVariables = {
      LIBRARY_PATH = ''${lib.makeLibraryPath [pkgs.libiconv]}''${LIBRARY_PATH:+:$LIBRARY_PATH}'';
      EDITOR = "nvim";

      TMPDIR = "/tmp";
    };

    packages = [ ];

    language = {
      base = "en_US.UTF-8";
      ctype = "";
    };

    file = {
      ".npmrc".source = ../rc/.npmrc;
      ".editorconfig".source = ../rc/.editorconfig;
      ".gitignore".source = ../rc/.gitignore;

      ".ssh/config" = {
        source = ../rc/ssh/config;
      };

      ".ssh/config.d" = {
        source = ../rc/ssh/config.d;
        recursive = true;
      };
    };
    #
    stateVersion = "22.05";
  };

  programs = {
    home-manager.enable = true;

    git = {
      enable = true;
      userName = "Tri Nguyen";
      userEmail = "mail@trimn.net";

      aliases = {
        ss = "status";
      };

      # extraConfig = {
      #   user = { };
      # };
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;

      shellAliases = {
        ls = "exa --sort=type"; # ls
        l = "exa -lbF --git  --sort=type"; # list, size, type, git
        ll = "exa -lbGF --git  --sort=type"; # long list
        llm = "exa -lbGd --git --sort=modified"; # long list, modified date sort
        la = "exa -lbhHigUmuSa --sort=type --time-style=long-iso --git --color-scale"; # all list
        lx = "exa -lbhHigUmuSa@ --sort=type  --time-style=long-iso --git --color-scale";
      };

      initExtra =
        ''
          source ${pkgs.git}/share/bash-completion/completions/git-prompt.sh
          setopt PROMPT_SUBST
          PROMPT='%F{135}%n%f at %F{166}%m%f in %F{118}%~%f$(__git_ps1 " (%s)")
          $ '
        '';
    };
  };
}
