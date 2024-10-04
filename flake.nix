{
  description = "FrostPhoenix's nixos configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    hypr-contrib.url = "github:hyprwm/contrib";
    hyprpicker.url = "github:hyprwm/hyprpicker";

    alejandra.url = "github:kamadorueda/alejandra/3.0.0";

    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      submodules = true;
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    zen-browser.url = "github:MarceColl/zen-browser-flake";
  };

  outputs = {
    nixpkgs,
    stylix,
    agenix,
    home-manager,
    nixos-hardware,
    self,
    ...
  } @ inputs: let
    username = "fredamaral";
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      megaman = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/megaman
          stylix.nixosModules.stylix
          agenix.nixosModules.default
        ];
        specialArgs = {
          host = "megaman";
          inherit self inputs username;
        };
      };
      bomberman = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/bomberman
          stylix.nixosModules.stylix
          agenix.nixosModules.default
          nixos-hardware.nixosModules.lenovo-thinkpad-p1
          # nixos-hardware.nixosModules.common-gpu-nvidia
        ];
        specialArgs = {
          host = "bomberman";
          inherit self inputs username;
        };
      };
      sonic = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/sonic
          stylix.nixosModules.stylix
          agenix.nixosModules.default
        ];
        specialArgs = {
          host = "sonic";
          inherit self inputs username;
        };
      };
    };

    homeConfigurations =
      {
        ${username} = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./modules/home
            stylix.homeManagerModules.stylix
          ];
          extraSpecialArgs = {
            inherit inputs username;
            host = "megaman"; # or whichever is your default host
          };
        };
      }
      // builtins.mapAttrs (
        hostname: nixosConfig:
          home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [
              ./modules/home
              stylix.homeManagerModules.stylix
            ];
            extraSpecialArgs = {
              inherit inputs username;
              host = hostname;
            };
          }
      )
      self.nixosConfigurations;
  };
}
