{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # Essential GNOME Packages
    gnome.gnome-shell
    gnome.gnome-terminal
    gnome.nautilus
    gnome.gnome-control-center
    gnome.gedit
    gnome-tweaks

    # Additional tools and utilities
    gnome.gnome-keyring
    gnome.dconf-editor
    gnome.gnome-software # For software installation

    # Important ThinkPad/Hardware-specific packages
    tlp # Power management for ThinkPads
    thinkfan # ThinkPad fan control
    powertop # Power optimization tool
    intel-media-va-driver # Intel GPU acceleration

    # Network & Bluetooth tools
    networkmanager
    bluez
    bluez-utils
  ];

  # Enable GNOME services
  services.gnome = {
    enable = true;
    gdm.enable = true;
    gnome-keyring.enable = true;
  };

  # Configure TLP for ThinkPad
  services.tlp.enable = true;

  # Miscellaneous settings
  xdg.enable = true; # Ensure XDG environment variables are set
  xsession.enable = true; # Enable X11 session

  # GNOME configurations
  home.sessionVariables = {
    XDG_SESSION_TYPE = "wayland"; # You can switch to "x11" if you prefer.
    MOZ_ENABLE_WAYLAND = "1"; # Enable Wayland for Firefox.
  };

  # Bluetooth setup
  services.blueman.enable = true; # Bluetooth manager for GNOME
}
