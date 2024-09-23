{
  pkgs,
  lib,
  ...
}: {
  programs.vscode = {
    enable = true; # Enable Visual Studio Code
    package = pkgs.vscode; # Specify the package to use for VS Code
    mutableExtensionsDir = false; # Prevent extensions from being modified

    userSettings = {
      "workbench.startupEditor" = "none"; # Disable startup editor
      "workbench.iconTheme" = "material-icon-theme"; # Set icon theme
      "workbench.tree.indent" = 16; # Set tree indentation
      "workbench.sideBar.location" = "left"; # Set sidebar location
      "terminal.integrated.scrollback" = 10000; # Set terminal scrollback
      "telemetry.telemetryLevel" = "off"; # Disable telemetry
      "remote.SSH.useLocalServer" = false; # SSH configuration
      "editor.formatOnSave" = true; # Enable format on save
      "explorer.confirmDelete" = false; # Disable delete confirmation
      "editor.detectIndentation" = true; # Enable indentation detection
      "editor.minimap.enabled" = false; # Disable minimap
      "cody.commandCodeLenses" = false; # Enable command code lenses
      "editor.inlineSuggest.suppressSuggestions" = true; # Disable inline suggestions
      "update.mode" = "none";
      "extensions.autoUpdate" = false; # This stuff fixes vscode freaking out when theres an update
      "window.titleBarStyle" = "custom"; # needed otherwise vscode crashes, see https://github.com/NixOS/nixpkgs/issues/246509
      "window.menuBarVisibility" = "toggle";
      "editor.fontSize" = 14;
      "material-icon-theme.folders.theme" = "classic";
      "vsicons.dontShowNewVersionMessage" = true;
      "explorer.confirmDragAndDrop" = false;
      "editor.fontLigatures" = true;
      "editor.formatOnType" = true;
      "editor.formatOnPaste" = true;
      "workbench.layoutControl.type" = "menu";
      "workbench.editor.limit.enabled" = true;
      "workbench.editor.limit.value" = 10;
      "workbench.editor.limit.perEditorGroup" = true;
      # "workbench.editor.showTabs" = "single";
      "files.autoSave" = "onWindowChange";
      "explorer.openEditors.visible" = 0;
      "breadcrumbs.enabled" = false;
      "editor.renderControlCharacters" = false;
      "workbench.statusBar.visible" = false;
      "editor.scrollbar.verticalScrollbarSize" = 2;
      "editor.scrollbar.horizontalScrollbarSize" = 2;
      "editor.scrollbar.vertical" = "hidden";
      "editor.scrollbar.horizontal" = "hidden";
      "workbench.layoutControl.enabled" = false;
      "editor.mouseWheelZoom" = true;
    };

    # Extensions to be installed
    extensions = with pkgs.vscode-extensions;
      [
        # Remote development
        ms-vscode-remote.remote-ssh

        # Git integration
        github.vscode-pull-request-github
        # github.copilot
        # github.copilot-chat
        donjayamanne.githistory

        # Code formatting and style
        editorconfig.editorconfig

        # Language support
        golang.go
        rust-lang.rust-analyzer
        ms-azuretools.vscode-docker
        ms-vscode.makefile-tools
        kamadorueda.alejandra
        jnoortheen.nix-ide
        hashicorp.terraform

        # Markdown support
        davidanson.vscode-markdownlint

        # C/C++ support
        ms-vscode.cpptools-extension-pack

        # UI enhancements
        pkief.material-icon-theme
        oderwat.indent-rainbow
        aaron-bond.better-comments

        # Misc tools
        mikestead.dotenv
        github.codespaces
        tailscale.vscode-tailscale
      ]
      # Additional marketplace extensions
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "todo-tree";
          publisher = "Gruntfuggly";
          version = "0.0.215";
          sha256 = "sha256-WK9J6TvmMCLoqeKWh5FVp1mNAXPWVmRvi/iFuLWMylM=";
        }
        {
          name = "vscode-thunder-client";
          publisher = "rangav";
          version = "2.24.12";
          sha256 = "sha256-lt06g+3VIN67OVnW+/mPmCxGJQq/MHoKI9Kagw4qp4k=";
        }
        {
          name = "cody-ai";
          publisher = "sourcegraph";
          version = "1.28.0";
          sha256 = "sha256-Tn2Hii60CUMC40Ntw5sSsD5uKOsjgTQusQsCa8/LrwM=";
        }
        {
          name = "vscode-postgresql";
          publisher = "ms-ossdata";
          version = "0.3.0";
          sha256 = "sha256-k6aUXuFMzALampcFVTWrW3xp0E+LgN4Jtv4qHbYuVws=";
        }
      ];
  };
}
