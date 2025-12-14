{
  pkgs,
  ...
}:
{
  services = {
    desktopManager.pantheon.enable = true;
    xserver.displayManager.lightdm.greeters.pantheon.enable = false;
    xserver.displayManager.lightdm.enable = false;
  };
}
