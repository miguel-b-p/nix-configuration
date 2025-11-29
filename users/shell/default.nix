{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
{
  imports = [
    ./bash.nix
    ./fish.nix
    ./nh.nix
    ./starship.nix
  ];

  programs.atuin = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };

  home = {
    shellAliases = {
      # utils
      ll = "ls -l";

      # distrobox
      fedora-dev = "distrobox enter fedora-dev";

      # nh
      sysup = "nh os switch -u";
      rebuild = "nh os switch";
      sysclean = "nh clean all";
    };
    sessionVariables = {
      NH_FLAKE = "/home/mingas/nix-configuration";
    };
  };
}
