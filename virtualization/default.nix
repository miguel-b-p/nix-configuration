{ config, pkgs, ... }:

{
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };
  environment.systemPackages = with pkgs; [
    docker-compose
    (distrobox.overrideAttrs (oldAttrs: {
      postInstall = (oldAttrs.postInstall or "") + ''
        for file in $out/bin/*; do
          sed -i 's|distrobox_path="$(dirname "$(realpath "$0")")"|distrobox_path="/run/current-system/sw/bin"|g' "$file"
          sed -i 's|distrobox_path="$(dirname "$(readlink -f "$0")")"|distrobox_path="/run/current-system/sw/bin"|g' "$file"
        done
      '';
    }))
    podman-compose
  ];
}
