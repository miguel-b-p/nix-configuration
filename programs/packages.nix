{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # devbox

    anytype

    vivaldi
    chromium
    vesktop

    windsurf

    vlc
    obs-studio
    obs-studio-plugins.obs-move-transition
    obs-studio-plugins.obs-scene-as-transition
    motrix
    qbittorrent

  ];
}
