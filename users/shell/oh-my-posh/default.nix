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
    settings = builtins.fromJSON (builtins.readFile ./theme.json);
  };
}
