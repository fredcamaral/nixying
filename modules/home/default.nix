{
  inputs,
  username,
  host,
  ...
}: {
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
    ./nvim.nix # neovim editor
    ./packages.nix # other packages
    ./rofi.nix # launcher
    ./scripts/scripts.nix # personal scripts
    ./vscode.nix # vscode
    ./waybar # status bar
    ./xdg-mimes.nix # xdg config
    ./zsh.nix # shell
  ];
}
