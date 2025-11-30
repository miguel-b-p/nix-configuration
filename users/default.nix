{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  users.users.mingas = {
    isNormalUser = true;
    description = "mingas";
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
    ignoreShellProgramCheck = true;
    shell = pkgs.fish; # Configured in shell/fish.nix
  };
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = false;
    useUserPackages = true;
    backupFileExtension = "backup";
    users.mingas = import ./home.nix; # Aponta para o novo arquivo
  };
}
