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

      # === Gerenciamento de Memória e Cache (Virtual Memory - vm) ===

      # Controla a tendência do kernel de recuperar a memória usada para cache de diretórios e inodes.
      # Valor padrão é 100.
      # Impacto: Com 50, o kernel prefere manter informações do sistema de arquivos (inodes/dentries) em cache
      # por mais tempo, o que pode melhorar a performance em sistemas com muitos arquivos pequenos,
      # reduzindo leituras de disco.
      "vm.vfs_cache_pressure" = 50;

      # Define a quantidade de memória (em bytes) que pode estar "suja" (dados modificados na RAM mas ainda não gravados no disco)
      # antes que um processo seja forçado a gravar os dados ele mesmo (bloqueando a aplicação).
      # Impacto: Define um limite rígido de cerca de 256 MB. Isso evita que o sistema acumule gigabytes de dados sujos
      # que travariam o sistema por muito tempo durante a gravação (buffer bloat). Melhora a responsividade.
      "vm.dirty_bytes" = 268435456;

      # Controla o número de páginas lidas do disco de uma só vez durante o swap (pré-busca).
      # Impacto: O valor '0' desativa o agrupamento (read-ahead) de swap. Isso reduz a latência em situações
      # onde o acesso à memória é aleatório e não sequencial, ideal para ambientes de baixa latência.
      "vm.page-cluster" = 0;

      # Define o limite de bytes sujos a partir do qual o processo de background do kernel (pdflush/kworker)
      # começa a gravar dados no disco de forma assíncrona.
      # Impacto: Configurado para ~64 MB. Garante que a gravação comece cedo, em segundo plano,
      # evitando atingir o limite rígido ("vm.dirty_bytes") e prevenindo picos de I/O.
      "vm.dirty_background_bytes" = 67108864;

      # Define o intervalo (em centésimos de segundo) para acordar as threads de gravação em segundo plano.
      # Impacto: 1500 significa 15 segundos. Dados sujos podem ficar na RAM por até 15s antes do kernel
      # verificar se precisam ser gravados. Aumenta a eficiência da bateria e reduz a atividade do disco,
      # mas aumenta o risco de perda de dados em caso de queda de energia.
      "vm.dirty_writeback_centisecs" = 1500;

      # Quantidade mínima de memória (em KB) que o kernel mantém reservada para uso emergencial (atomic allocations).
      # Impacto: 64 MB reservados. Isso é crucial sob alta carga de rede ou disco para evitar travamentos diretos
      # (direct reclaim) quando a memória acaba, garantindo que o kernel sempre tenha espaço para buffers de rede.
      "vm.min_free_kbytes" = 65536;

      # Número de bits aleatórios adicionados ao endereço de mapeamento de memória (ASLR).
      # Impacto: 32 bits. Aumenta a entropia do ASLR, dificultando ataques de segurança que tentam
      # prever onde bibliotecas e o heap estão carregados na memória.
      "vm.mmap_rnd_bits" = 32;

      # === Escalonamento e Processamento (Kernel Scheduler/CPU) ===

      # Ativa ou desativa o agrupamento automático de tarefas por sessão TTY (terminal).
      # Impacto: '0' desativa. Isso é geralmente preferível para servidores ou sistemas onde o "fairness" (justiça)
      # deve ser por processo e não por sessão de usuário. Pode melhorar a latência de serviços em background.
      "kernel.sched_autogroup_enabled" = 0;

      # Tempo (em nanosegundos) que uma tarefa deve rodar antes de ser considerada para migração para outra CPU.
      # Impacto: 5ms (5000000ns). Um valor mais alto reduz a "trepidação" (bouncing) de processos entre núcleos,
      # preservando o cache da CPU (L1/L2), mas pode reduzir levemente a responsividade imediata.
      "kernel.sched_migration_cost_ns" = 5000000;

      # Controla como o kernel lida com "split locks" (bloqueios que cruzam linhas de cache) em CPUs x86.
      # Impacto: '0' significa apenas avisar (warn), sem penalizar o processo drasticamente.
      # Split locks degradam performance severamente; essa config evita matar o processo, optando por manter o sistema rodando.
      "kernel.split_lock_mitigate" = 0;

      # Watchdog para detectar travamentos duros (hard lockups) via interrupções não mascaráveis.
      # Impacto: '0' desativa o watchdog. Isso economiza um pouco de ciclos de CPU e interrupções,
      # útil em sistemas de tempo real ou para jogos, mas o sistema não reiniciará automaticamente se a CPU travar completamente.
      "kernel.nmi_watchdog" = 0;

      # Emulação de instruções User Mode Instruction Prevention (UMIP).
      # Impacto: '0' desativa a emulação se o hardware suportar UMIP nativamente ou se não for desejada.
      # Previne que certas instruções de sistema (como SGDT) sejam chamadas em user space.
      "kernel.umip_emul" = 0;

      # === Segurança do Kernel ===

      # Restringe a exposição de endereços de ponteiros do kernel (ex: em /proc/kallsyms).
      # Impacto: Nível 2 oculta completamente os símbolos do kernel para usuários sem CAP_SYSLOG.
      # Dificulta a exploração de vulnerabilidades do kernel por atacantes locais.
      "kernel.kptr_restrict" = 2;

      # Controla a capacidade de carregar um novo kernel em tempo de execução (kexec).
      # Impacto: '1' desabilita o carregamento de novos kernels via kexec. Isso impede que um atacante
      # substitua o kernel em execução por um malicioso sem reiniciar a máquina fisicamente (Cold Boot).
      "kernel.kexec_load_disabled" = 1;

      # Controla como as gravações no sysctl são tratadas.
      # Impacto: '1' impõe verificações estritas. Se você tentar escrever em um sysctl numa posição do arquivo que não seja 0, falha.
      "kernel.sysctl_writes_strict" = 1;

      # === Rede e Buffers (Networking Core) ===

      # Tamanho máximo da fila de pacotes recebidos (backlog) quando a interface recebe pacotes mais rápido que o kernel processa.
      # Impacto: Aumentado para 4096. Ajuda a prevenir perda de pacotes em surtos de tráfego (bursts) de alta velocidade.
      "net.core.netdev_max_backlog" = 4096;

      # Tamanhos padrão e máximo (em bytes) para buffers de leitura (rmem) e escrita (wmem) de sockets.
      # Impacto: Valores muito altos (~30MB padrão, ~64MB max).
      # Permite janelas TCP gigantescas, essenciais para conexões de altíssima velocidade (10Gbps+) e alta latência (Long Fat Networks).
      "net.core.rmem_default" = 31457280;
      "net.core.rmem_max" = 67108864;
      "net.core.wmem_default" = 31457280;
      "net.core.wmem_max" = 67108864;

      # Algoritmo de enfileiramento de pacotes (Queueing Discipline).
      # Impacto: "fq" (Fair Queueing) é um pré-requisito para usar o algoritmo de controle de congestionamento BBR.
      # Ele garante um ritmo de envio suave dos pacotes.
      "net.core.default_qdisc" = "fq";

      # Máximo de conexões pendentes na fila de escuta (listen queue) de um socket.
      # Impacto: 4096. Permite que servidores (como Nginx/Apache) lidem com um grande pico inicial de novas conexões simultâneas.
      "net.core.somaxconn" = "4096";

      # === Limites do Sistema de Arquivos (File System) ===

      # Número máximo global de arquivos abertos (file handles) no sistema inteiro.
      # Impacto: ~2 milhões. Evita o erro "Too many open files" em servidores com carga muito alta.
      "fs.file-max" = 2097152;

      # Limite máximo de arquivos abertos por um único processo.
      # Impacto: Igualado ao global (~2 milhões). Permite que aplicações pesadas (bancos de dados, servidores web) usem muitos arquivos.
      "fs.nr_open" = 2097152;

      # === Protocolo TCP/IPv4 (Otimização de Conexão) ===

      # Comportamento do TCP após um período de inatividade (idle).
      # Impacto: '0' impede que a conexão volte ao modo "slow start" após ficar ociosa.
      # Mantém a velocidade alta imediatamente após uma pausa, excelente para conexões HTTP persistentes (keep-alive).
      "net.ipv4.tcp_slow_start_after_idle" = 0;

      # Algoritmo de controle de congestionamento.
      # Impacto: "bbr" (Google's Bottleneck Bandwidth and RTT). Otimiza a largura de banda e reduz a latência,
      # lidando muito melhor com perda de pacotes do que o padrão "CUBIC". Requer 'fq' como qdisc.
      "net.ipv4.tcp_congestion_control" = "bbr";

      # Limites de memória (em páginas de 4KB) para o stack TCP e UDP.
      # Formato: "min pressure max".
      # Impacto: Valores ajustados para permitir maior uso de memória para conexões de rede antes do kernel começar a restringir (pressure).
      "net.ipv4.tcp_mem" = "65536 131072 262144";
      "net.ipv4.udp_mem" = "65536 131072 262144";

      # Ajuste fino dos buffers de leitura (rmem) e escrita (wmem) especificamente para TCP.
      # Formato: "min default max".
      # Impacto: O 'max' está em ~32MB. Permite transferências muito rápidas, mas consome muita RAM por conexão ativa se ela usar toda a banda.
      "net.ipv4.tcp_rmem" = "4096 87380 33554432";
      "net.ipv4.tcp_wmem" = "4096 87380 33554432";

      # Mínimo de buffer para sockets UDP.
      # Impacto: 16KB. Garante um mínimo razoável para tráfego UDP (DNS, Jogos, QUIC) não ser descartado agressivamente.
      "net.ipv4.udp_rmem_min" = 16384;
      "net.ipv4.udp_wmem_min" = 16384;

      # Máximo de sockets em estado TIME_WAIT permitidos.
      # Impacto: Aumentado para 1.4 milhões. Protege contra ataques DoS simples, permitindo que o sistema rastreie muitas conexões fechando.
      "net.ipv4.tcp_max_tw_buckets" = 1440000;

      # Permite reutilizar sockets em estado TIME_WAIT para novas conexões.
      # Impacto: '1' (ativado). Útil em servidores web com muitas conexões de curta duração, evitando exaurir as portas locais disponíveis.
      "net.ipv4.tcp_tw_reuse" = 1;

      # Máximo de sockets TCP orfãos (não atrelados a nenhum file handle do usuário).
      # Impacto: 400 mil. Previne que o sistema consuma toda a RAM com conexões que foram fechadas incorretamente.
      "net.ipv4.tcp_max_orphans" = 400000;

      # Ativa o escalonamento da janela TCP (RFC 1323).
      # Impacto: '1' (ativado). Obrigatório para atingir velocidades altas em conexões com buffers maiores que 64KB (praticamente toda a internet moderna).
      "net.ipv4.tcp_window_scaling" = 1;

      # Adiciona timestamps aos pacotes TCP.
      # Impacto: '1' (ativado). Permite medição precisa de RTT (Round Trip Time) e proteção contra PAWS (Wrapped Sequence Numbers). Necessário para alta performance.
      "net.ipv4.tcp_timestamps" = 1;

      # Ativa Selective Acknowledgements (SACK).
      # Impacto: '1' (ativado). Se um pacote se perde num grupo, retransmite apenas o perdido, não o grupo todo. Melhora muito a performance em redes com perda.
      "net.ipv4.tcp_sack" = 1;

      # Tempo para manter socket em estado FIN-WAIT-2.
      # Impacto: Reduzido para 10 segundos (padrão é 60). Libera recursos de conexões fechadas "pela metade" mais rapidamente.
      "net.ipv4.tcp_fin_timeout" = 10;

      # Configurações de Keepalive (para detectar conexões mortas).
      # Impacto: Começa a verificar após 600s (10 min), envia sondas a cada 60s, tenta 10 vezes.
      # O padrão do Linux é 2 horas (7200s). Isso detecta quedas de conexão muito mais rápido, liberando recursos.
      "net.ipv4.tcp_keepalive_time" = 600;
      "net.ipv4.tcp_keepalive_intvl" = 60;
      "net.ipv4.tcp_keepalive_probes" = 10;

      #Teste
      "vm.max_map_count" = 2147483642;
      "kernel.sched_cfs_bandwidth_slice_us" = 3000;
    };
  };
  systemd.tmpfiles.rules = [
    "w /sys/kernel/debug/sched/latency_ns - - - - 3000000"
    "w /sys/kernel/debug/sched/min_granularity_ns - - - - 300000"
    "w /sys/kernel/debug/sched/wakeup_granularity_ns - - - - 500000"
    "w /sys/kernel/debug/sched/nr_migrate - - - - 128"
  ];
}
