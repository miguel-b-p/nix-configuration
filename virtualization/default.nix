{ config, pkgs, ... }:

{
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    # docker = {
    #   enable = true;
    # };
  };
  environment.systemPackages = with pkgs; [
    docker-compose
    distrobox
    podman-compose
  ];
}
