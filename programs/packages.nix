{ pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    devbox

    anytype

    vivaldi
    chromium
    vesktop
    (discord.override { withVencord = true; })

    windsurf

    vlc
    obs-studio
    obs-studio-plugins.obs-move-transition
    obs-studio-plugins.obs-scene-as-transition

    inputs.flox.packages.${pkgs.system}.default
  ];
}
