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
    alejandra.url = "github:kamadorueda/alejandra";
    hyprland = {
      url = "github:hyprwm/Hyprland?ref=v0.43.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix.url = "github:ryantm/agenix";
    home-manager.url = "github:nix-community/home-manager";
    stylix.url = "github:danth/stylix";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    zen-browser.url = "path:derivs/zen-browser/";
    nixvim.url = "path:derivs/nixvim/";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    ...
  }: let
    username = "fredamaral";
    mkSystem = import ./lib/mksystem.nix;
    mkHome = import ./lib/mkhome.nix;
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    formatter.${system} = pkgs.alejandra;

    nixosConfigurations = {
      lothlorien = mkSystem {
        inherit system pkgs inputs username;
        hostModule = ./hosts/lothlorien;
        extraModules = [];
      };

      lorinand = mkSystem {
        inherit system pkgs inputs username;
        hostModule = ./hosts/lorinand;
        extraModules = [
          inputs.nixos-hardware.nixosModules.lenovo-thinkpad-p1
          inputs.nixos-hardware.nixosModules.common-hidpi
        ];
      };

      beleriand = mkSystem {
        inherit system pkgs inputs username;
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
      self.nixosConfigurations
      // {
        "${username}" = mkHome {
          inherit pkgs inputs username;
          host = "lorinand"; # or whichever is your default host
        };
      };
  };
}
