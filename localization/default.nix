{ pkgs, ... }:
{
  # ========================================
  # Localization Configuration
  # ========================================

  # Timezone
  time.timeZone = "America/Sao_Paulo";

  # Locale settings
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocales = [
      "en_US.UTF-8/UTF-8"
      "pt_BR.UTF-8/UTF-8"
    ];
    inputMethod = {
      enable = false;
    };
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
      LC_CTYPE = "en_US.UTF-8";
    };
  };

  # Console keymap
  console.keyMap = "br-abnt2";

  # X11 keyboard configuration
  services.xserver = {
    exportConfiguration = true;
    xkb = {
      layout = "br";
      variant = "abnt2";
      options = "srvrkeys:none";
    };
    excludePackages = [ pkgs.xterm ];
  };
}
