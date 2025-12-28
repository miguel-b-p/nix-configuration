{
  config,
  pkgs,
  inputs,
  ...
}:

{
  # services.haveged.enable = true;

  # services.bpftune.enable = true;

  services.preload-ng = {
    enable = true;
    debug = false;
    usePrecompiled = false;
    settings = {
      # Faster cycles for NVMe responsiveness
      cycle = 15;

      # Memory tuning for 16GB RAM
      memTotal = -5;
      memFree = 70;
      memCached = 10;
      memBuffers = 50;

      # Track smaller files (1MB min)
      minSize = 1000000;

      # More parallelism (Ryzen 5600G)
      processes = 60;

      # No sorting needed for NVMe (no seek penalty)
      sortStrategy = 0;

      # Save state every 30 min
      autoSave = 1800;

      # NixOS-specific paths (Already implemented on preload-ng flake)
      mapPrefix = "/nix/store/;/run/current-system/;/home/mingas/.local/share/;!/";
      exePrefix = "/nix/store/;/run/current-system/;/home/mingas/.local/share/;!/";

      predictionAlgorithm = "VOMM";
    };
  };

  powerManagement.cpuFreqGovernor = "performance";
  services = {
    ananicy = with pkgs; {
      enable = true;
      package = ananicy-cpp;
      rulesProvider = ananicy-rules-cachyos;
    };

    scx = {
      enable = true;
      scheduler = "scx_rusty";
      extraArgs = [
        "--perf"
        "1024"
      ];
    };

    irqbalance.enable = true;

    earlyoom = {
      enable = true;
      freeSwapThreshold = 2;
      freeMemThreshold = 2;
      extraArgs = [
        "-g"
        "--avoid"
        "'^(niri|xwayland-satellite|Xwayland|X|wayland|.+-portal-.+)$'"
      ];
    };
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };

  systemd.coredump.enable = false;
}
