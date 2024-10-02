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
  };
}
