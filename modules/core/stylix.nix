# system/modules/stylix.nix
{pkgs, ...}: let
  monolisa = pkgs.callPackage ../../pkgs/monolisa/monolisa.nix {};
  monolisa-nerd = pkgs.callPackage ../../pkgs/monolisa/monolisa-nerd.nix {inherit monolisa;};
in {
  stylix = {
    # Enable Stylix for system-wide theming
    enable = true;

    # Set the wallpaper image
    image = ../../wallpapers/minimalist-fluid.png;

    # Set the theme polarity (dark or light)
    polarity = "dark";

    base16Scheme = "${pkgs.base16-schemes}/share/themes/blueforest.yaml";

    # Configure cursor theme
    cursor = {
      name = "Vimix-Cursors-White";
      package = pkgs.vimix-cursor-theme;
      size = 42;
    };

    # Configure system fonts
    fonts = {
      serif = {
        package = pkgs.inter;
        name = "Inter";
      };

      sansSerif = {
        package = pkgs.inter;
        name = "Inter";
      };

      monospace = {
        package = monolisa-nerd;
        name = "MonoLisa Nerd Font";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };

      # Set font sizes for different contexts
      sizes = {
        applications = 10;
        desktop = 10;
        popups = 10;
        terminal = 10;
      };
    };

    # Set opacity levels for different contexts
    opacity = {
      applications = 0.95;
      desktop = 0.85;
      popups = 0.75;
      terminal = 0.75;
    };
  };
}
