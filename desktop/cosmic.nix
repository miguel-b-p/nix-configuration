{
  pkgs,
  ...
}:
{
  services = {
    desktopManager.cosmic = {
      enable = true;
      xwayland.enable = true;
    };
    displayManager.cosmic-greeter.enable = true;
    gnome.gnome-keyring.enable = true;
  };
}
