{
  nix-flatpak,
  config,
  pkgs,
  ...
}:
{
  services.flatpak = {
    enable = true;
    packages = [
      "io.github.thetumultuousunicornofdarkness.cpu-x"
      "org.upscayl.Upscayl"
      "org.vinegarhq.Sober"
    ];
    update.auto = {
      enable = true;
      onCalendar = "daily";
    };
  };

  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
}
