{
  config,
  pkgs,
  inputs,
  ...
}:

{
  # Importa o módulo do Home Manager do flake input
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  users.users.mingas = {
    isNormalUser = true;
    description = "usuario mingas";
    extraGroups = [
      "networkmanager"
      "wheel"
      "podman"
      "openrazer"
      "docker"
      "libvirtd"
      "kvm"
      "ydotool"
      "audio"
      "video"
      "disk"
      "input"
    ];

    # Pacotes podem ser movidos para o home.nix se preferir, mas podem ficar aqui também
    packages = with pkgs; [ ];
  };

  # Configuração do Home Manager
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users.mingas = import ./home.nix; # Aponta para o novo arquivo
  };
}
