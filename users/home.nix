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

  home.packages = with pkgs; [
    xwayland-satellite
  ];

  imports = [
    ./vscode.nix
    ./mangohud.nix
    ./niri
    ./shell
    ./quickshell
  ];
}
