{
  inputs,
  outputs,
  system,
  pkgs,
  users,
  username,
  hostname,
  ...
}:
inputs.home-manager.lib.homeManagerConfiguration {
  inherit pkgs;
  modules = [
    ../modules/home/home.nix
    inputs.stylix.homeManagerModules.stylix
    inputs.hyprland.homeManagerModules.default
    inputs.nix-index-database.hmModules.nix-index
    inputs.nixvim.homeManagerModules.nixvim

    ../modules/home/host-specifics/${hostname}.nix
  ];
  extraSpecialArgs = {
    inherit inputs outputs username system;
    userConfig = users.${username};
  };
}
