{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
{
  imports = [
    ./rules.nix
    ./binds.nix
    ./noctalia.nix
    ./niri.nix
    ./theme
  ];

  home.packages = with pkgs; [
    quickshell
    xwayland-satellite
    adw-gtk3
    qt6Packages.qt6ct
    nwg-look
    matugen
  ];
}
