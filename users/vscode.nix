{
  config,
  pkgs,
  lib,
  ...
}:

{
  # 2. Configuração do VS Code
  programs.vscode = {
    enable = true;

    profiles.default.userSettings = {
      "breadcrumbs.enabled" = true;
      "catppuccin.accentColor" = "lavender";
      "chaliceIcons.showArrows" = true;
      # "chat.editor.fontFamily" = lib.mkForce "DejaVu Sans Mono";
      "chat.editor.fontSize" = 16.0;
      # "debug.console.fontFamily" = lib.mkForce "DejaVu Sans Mono";
      "debug.console.fontSize" = 16.0;
      "editor.codeActionsOnSave" = {
        "source.organizeImports" = "explicit";
      };
      # "editor.fontFamily" =
      #   lib.mkForce "'JetBrainsMono Nerd Font', 'SymbolsNerdFont', 'monospace', monospace";
      "editor.fontLigatures" = true;
      "editor.fontSize" = lib.mkForce 14;
      "editor.formatOnPaste" = true;
      "editor.formatOnSave" = true;
      # "editor.inlayHints.fontFamily" = lib.mkForce "DejaVu Sans Mono";
      "editor.inlineSuggest.enabled" = true;
      # "editor.inlineSuggest.fontFamily" = lib.mkForce "DejaVu Sans Mono";
      "editor.minimap.enabled" = false;
      "editor.minimap.sectionHeaderFontSize" = 10.285714285714286;
      "editor.mouseWheelZoom" = true;
      "editor.renderControlCharacters" = false;
      "editor.scrollbar.horizontal" = "hidden";
      "editor.scrollbar.horizontalScrollbarSize" = 2;
      "editor.scrollbar.vertical" = "hidden";
      "editor.scrollbar.verticalScrollbarSize" = 2;
      "editor.semanticHighlighting.enabled" = true;
      "editor.stickyScroll.enabled" = false;
      "explorer.confirmDragAndDrop" = false;
      "explorer.openEditors.visible" = 0;
      "geminicodeassist.project" = "healthy-life-474920-e5";
      "git.autofetch" = true;
      "git.confirmSync" = false;
      "git.enableSmartCommit" = true;
      "gitlens.hovers.annotations.changes" = false;
      "gitlens.hovers.avatars" = false;
      "gopls" = {
        "ui.semanticTokens" = true;
      };
      # "markdown.preview.fontFamily" = lib.mkForce "DejaVu Sans";
      "markdown.preview.fontSize" = 16.0;
      # "scm.inputFontFamily" = lib.mkForce "DejaVu Sans Mono";
      "scm.inputFontSize" = 14.857142857142858;
      "screencastMode.fontSize" = 64.0;
      "security.workspace.trust.untrustedFiles" = "open";
      "telemetry.enableCrashReporter" = false;
      "telemetry.enableTelemetry" = false;
      # "terminal.integrated.fontFamily" = lib.mkForce "'JetBrainsMono Nerd Font', 'SymbolsNerdFont'";
      "terminal.integrated.fontSize" = lib.mkForce 15;
      "update.mode" = "none";

      # Configurações do VIM
      "vim.handleKeys" = {
        "<C-a>" = false;
        "<C-f>" = true;
      };
      "vim.hlsearch" = true;
      "vim.insertModeKeyBindings" = [
        {
          after = [
            "<Esc>"
            "l"
          ];
          before = [
            "k"
            "j"
          ];
        }
      ];
      "vim.leader" = "<Space>";
      "vim.normalModeKeyBindingsNonRecursive" = [
        {
          before = [ "<S-h>" ];
          commands = [ ":bprevious" ];
        }
        {
          before = [ "<S-l>" ];
          commands = [ ":bnext" ];
        }
        {
          before = [
            "leader"
            "v"
          ];
          commands = [ ":vsplit" ];
        }
        {
          before = [
            "leader"
            "s"
          ];
          commands = [ ":split" ];
        }
        {
          before = [ "<C-h>" ];
          commands = [ "workbench.action.focusLeftGroup" ];
        }
        {
          before = [ "<C-j>" ];
          commands = [ "workbench.action.focusBelowGroup" ];
        }
        {
          before = [ "<C-k>" ];
          commands = [ "workbench.action.focusAboveGroup" ];
        }
        {
          before = [ "<C-l>" ];
          commands = [ "workbench.action.focusRightGroup" ];
        }
        {
          before = [
            "leader"
            "w"
          ];
          commands = [ ":w!" ];
        }
        {
          before = [
            "leader"
            "q"
          ];
          commands = [ ":q!" ];
        }
        {
          before = [
            "leader"
            "x"
          ];
          commands = [ ":x!" ];
        }
        {
          before = [
            "["
            "d"
          ];
          commands = [ "editor.action.marker.prev" ];
        }
        {
          before = [
            "]"
            "d"
          ];
          commands = [ "editor.action.marker.next" ];
        }
        {
          before = [
            "<leader>"
            "c"
            "a"
          ];
          commands = [ "editor.action.quickFix" ];
        }
        {
          before = [
            "<leader>"
            "f"
          ];
          commands = [ "workbench.action.quickOpen" ];
        }
        {
          before = [ "<C-n>" ];
          commands = [ "workbench.action.toggleSidebarVisibility" ];
        }
        {
          before = [
            "<leader>"
            "p"
          ];
          commands = [ "editor.action.formatDocument" ];
        }
        {
          before = [
            "g"
            "h"
          ];
          commands = [ "editor.action.showDefinitionPreviewHover" ];
        }
      ];
      "vim.useCtrlKeys" = true;
      "vim.useSystemClipboard" = true;
      "vim.visualModeKeyBindings" = [
        {
          before = [ "<" ];
          commands = [ "editor.action.outdentLines" ];
        }
        {
          before = [ ">" ];
          commands = [ "editor.action.indentLines" ];
        }
        {
          before = [ "J" ];
          commands = [ "editor.action.moveLinesDownAction" ];
        }
        {
          before = [ "K" ];
          commands = [ "editor.action.moveLinesUpAction" ];
        }
        {
          before = [
            "leader"
            "c"
          ];
          commands = [ "editor.action.commentLine" ];
        }
      ];

      "vsicons.dontShowNewVersionMessage" = true;
      "window.menuBarVisibility" = "classic";
      "window.titleBarStyle" = "custom";
      "window.zoomLevel" = 0.45;
      # "workbench.colorTheme" = "Eva Dark Italic Bold";
      "workbench.editor.limit.enabled" = true;
      "workbench.editor.limit.perEditorGroup" = true;
      "workbench.editor.limit.value" = 10;
      "workbench.iconTheme" = "flow-dim";
      "workbench.layoutControl.enabled" = false;
      "workbench.layoutControl.type" = "menu";
      "workbench.sideBar.location" = "left";
      "workbench.startupEditor" = "none";
      "workbench.tree.indent" = 15;
      "workbench.tree.renderIndentGuides" = "compact";
      "python.terminal.activateEnvironment" = false;
    };
  };
}
