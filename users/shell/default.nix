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
    enableBashIntegration = false;
    enableFishIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = true;
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
    };
  };
}
