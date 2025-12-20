{ pkgs, ... }:
{
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common = {
        default = [
          "gnome"
        ];
        "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
      };
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
    ];
  };
}
