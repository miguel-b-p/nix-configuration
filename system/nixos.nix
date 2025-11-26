{
  config,
  pkgs,
  inputs,
  ...
}:

{
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    auto-optimise-store = true;
    max-jobs = "auto";
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    dates = "daily";
    allowReboot = false;
  };

  systemd.services.nixos-flake-update = {
    description = "Update NixOS flake inputs";
    serviceConfig = {
      Type = "oneshot";
      User = "root";
      WorkingDirectory = "/etc/nixos";
      ExecStart = "${pkgs.nixVersions.stable}/bin/nix flake update";
    };
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
  };

  systemd.timers.nixos-flake-update = {
    description = "Daily NixOS flake update timer";
    wantedBy = [ "timers.target" ];

    timerConfig = {
      OnCalendar = "daily";
      OnBootSec = "15min";
      Persistent = true;
      RandomizedDelaySec = "1h";
    };
  };

  systemd.coredump.enable = false;

  nix.settings.trusted-substituters = [ "https://cache.flox.dev" ];
  nix.settings.trusted-public-keys = [
    "flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs="
  ];
}
