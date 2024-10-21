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
  ];
  extraSpecialArgs = {
    inherit inputs outputs username;
    userConfig = users.${username};
  };
}
