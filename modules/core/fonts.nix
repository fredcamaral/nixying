{pkgs, ...}: let
  monolisa = pkgs.callPackage ../../pkgs/monolisa/monolisa.nix {};
  monolisa-nerd = pkgs.callPackage ../../pkgs/monolisa/monolisa-nerd.nix {inherit monolisa;};
in {
  fonts = {
    enableDefaultPackages = true;
    fontconfig.enable = true;
    packages = with pkgs; [
      monolisa
      monolisa-nerd
      cascadia-code # monospace - "Cascadia Code"
      dejavu_fonts # sans-serif, serif, monospace - "DejaVu Sans", "DejaVu Serif", "DejaVu Sans Mono"
      fira # sans-serif - "Fira Sans"
      fira-code # monospace - "Fira Code"
      fira-code-symbols # monospace - "Fira Code"
      fira-mono # monospace - "Fira Mono"
      inter # sans-serif - "Inter"
      jetbrains-mono # monospace - "JetBrains Mono"
      nerdfonts # various monospace fonts
      raleway # sans-serif - "Raleway"
      roboto # sans-serif - "Roboto"
      roboto-mono # monospace - "Roboto Mono"
      (nerdfonts.override {
        fonts = [
          "JetBrainsMono"
          "FiraCode"
          "RobotoMono"
          "DejaVuSansMono"
        ];
      })
    ];
  };
}
