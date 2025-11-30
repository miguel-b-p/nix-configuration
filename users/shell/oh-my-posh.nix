{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
{

  programs.oh-my-posh = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    useTheme = "1_shell";

    # Opção B: Usar configuração customizada (sobrescreve o useTheme)
    # settings = builtins.fromJSON (builtins.readFile ./meu-tema.json);
  };
}
