{pkgs, ...}: let
  monolisa = pkgs.callPackage ../../pkgs/monolisa/monolisa.nix {};
  monolisa-nerd = pkgs.callPackage ../../pkgs/monolisa/monolisa-nerd.nix {inherit monolisa;};
in {
  fonts = {
    enableDefaultPackages = true;
    fontconfig = {
      enable = true;
      antialias = true;
      hinting.enable = true;
      hinting.style = "full";
      defaultFonts = {
        monospace = [
          "JetBrainsMono Nerd Font"
          "FiraCode Nerd Font"
          "Hack Nerd Font"
          "SauceCodePro Nerd Font"
          "Inconsolata Nerd Font"
          "Iosevka Nerd Font"
          "UbuntuMono Nerd Font"
          "DroidSansMono Nerd Font"
          "RobotoMono Nerd Font"
          "DejaVuSansMono Nerd Font"
          "LiberationMono Nerd Font"
        ];
        sansSerif = [
          "Inter Nerd Font"
          "NotoSans Nerd Font"
          "DejaVuSans Nerd Font"
        ];
        serif = [
          "NotoSerif Nerd Font"
          "DejaVuSerif Nerd Font"
        ];
      };
    };
    packages = with pkgs; [
      monolisa
      monolisa-nerd
      alegreya # serif - "Alegreya"
      alice # serif - "Alice"
      amiri # serif - "Amiri"
      asap # sans-serif - "Asap"
      barlow # sans-serif - "Barlow"
      cabin # sans-serif - "Cabin"
      caladea # serif - "Caladea"
      cantarell-fonts # sans-serif - "Cantarell"
      carlito # sans-serif - "Carlito"
      cascadia-code # monospace - "Cascadia Code"
      comfortaa # sans-serif - "Comfortaa"
      courier-prime # monospace - "Courier Prime"
      crimson-pro # serif - "Crimson Pro"
      dancing-script # script - "Dancing Script"
      dejavu_fonts # sans-serif, serif, monospace - "DejaVu Sans", "DejaVu Serif", "DejaVu Sans Mono"
      dosis # sans-serif - "Dosis"
      eb-garamond # serif - "EB Garamond"
      encode-sans # sans-serif - "Encode Sans"
      fira # sans-serif - "Fira Sans"
      fira-code # monospace - "Fira Code"
      fira-code-symbols # monospace - "Fira Code"
      fira-mono # monospace - "Fira Mono"
      font-awesome # icon font - "Font Awesome"
      gentium-book-basic # serif - "Gentium Book Basic"
      go-font # sans-serif, monospace - "Go", "Go Mono"
      hack-font # monospace - "Hack"
      hackgen-font # monospace - "HackGen"
      hasklig # monospace - "Hasklig"
      ibm-plex # sans-serif, serif, monospace - "IBM Plex Sans", "IBM Plex Serif", "IBM Plex Mono"
      inconsolata # monospace - "Inconsolata"
      inter # sans-serif - "Inter"
      iosevka # monospace - "Iosevka"
      jetbrains-mono # monospace - "JetBrains Mono"
      lato # sans-serif - "Lato"
      liberation-sans-narrow # sans-serif - "Liberation Sans Narrow"
      liberation_ttf # sans-serif, serif, monospace - "Liberation Sans", "Liberation Serif", "Liberation Mono"
      libre-baskerville # serif - "Libre Baskerville"
      libre-franklin # sans-serif - "Libre Franklin"
      libertinus # serif - "Libertinus Serif"
      manrope # sans-serif - "Manrope"
      material-icons # icon font - "Material Icons"
      merriweather # serif - "Merriweather"
      mona-sans # sans-serif - "Mona Sans"
      montserrat # sans-serif - "Montserrat"
      nerdfonts # various monospace fonts
      noto-fonts # various sans-serif and serif - "Noto Sans", "Noto Serif"
      noto-fonts-cjk # Chinese, Japanese, Korean fonts - "Noto Sans CJK", "Noto Serif CJK"
      noto-fonts-emoji # emoji font - "Noto Color Emoji"
      open-sans # sans-serif - "Open Sans"
      overpass # sans-serif - "Overpass"
      oxygen # sans-serif - "Oxygen"
      pecita # script font - "Pecita"
      poppins # sans-serif - "Poppins"
      quicksand # sans-serif - "Quicksand"
      raleway # sans-serif - "Raleway"
      recursive # sans-serif, monospace - "Recursive"
      roboto # sans-serif - "Roboto"
      roboto-mono # monospace - "Roboto Mono"
      roboto-serif # serif - "Roboto Serif"
      roboto-slab # slab-serif - "Roboto Slab"
      rubik # sans-serif - "Rubik"
      source-code-pro # monospace - "Source Code Pro"
      source-sans # sans-serif - "Source Sans 3"
      source-sans-pro # sans-serif - "Source Sans Pro"
      source-serif # serif - "Source Serif 4"
      source-serif-pro # serif - "Source Serif Pro"
      spectral # serif - "Spectral"
      twitter-color-emoji # emoji font - "Twitter Color Emoji"
      unicode-emoji # emoji font
      vollkorn # serif - "Vollkorn"
      work-sans # sans-serif - "Work Sans"
      zilla-slab # slab-serif - "Zilla Slab"
      (nerdfonts.override {
        fonts = [
          "JetBrainsMono"
          "FiraCode"
          "Hack"
          "SourceCodePro"
          "Inconsolata"
          "Iosevka"
          "UbuntuMono"
          "DroidSansMono"
          "RobotoMono"
          "DejaVuSansMono"
          "LiberationMono"
        ];
      })
    ];
  };
}
