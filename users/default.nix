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
      "docker"
      "libvirtd"
      "kvm"
      "ydotool"
      "audio"
      "video"
      "disk"
      "input"
    ];
    # Subuid and subgid ranges for user namespaces, fixes distrobox
    subUidRanges = [
      {
        startUid = 100000;
        count = 65536;
      }
    ];
    subGidRanges = [
      {
        startGid = 100000;
        count = 65536;
      }
    ];
    ignoreShellProgramCheck = true;
    # shell = pkgs.fish; # Configured in shell/fish.nix
    shell = pkgs.nushell;
  };
  users.defaultUserShell = pkgs.nushell;

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = false;
    useUserPackages = true;
    backupFileExtension = "backup";
    users.mingas = import ./home.nix; # Aponta para o novo arquivo
  };
}
