{
  config,
  pkgs,
  lib,
  ...
}:

{
  boot = {
    # Define o kernel XanMod Latest e aplica o override para x86-64-v3
    kernelPackages = pkgs.linuxPackagesFor (
      pkgs.linuxKernel.kernels.linux_xanmod_latest.override {
        structuredExtraConfig = with lib.kernel; {
          # --- 1. Otimização de CPU (Não é padrão no NixOS) ---
          # Força o uso de instruções AVX/AVX2 modernas.
          CONFIG_X86_64_V3 = yes;

          # --- 2. Latência e Preempção (Restaurar comportamento XanMod) ---
          # O NixOS força "Voluntary" por padrão (bom para servidores), mas mata a
          # responsividade do XanMod. Aqui forçamos o retorno para Full Preempt.
          CONFIG_PREEMPT_VOLUNTARY = no;
          CONFIG_PREEMPT = yes;

          # Garante 500Hz (equilíbrio perfeito do XanMod).
          # O NixOS genérico costuma alterar isso para 300Hz ou 1000Hz.
          CONFIG_HZ = freeform "500";
          CONFIG_HZ_500 = yes;

          # --- 3. Rede (BBR + FQ_PIE por padrão) ---
          # O kernel suporta BBR, mas o NixOS não o ativa por padrão.
          # Isso compila o BBR embutido e o define como padrão sem precisar de sysctl.
          CONFIG_TCP_CONG_BBR = yes;
          CONFIG_DEFAULT_BBR = yes;
          CONFIG_NET_SCH_FQ_PIE = yes;
          CONFIG_DEFAULT_FQ_PIE = yes;

          # --- 4. Limpeza de Overhead (Opcional mas recomendado) ---
          # Desativa debugs que o NixOS costuma deixar ligados e que consomem CPU.
          CONFIG_DEBUG_KERNEL = no;
          CONFIG_SCHED_DEBUG = no;
        };

        ignoreConfigErrors = true;
      }
    );

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
      "amdgpu.ppfeaturemask=0xffffffff"
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
      "kernel.sched_autogroup_enabled" = 0;
      "kernel.sched_migration_cost_ns" = 5000000;
      "kernel.kptr_restrict" = 2;
      "kernel.kexec_load_disabled" = 1;
      "net.core.netdev_max_backlog" = 4096;
      "vm.min_free_kbytes" = 65536;
      "kernel.split_lock_mitigate" = 0;
      "kernel.nmi_watchdog" = 0;
      "net.core.rmem_default" = 31457280;
      "net.core.rmem_max" = 67108864;
      "net.core.wmem_default" = 31457280;
      "net.core.wmem_max" = 67108864;
      "net.core.default_qdisc" = "fq";
      "fs.file-max" = 2097152;
      "fs.nr_open" = 2097152;
      "vm.mmap_rnd_bits" = 32;
      "kernel.sysctl_writes_strict" = 1;
      "kernel.umip_emul" = 0;

      "net.ipv4.tcp_slow_start_after_idle" = 0;
      "net.core.somaxconn" = "4096";

      "net.ipv4.tcp_congestion_control" = "bbr";
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
    };
  };
}
