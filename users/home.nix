{
  config,
  pkgs,
  inputs,
  ...
}:

{
  home.username = "mingas";
  home.homeDirectory = "/home/mingas";

  home.stateVersion = "25.11";

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;

  imports = [
    inputs.stylix.homeModules.stylix
    ./vscode.nix
    ./mangohud.nix
    ./stylix.nix
    ./shell/bash.nix
  ];
}
