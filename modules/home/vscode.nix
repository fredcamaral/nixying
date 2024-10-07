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
      "remote.SSH.useLocalServer" = false; # SSH configuratio
      "editor.formatOnSave" = true; # Enable format on save
      "explorer.confirmDelete" = false; # Disable delete confirmation
      "editor.detectIndentation" = true; # Enable indentation detection
      "editor.minimap.enabled" = false; # Disable minimap
      "cody.commandCodeLenses" = false; # Enable command code lenses
      "extensions.autoUpdate" = true; # This stuff fixes vscode freaking out when theres an update
      "window.titleBarStyle" = "custom"; # needed otherwise vscode crashes, see https://github.com/NixOS/nixpkgs/issues/246509
      "window.menuBarVisibility" = "toggle"; # Disable menu bar
      "editor.fontSize" = 16; # Set editor font size
      "material-icon-theme.folders.theme" = "classic"; # Set folder icon theme
      "explorer.confirmDragAndDrop" = false; # Disable drag and drop confirmation
      "editor.fontLigatures" = true; # Enable font ligatures
      "editor.formatOnType" = true; # Enable format on type
      "editor.formatOnPaste" = true; # Enable format on paste
      "workbench.layoutControl.type" = "menu"; # Disable layout control
      "workbench.editor.limit.enabled" = true; # Enable editor limit
      "files.autoSave" = "onWindowChange"; # Enable auto save
      "breadcrumbs.enabled" = true; # Enable breadcrumbs
      "editor.renderControlCharacters" = false; # Disable control characters
      "editor.mouseWheelZoom" = true; # Enable mouse wheel zoom
      "editor.inlineSuggest.suppressSuggestions" = true; # Enable inline suggestions
      "cody.chat.defaultLocation" = "editor"; #  Enable chat in editor
      "makefile.configureOnOpen" = true;
    };

    extensions = with pkgs.vscode-extensions;
      [
        ms-vscode-remote.remote-ssh # SSH
        github.vscode-pull-request-github # GitHub Pull Requests
        donjayamanne.githistory # Git History
        editorconfig.editorconfig # EditorConfig
        golang.go # Go
        rust-lang.rust-analyzer # Rust
        ms-azuretools.vscode-docker # Docker
        ms-vscode.makefile-tools # Makefile
        kamadorueda.alejandra # Nix
        jnoortheen.nix-ide # Nix
        hashicorp.terraform # Terraform
        davidanson.vscode-markdownlint # Markdown Lint
        ms-vscode.cpptools-extension-pack # C/C++
        pkief.material-icon-theme # Material Icon Theme
        oderwat.indent-rainbow # Indent Rainbow
        aaron-bond.better-comments # Better Comments
        mikestead.dotenv # Dotenv
        github.codespaces # Codespaces
        tailscale.vscode-tailscale # Tailscale
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "cody-ai";
          publisher = "sourcegraph";
          version = "1.34.3";
          sha256 = "sha256-bIrkeZi/rgCRae2+CuAg+iPdd/0jp4VO3ufV4VlXhzs=";
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
