{ pkgs
, lib
, ...
}: {
  environment.systemPackages = with pkgs; [
    jdk21
  ];
}
