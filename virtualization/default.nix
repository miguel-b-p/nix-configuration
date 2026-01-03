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
          sed -i -E 's|distrobox_path=.*|distrobox_path="/run/current-system/sw/bin"|g' "$file"
        done
      '';
    }))
    podman-compose
  ];
}
