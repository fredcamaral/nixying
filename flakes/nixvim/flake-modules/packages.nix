{ inputs, ... }:
{
  perSystem =
    {
      config,
      inputs',
      system,
      ...
    }:
    {
      packages = import ../docs {
        inherit system;
        inherit (inputs) nixpkgs;
        inherit (inputs') nuschtosSearch;
      };

      # Test that all packages build fine when running `nix flake check`.
      checks = config.packages;
    };
}
