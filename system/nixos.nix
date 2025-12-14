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
    trusted-users = [
      "root"
      "@wheel"
    ];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  systemd.coredump.enable = false;
}
