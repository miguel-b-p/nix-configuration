{ pkgs, ... }:
{
  # Habilita o servidor gráfico (necessário para o gerenciador de login, mesmo em Wayland)
  services.xserver.enable = true;

  # Habilita o ambiente Budgie
  services.xserver.desktopManager.budgie.enable = true;

  # Recomendado: Habilita um Display Manager (GDM ou LightDM)
  services.xserver.displayManager.lightdm.enable = true;
  # ou para GDM (que tem bom suporte a Wayland):
  # services.xserver.displayManager.gdm.enable = true;
  environment.budgie.excludePackages = with pkgs; [
    mate.mate-terminal
    vlc
  ];

}
