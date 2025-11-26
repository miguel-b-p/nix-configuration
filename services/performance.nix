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
      # scx existe no nixpkg
      # package = pkgs.scx_git.full;
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

  systemd.tmpfiles.rules = [
    # Configuração para o THP Shrinker (Kernel 6.12+)
    # Grava o valor 409 em max_ptes_none para otimizar o split de Hugepages
    "w! /sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_none - - - - 409"
    "w! /sys/kernel/mm/transparent_hugepage/defrag - - - - defer+madvise"
  ];

  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };
}
