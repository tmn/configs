_: {
  homebrew = {
    enable = true;

    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };

    taps = [ ];

    brews = [
      "editorconfig"
      "markdown"

      # Needed for exa
      "libgit2"

      # Needed for current compiled Emacs - should switch to nix
      "dbus"
      "gnutls"
      "imagemagick@6"
      "jansson"
      "libgccjit"
      "libjpeg-turbo"
      "librsvg"
      "tree-sitter"
      "webp"
      "yt-dlp"
    ];

    casks = [
      "alacritty"
      "1password"
      "visual-studio-code"
      "vlc"
      "signal"
      "vivaldi"
      "discord"
      "zed"
    ];

    masApps = {
      "1Password for Safari" = 1569813296;
      "Keynote" = 409183694;
      "Messenger" = 1480068668;
      "Numbers" = 409203825;
      "Pages" = 409201541;
      "Photomator" = 1444636541;
      "Pixelmator Pro" = 1289583905;
      "SnippetsLab" = 1006087419;
      "Tailscale" = 1475387142;
      "Things 3" = 904280696;
    };
  };
}
