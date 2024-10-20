{
  config,
  pkgs,
  username,
  host,
  ...
}: {
  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    stateVersion = "24.05";
  };
  programs.home-manager.enable = true;
  nixpkgs = {
    overlays = [
      outputs.overlays.unstable-packages
    ];

    config = {
      allowUnfree = true;
    };
  };

  imports = [
    ./atuin.nix
    ./bottom.nix
    ./go.nix
    ./gpg.nix
    ./lazygit.nix
    ./spicetify.nix
    ./tmux.nix
    ./zoom.nix
    ./bat.nix # better cat command
    ./btop.nix # resouces monitor
    ./cava.nix # audio visualizer
    ./direnv.nix # unclutter your .profile
    ./fastfetch.nix # fetch tool
    ./fzf.nix # fuzzy finder
    ./git.nix # version control
    ./gnome.nix # gnome apps
    ./hyprland # window manager
    ./kitty.nix # terminal
    ./swaync/swaync.nix # notification deamon
    ./micro.nix # nano replacement
    ./packages.nix # other packages
    ./rofi.nix # launcher
    ./scripts/scripts.nix # personal scripts
    ./vscode.nix # vscode
    ./waybar # status bar
    ./xdg-mimes.nix # xdg config
    ./zsh.nix # shell
    ./stylix.nix # theming
    # ./obs.nix # obs
    # ./kanshi.nix # monitor config
  ];
}
