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
    ]
    ++ extraModules;
  specialArgs = {
    inherit inputs outputs username;
    host = builtins.baseNameOf hostModule;
    userConfig = users.${username};
  };
}
