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
    ./nushell.nix
    ./oh-my-posh
  ];

  programs.zoxide = {
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = true;
    enableNushellIntegration = true;
  };

  programs.atuin = {
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = true;
    enableNushellIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = true;
    enableNushellIntegration = true;
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
