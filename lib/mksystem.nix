{
  system,
  pkgs,
  inputs,
  outputs,
  users,
  username,
  hostModule,
  extraModules ? [],
  ...
}:
inputs.nixpkgs.lib.nixosSystem {
  inherit system;
  modules =
    [
      hostModule
      inputs.stylix.nixosModules.stylix
      inputs.agenix.nixosModules.default
      inputs.nixvim.nixosModules.nixvim
      inputs.home-manager.nixosModules.home-manager
    ]
    ++ extraModules;
  specialArgs = {
    inherit inputs outputs username;
    host = builtins.baseNameOf hostModule;
    userConfig = users.${username};
    hardware = inputs.hardware.nixosModules;
  };
}
