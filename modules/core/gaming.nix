{pkgs, ...}: {
  # Steam gaming platform configuration
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };
  # Lutris game launcher
  environment.systemPackages = with pkgs; [
    lutris
    wineWowPackages.stable
  ];
}
