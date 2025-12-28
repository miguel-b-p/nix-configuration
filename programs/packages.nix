{ pkgs, inputs, ... }:
let
  llm-agents-pkgs = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  environment.systemPackages =
    with pkgs;
    with llm-agents-pkgs;
    [
      # Productivity
      anytype

      # Browsers
      (vivaldi.override {
        commandLineArgs = "--password-store=basic";
      })
      chromium

      # chat
      equicord

      # Development
      windsurf
      micro

      # Files
      file-roller

      # Multimedia
      vlc
      loupe
      obs-studio
      obs-studio-plugins.obs-move-transition
      obs-studio-plugins.obs-scene-as-transition

      # Downloads
      motrix
      qbittorrent

      # LLM Agents
      coderabbit-cli
    ];
}
