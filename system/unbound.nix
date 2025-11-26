{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.unbound = {
    enable = true;
    settings = {
      server = {
        # Configurações de Interface e Acesso
        interface = [
          "127.0.0.1"
          "::1"
        ];
        port = 53;
        access-control = [
          "127.0.0.1/32 allow"
          "::1/128 allow"
        ];

        # Configurações de Performance - Threads e Cores
        num-threads = 4;
        so-reuseport = true;
        so-rcvbuf = "8m";
        so-sndbuf = "8m";

        # Configurações de Cache - Super Otimizado
        msg-cache-size = "256m";
        msg-cache-slabs = 8;
        rrset-cache-size = "512m";
        rrset-cache-slabs = 8;
        key-cache-size = "128m";
        key-cache-slabs = 8;
        neg-cache-size = "32m";

        # Configurações de TTL Otimizadas
        cache-min-ttl = 3600;
        cache-max-ttl = 86400;
        cache-max-negative-ttl = 3600;

        # Configurações de Prefetch (Melhora Performance)
        prefetch = true;
        prefetch-key = true;
        serve-expired = true;
        serve-expired-ttl = 86400;
        serve-expired-ttl-reset = true;
        serve-expired-reply-ttl = 30;
        serve-expired-client-timeout = 1800;

        # Configurações de Rede Otimizadas
        outgoing-range = 8192;
        num-queries-per-thread = 4096;
        outgoing-num-tcp = 256;
        incoming-num-tcp = 256;

        # Configurações de UDP
        msg-buffer-size = 65552;
        max-udp-size = 4096;

        # Configurações de Segurança e Performance
        hide-identity = true;
        hide-version = true;
        hide-trustanchor = true;
        harden-glue = true;
        harden-dnssec-stripped = true;
        harden-below-nxdomain = true;
        harden-referral-path = true;
        harden-algo-downgrade = true;
        use-caps-for-id = false;

        # DNSSEC - Desabilitado para máxima performance
        val-clean-additional = false;
        val-permissive-mode = true;

        # Configurações de Timeout Otimizadas - REMOVIDAS OPÇÕES INVÁLIDAS
        infra-host-ttl = 900;
        infra-cache-slabs = 8;
        infra-cache-numhosts = 10000;

        # Configurações de Performance Avançadas
        minimal-responses = true;
        rrset-roundrobin = true;
        unwanted-reply-threshold = 10000;
        do-not-query-localhost = false;

        # Configurações de Log (desabilitado para performance)
        verbosity = 0;
        use-syslog = false;

        # Configurações de TCP Keep-Alive
        tcp-upstream = true;
        tcp-mss = 1460;
        outgoing-tcp-mss = 1460;

        # Configurações de Rate Limiting
        ip-ratelimit = 1000;
        ratelimit = 1000;

        # Configurações de Edns
        edns-buffer-size = 1232;
      };

      # Configuração de Forward Zone com DNS over TLS para Cloudflare
      forward-zone = [
        {
          name = ".";
          forward-tls-upstream = false;
          forward-addr = [
            "1.1.1.1@53#cloudflare.com"
            "1.0.0.1@53#cloudflare.com"
          ];
          forward-first = false;
        }
      ];

      # Configuração de Controle Remoto
      remote-control = {
        control-enable = true;
        control-interface = "127.0.0.1";
        control-port = 8953;
        control-use-cert = false;
      };
    };
  };

  # Configuração de Rede para usar o DNS local
  networking = {
    nameservers = [
      "127.0.0.1"
      "::1"
    ];
    resolvconf.useLocalResolver = true;
    networkmanager.dns = "none";

    # Configurações de firewall
    firewall = {
      allowedTCPPorts = [ 53 ];
      allowedUDPPorts = [ 53 ];
    };
  };

  # Desabilita systemd-resolved para evitar conflitos
  services.resolved.enable = false;

  # Configuração NSS corrigida
  system.nssModules = lib.mkForce [ ];
  system.nssDatabases.hosts = lib.mkForce [
    "files"
    "dns"
  ];

  # Configuração Avahi corrigida
  services.avahi = {
    enable = false;
    nssmdns4 = false;
  };
}
