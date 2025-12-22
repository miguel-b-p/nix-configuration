{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  home.username = "mingas";
  home.homeDirectory = "/home/mingas";

  home.stateVersion = "26.05";

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;

  imports = [
    ./vscode.nix
    ./mangohud.nix
    ./mime.nix
    ./nh.nix
    ./niri
    ./shell
    ./ghostty
  ];
}
