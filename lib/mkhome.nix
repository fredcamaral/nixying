{
  inputs,
  outputs,
  system,
  pkgs,
  users,
  username,
  ...
}:
inputs.home-manager.lib.homeManagerConfiguration {
  inherit pkgs;
  modules = [
    ../modules/home/home.nix
    inputs.stylix.homeManagerModules.stylix
    inputs.hyprland.homeManagerModules.default
    inputs.nix-index-database.hmModules.nix-index
  ];
  extraSpecialArgs = {
    inherit inputs outputs username system;
    userConfig = users.${username};
  };
}
