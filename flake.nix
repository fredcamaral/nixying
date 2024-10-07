{
  description = "fred amaral's nixos configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hypr-contrib.url = "github:hyprwm/contrib";
    hyprpicker.url = "github:hyprwm/hyprpicker";
    hy3 = {
      url = "github:outfoxxed/hy3?ref=hl0.43.0";
      inputs.hyprland.follows = "hyprland";
    };
    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    hyprland = {
      url = "github:hyprwm/Hyprland?ref=v0.43.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix.url = "github:ryantm/agenix";
    home-manager.url = "github:nix-community/home-manager";
    stylix.url = "github:danth/stylix";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    zen-browser.url = "path:pkgs/zen-browser-flake";
    nixvim.url = "github:nix-community/nixvim";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    flake-utils,
    ...
  }: let
    username = "fredamaral";
    mkSystem = import ./lib/mksystem.nix;
    mkHome = import ./lib/mkhome.nix;
    supportedSystems = ["x86_64-linux"];
  in
    flake-utils.lib.eachSystem supportedSystems (system: let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      formatter = pkgs.alejandra;
    })
    // {
      nixosConfigurations = {
        lothlorien = mkSystem {
          system = "x86_64-linux";
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
          inherit inputs username;
          hostModule = ./hosts/lothlorien;
          extraModules = [];
        };

        lorinand = mkSystem {
          system = "x86_64-linux";
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
          inherit inputs username;
          hostModule = ./hosts/lorinand;
          extraModules = [
            inputs.nixos-hardware.nixosModules.lenovo-thinkpad-p1
            inputs.nixos-hardware.nixosModules.common-hidpi
          ];
        };

        beleriand = mkSystem {
          system = "x86_64-linux";
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
          inherit inputs username;
          hostModule = ./hosts/beleriand;
          extraModules = [];
        };
      };

      homeConfigurations =
        builtins.mapAttrs
        (hostname: nixosConfig:
          mkHome {
            pkgs = nixosConfig.pkgs;
            inherit inputs username;
            host = hostname;
          })
        self.nixosConfigurations;
    };
}
