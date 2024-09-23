{
  pkgs,
  lib,
  ...
}: {
  programs.vscode = {
    enable = true; # Enable Visual Studio Code
    package = pkgs.vscode; # Specify the package to use for VS Code

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
      "extensions.autoUpdate" = false; # This stuff fixes vscode freaking out when theres an update
      "window.titleBarStyle" = "custom"; # needed otherwise vscode crashes, see https://github.com/NixOS/nixpkgs/issues/246509
      "window.menuBarVisibility" = "toggle";
      "editor.fontSize" = 14;
      "material-icon-theme.folders.theme" = "classic";
      "explorer.confirmDragAndDrop" = false;
      "editor.fontLigatures" = true;
      "editor.formatOnType" = true;
      "editor.formatOnPaste" = true; # Enable format on paste
      "workbench.layoutControl.type" = "menu"; # Disable layout control
      "workbench.editor.limit.enabled" = true;
      "files.autoSave" = "onWindowChange";
      "breadcrumbs.enabled" = false;
      "editor.renderControlCharacters" = false;
      "editor.mouseWheelZoom" = true;
    };

    extensions = with pkgs.vscode-extensions;
      [
        ms-vscode-remote.remote-ssh
        github.vscode-pull-request-github
        donjayamanne.githistory
        editorconfig.editorconfig
        golang.go
        rust-lang.rust-analyzer
        ms-azuretools.vscode-docker
        ms-vscode.makefile-tools
        kamadorueda.alejandra
        jnoortheen.nix-ide
        hashicorp.terraform
        davidanson.vscode-markdownlint
        ms-vscode.cpptools-extension-pack
        pkief.material-icon-theme
        oderwat.indent-rainbow
        aaron-bond.better-comments
        mikestead.dotenv
        github.codespaces
        tailscale.vscode-tailscale
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
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
