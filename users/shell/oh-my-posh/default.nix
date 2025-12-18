{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
{

  programs.oh-my-posh = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    settings = builtins.fromJSON (builtins.readFile ./theme.json);
  };
}
