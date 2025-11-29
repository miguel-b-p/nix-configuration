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
      "com.ranfdev.DistroShelf"
      "io.github.kolunmi.Bazaar"
    ];
    update.auto = {
      enable = true;
    };
    update.onActivation = true;
  };

  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if ((action.id == "org.freedesktop.Flatpak.app-install" ||
          action.id == "org.freedesktop.Flatpak.app-uninstall" ||
          action.id == "org.freedesktop.Flatpak.runtime-install" ||
          action.id == "org.freedesktop.Flatpak.runtime-uninstall" ||
          action.id == "org.freedesktop.Flatpak.modify-repo") &&
          subject.isInGroup("wheel")) {
        return polkit.Result.YES;
      }
    });
  '';

}
