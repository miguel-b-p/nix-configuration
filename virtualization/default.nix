{ config, pkgs, ... }:

{
  services.qemuGuest.enable = true;
  programs.virt-manager.enable = true;

  virtualisation = {
    spiceUSBRedirection.enable = true;
    libvirtd.enable = true;
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
    qemu
  ];
}
