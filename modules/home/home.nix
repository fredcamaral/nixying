{
  config,
  pkgs,
  username,
  host,
  ...
}: {
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  imports =
    if (host == "megaman")
    then [./default.desktop.nix]
    else [./default.nix];
}
