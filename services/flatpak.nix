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
      "com.ranfdev.DistroShelf"
      "io.github.N3kosempai.klia-store"
    ];
    update.auto = {
      enable = true;
    };
    update.onActivation = true;
  };

  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub "https://dl.flathub.org/repo/flathub.flatpakrepo"
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
