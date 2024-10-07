{
  pkgs,
  inputs,
  username,
  host,
}:
inputs.home-manager.lib.homeManagerConfiguration {
  inherit pkgs;
  modules = [
    ../modules/home
    inputs.stylix.homeManagerModules.stylix
  ];
  extraSpecialArgs = {
    inherit inputs username host;
  };
}
