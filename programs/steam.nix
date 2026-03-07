{ config, pkgs, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;

    package = pkgs.steam.override {
      extraPkgs =
        pkgs: with pkgs; [
          gamemode
          dbus
        ];
    };
    extraCompatPackages = with pkgs; [
      proton-cachyos
      proton-cachyos-x86_64-v2
      proton-cachyos-x86_64-v3
      proton-cachyos-x86_64-v4
    ];
  };

  programs.gamemode.enable = true;
  programs.gamescope = {
    enable = true;
    capSysNice = false;
  };

  environment.systemPackages = with pkgs; [
    gamescope-wsi
  ];
}
