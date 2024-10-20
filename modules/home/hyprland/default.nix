{inputs, ...}: {
  imports = [
    ./hyprland.nix
    ./config.nix
    ./hyprlock.nix
    ./variables.nix
    inputs.hyprland.homeManagerModules.default
  ];

  # List of Hyprland specific packages
  environment.systemPackages = with pkgs; [
    gnome-text-editor
    gnome.file-roller # archive manager
    gnome.gnome-calculator
    gnome.nautilus # file manager
    gnome.pomodoro
    gnome.seahorse # keyring manager
    gnome.totem # Video player
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
