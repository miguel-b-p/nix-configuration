{ config, pkgs, ... }:

{
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "performance";
  };
  services = {
    ananicy = with pkgs; {
      enable = true;
      package = ananicy-cpp;
      rulesProvider = ananicy-rules-cachyos;
    };

    scx = {
      enable = true;
      scheduler = "scx_lavd";
      extraArgs = [ "--performance" ];
    };

    preload.enable = true;

    irqbalance.enable = true;

    earlyoom = {
      enable = true;
      freeSwapThreshold = 2;
      freeMemThreshold = 2;
      extraArgs = [
        "-g"
        "--avoid"
        "'^(X|plasma.*|konsole|kwin|wayland|gnome.*)$'"
      ];
    };
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };
}
