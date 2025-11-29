{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    # shellAliases = {
    #   ll = "ls -l";
    #   fedora-dev = "distrobox enter fedora-dev";

    #   sysup = "nh os switch -u";
    #   rebuild = "nh os switch";
    #   sysclean = "nh clean all";
    # };
    # initExtra = ''
    #   # Outras configurações manuais
    #   export NH_FLAKE="/home/mingas/nix-configuration"
    #   # eval "$(${pkgs.starship}/bin/starship init bash)"
    #   # [[ $- == *i* ]] && source -- "$(blesh-share)"/ble.sh --attach=none
    #   # # clear
    #   # [[ ! ''${BLE_VERSION-} ]] || ble-attach
    # '';
  };
}
