{
  pkgs,
  config,
  lib,
  ...
}:
{
  programs.kitty = {
    enable = true;
    extraConfig = "include /home/mingas/.config/kitty/themes/noctalia.conf";
  };
}
