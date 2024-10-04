{
  config,
  pkgs,
  username,
  host,
  ...
}: {
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  imports = [
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
  ];
}
