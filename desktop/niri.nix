{
  pkgs,
  ...
}:

{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.sysc-greet.enable = false;
  programs.niri.enable = true;
  programs.niri.package = pkgs.niri;
  services.displayManager.sessionPackages = [ pkgs.niri ];
}
