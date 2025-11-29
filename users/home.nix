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
    inputs.matugen.nixosModules.default
    ../desktop/matugen.nix
    ./vscode.nix
    ./mangohud.nix
    ./shell/bash.nix
  ];
  gtk = {
    enable = true;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk3.extraCss = ''
      @import 'matugen.css';
    '';
    gtk4.extraCss = ''
      @import 'matugen.css';
    '';
  };
}
