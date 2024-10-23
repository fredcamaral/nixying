{
  inputs,
  nixpkgs,
  self,
  username,
  host,
  ...
}: {
  imports = [
    ./bootloader.nix
    ./gaming.nix
    ./ollama.nix
    ./i18n.nix
    ./settings.nix
    ./fonts.nix
    ./hardware.nix
    ./network.nix
    ./console.nix
    ./nh.nix
    ./packages.nix
    ./pipewire.nix
    ./program.nix
    ./security.nix
    ./services.nix
    ./stylix.nix
    ./system.nix
    ./user.nix
    ./wayland.nix
    ./virtualization.nix
    ./settings.nix
    ./nixvim.nix
    # ./secrets
  ];
}
