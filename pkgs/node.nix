{ pkgs
, lib
, ...
}: {
  environment.systemPackages = with pkgs; [
    nodejs_20

    nodePackages.js-beautify
    nodePackages.prettier
    nodePackages.pyright
    nodePackages.stylelint
  ];
}
