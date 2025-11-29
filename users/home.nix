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

  home.stateVersion = "25.11";

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;

  imports = [
    # inputs.matugen.homeManagerModules.default
    ./vscode.nix
    ./mangohud.nix
    ./shell/bash.nix
    ./matugen.nix
  ];
}
