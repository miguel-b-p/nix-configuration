{ config, pkgs, ... }:

{
  home.username = "mingas";
  home.homeDirectory = "/home/mingas";

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  imports = [
    ./vscode.nix
    ./mangohud.nix
    ./shell/bash.nix
  ];
}
