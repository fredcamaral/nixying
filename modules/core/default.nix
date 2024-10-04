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
    ./fonts.nix
    ./hardware.nix
    # ./xserver.nix
    ./network.nix
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
    ./secrets
  ];
}
