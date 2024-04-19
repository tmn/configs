{ pkgs
, lib
, ...
}: {
  environment.systemPackages = with pkgs;
    [
      # Nix stuff
      nixpkgs-fmt
      nixfmt

      ## Rust stuff
      ## Change to external cargo/rustup?
      cargo
      rustc
      rustfmt
      clippy
      bat
      ripgrep

      # Other stuff
      ansible
      coreutils
      csharpier
      fd
      git
      glslang
      gnupg
      gomodifytags
      gopls
      gotests
      imagemagick
      isort
      ktlint
      libiconv
      mosh
      pipenv
      shellcheck
      shfmt
      tmux
      tree-sitter
      wget
      zsh
      zsh-autosuggestions

      cmake
      gcc12
      libgccjit

      neovim
      tig

      (
        let
          my-python-packages = python-packages:
            with python-packages; [
              black
              nose
              nose2
              pyflakes
              pytest
              requests
              setuptools
            ];
          python-with-my-packages = python3.withPackages my-python-packages;
        in
        python-with-my-packages
      )
    ];
}
