{
  pkgs,
  inputs,
  outputs,
  users,
  username,
  host,
}:
inputs.home-manager.lib.homeManagerConfiguration {
  inherit pkgs;
  modules = [
    ../modules/home/home.nix
    inputs.stylix.homeManagerModules.stylix
  ];
  extraSpecialArgs = {
    inherit inputs outputs username host;
    userConfig = users.${username};
  };
}
