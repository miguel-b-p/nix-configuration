{
  config,
  pkgs,
  lib,
  ...
}:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_cachyos-lts;
    # kernelPackages =
    #   let
    #     zenVersion = "6.17.9";
    #     zenSuffix = "zen1";

    #     # Em vez de fazer override no linux_zen, construímos um novo kernel
    #     # usando a função base 'buildLinux'. Isso garante que o structuredExtraConfig seja lido.
    #     customZenKernel = pkgs.buildLinux {
    #       version = "${zenVersion}-${zenSuffix}";
    #       modDirVersion = "${zenVersion}-${zenSuffix}";

    #       src = pkgs.fetchFromGitHub {
    #         owner = "zen-kernel";
    #         repo = "zen-kernel";
    #         rev = "v${zenVersion}-${zenSuffix}";
    #         sha256 = "sha256-OHzYW/uJMPrPkYjXtzfVi8U/5CLsdNxo+zouNYWGNXc=";
    #       };

    #       # Herdamos os patches do kernel Zen original do seu Nixpkgs
    #       # para manter as otimizações e funcionalidades específicas do Zen.
    #       kernelPatches = pkgs.linux_zen.kernelPatches or [ ];

    #       # Agora sim, passado diretamente para o buildLinux, isso funcionará.
    #       structuredExtraConfig = with lib.kernel; {

    #         # --- 1. Otimizações de CPU ---
    #         CONFIG_X86_64_V3 = yes;
    #         CONFIG_GENERIC_CPU_DEVICES = no;
    #         CONFIG_ZEN_INTERACTIVE = yes;

    #         # --- 2. Latência e Preempção ---
    #         CONFIG_PREEMPT_VOLUNTARY = no;
    #         CONFIG_PREEMPT = yes;

    #         # --- HZ Settings ---
    #         CONFIG_HZ = freeform "1000";
    #         CONFIG_HZ_1000 = yes;
    #         CONFIG_HZ_250 = no; # Força desativar o padrão para evitar conflitos

    #         # --- 3. Rede (BBR + FQ_PIE) ---
    #         CONFIG_TCP_CONG_BBR = yes;
    #         CONFIG_DEFAULT_BBR = yes;
    #         CONFIG_NET_SCH_FQ_PIE = yes;
    #         CONFIG_DEFAULT_FQ_PIE = yes;

    #         # --- 4. Limpeza de Overhead ---
    #         CONFIG_DEBUG_KERNEL = no;
    #         CONFIG_SCHED_DEBUG = no;
    #       };

    #       # Se houver erro de opção não usada, mude para true temporariamente para debugar
    #       ignoreConfigErrors = true;
    #     };
    #   in
    #   pkgs.linuxPackagesFor customZenKernel;

    # Seus módulos
    kernelModules = [
      "tcp_bbr"
      "nouveau"
      "kvm-amd"
    ];

    # Seus parâmetros de boot
    kernelParams = [
      "mitigations=off"
      "nowatchdog"
      "transparent_hugepage=always"
      "processor.ignore_ppc=1"
      "ec_sys.write_support=1"
      "kvm.enable_virt_at_load=0"
      "scsi_mod.use_blk_mq=1"
      "elevator=noop"
      "quiet"
      "splash"
      "preempt=full"
    ];

    # Seus ajustes de Sysctl
    kernel.sysctl = {
      "vm.vfs_cache_pressure" = 50;
      "vm.dirty_bytes" = 268435456;
      "vm.page-cluster" = 0;
      "vm.dirty_background_bytes" = 67108864;
      "vm.dirty_writeback_centisecs" = 1500;
      "vm.min_free_kbytes" = 162423;
      "vm.mmap_rnd_bits" = 32;
      "vm.max_map_count" = 2147483642;

      "kernel.sched_autogroup_enabled" = 0;
      "kernel.sched_migration_cost_ns" = 5000000;
      "kernel.split_lock_mitigate" = 0;
      "kernel.nmi_watchdog" = 0;
      "kernel.umip_emul" = 0;
      "kernel.unprivileged_userns_clone" = 1;
      "kernel.kptr_restrict" = 2;
      "kernel.sysctl_writes_strict" = 1;

      "net.core.netdev_max_backlog" = 4096;
      "net.core.rmem_default" = 31457280;
      "net.core.rmem_max" = 67108864;
      "net.core.wmem_default" = 31457280;
      "net.core.wmem_max" = 67108864;
      "net.core.default_qdisc" = "fq";
      "net.core.somaxconn" = "4096";

      "fs.file-max" = 2097152;
      "fs.nr_open" = 2097152;

      "net.ipv4.tcp_slow_start_after_idle" = 0;
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.ipv6.conf.all.use_tempaddr" = 2;
      "net.ipv4.tcp_mtu_probing" = 1;
      "net.ipv4.tcp_mem" = "65536 131072 262144";
      "net.ipv4.udp_mem" = "65536 131072 262144";
      "net.ipv4.tcp_rmem" = "4096 87380 33554432";
      "net.ipv4.tcp_wmem" = "4096 87380 33554432";
      "net.ipv4.udp_rmem_min" = 16384;
      "net.ipv4.udp_wmem_min" = 16384;
      "net.ipv4.tcp_max_tw_buckets" = 1440000;
      "net.ipv4.tcp_tw_reuse" = 1;
      "net.ipv4.tcp_max_orphans" = 400000;
      "net.ipv4.tcp_window_scaling" = 1;
      "net.ipv4.tcp_timestamps" = 1;
      "net.ipv4.tcp_sack" = 1;
      "net.ipv4.tcp_fin_timeout" = 10;
      "net.ipv4.tcp_keepalive_time" = 600;
      "net.ipv4.tcp_keepalive_intvl" = 60;
      "net.ipv4.tcp_keepalive_probes" = 10;

      "fs.inotify.max_user_instances" = 8192;
      "fs.inotify.max_user_watches" = 524288;
    };
  };

  systemd.tmpfiles.rules = [
    "w! /sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_none - - - - 409"
    "w! /sys/kernel/mm/transparent_hugepage/defrag - - - - defer+madvise"
  ];
}
