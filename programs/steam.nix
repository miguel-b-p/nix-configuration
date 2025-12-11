{ config, pkgs, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  programs.gamemode.enable = true;
  programs.gamescope = {
    enable = true;
    capSysNice = false;
  };
  environment.systemPackages = with pkgs; [
    gamescope-wsi # HDR won't work without this
  ];
}
