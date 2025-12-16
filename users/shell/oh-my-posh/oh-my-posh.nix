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
    # useTheme = "1_shell";
    settings = builtins.fromJSON (builtins.readFile ./theme.json);
  };
}
