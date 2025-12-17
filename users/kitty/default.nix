{
  pkgs,
  config,
  lib,
  ...
}:
{
  programs.kitty = {
    enable = true;
    extraConfig = "include ${config.home.homeDirectory}/.config/kitty/colors.conf";
  };
}
