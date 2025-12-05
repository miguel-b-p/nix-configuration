{ config, pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      preload = final.callPackage ./preload { };
    })
  ];
  # services.auto-cpufreq = {
  #   enable = true;
  #   settings = {
  #     charger = {
  #       governor = "performance";
  #       turbo = "auto";
  #     };
  #   };
  # };
  services.haveged.enable = true;

  services.power-profiles-daemon.enable = false;
  services = {
    system76-scheduler.settings.processScheduler.enable = true;
    system76-scheduler.settings.cfsProfiles.enable = true;
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

  systemd.services.preload = {
    description = "Adaptive readahead daemon";
    wantedBy = [ "multi-user.target" ];
    after = [ "local-fs.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.preload}/sbin/preload -f";
      Type = "simple";
    };
  };
}
