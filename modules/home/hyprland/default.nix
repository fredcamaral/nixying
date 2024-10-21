{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hyprland.nix
    ./config.nix
    ./hyprlock.nix
    ./variables.nix
  ];

  # List of Hyprland specific packages
  home.packages = with pkgs; [
    gnome-text-editor
    file-roller # archive manager
    gnome-calculator
    nautilus # file manager
    gnome-pomodoro
    seahorse # keyring manager
    totem # Video player
    loupe # image viewer

    brightnessctl
    grim
    hypridle
    hyprlock
    hyprpaper
    hyprpicker
    libnotify
    networkmanagerapplet
    pamixer
    pavucontrol
    slurp
    swappy
    tesseract
    wf-recorder
    wlr-randr
    wlsunset
  ];
}
