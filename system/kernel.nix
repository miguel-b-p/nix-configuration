{
  config,
  pkgs,
  lib,
  ...
}:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod;

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
      "vm.dirty_ratio" = 5;
      "vm.dirty_background_ratio" = 10;

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
