{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      wl-clipboard
      unzip
      python3
      nodejs
      gcc
      gnumake
    ];
    plugins = [
      {
        plugin = pkgs.vimPlugins.nvchad;
      }
    ];
  };
  xdg.configFile.nvim = {
    source = pkgs.vimPlugins.nvchad.src;
    recursive = true;
  };
  home.file.nvchad_custom = {
    enable = true;
    source = ./nvchad_custom;
    recursive = true;
    target = ".config/nvim/lua/custom";
  };
}
