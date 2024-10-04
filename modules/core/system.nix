{
  self,
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  nix = {
    settings = {
      auto-optimise-store = true;
      warn-dirty = false;
      experimental-features = ["nix-command" "flakes"];
    };
  };

  environment.systemPackages = with pkgs; [
    wget
    git
  ];

  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "en_US.UTF-8";
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.05";
}
