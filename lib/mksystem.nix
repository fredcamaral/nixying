{
  system,
  pkgs,
  inputs,
  username,
  hostModule,
  extraModules ? [],
}:
inputs.nixpkgs.lib.nixosSystem {
  inherit system;
  modules =
    [
      hostModule
      inputs.stylix.nixosModules.stylix
      inputs.agenix.nixosModules.default
      inputs.nixvim.nixosModules.nixvim
    ]
    ++ extraModules;
  specialArgs = {
    inherit inputs username;
    host = builtins.baseNameOf hostModule;
  };
}
