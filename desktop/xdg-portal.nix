{ config, pkgs, ... }:

{
  xdg.portal = with pkgs; {
    enable = true;
    extraPortals = [ xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };
}
