{
  description = "FrostPhoenix's nixos configuration";

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
      type = "git";
      url = "https://github.com/hyprwm/Hyprland?ref=v0.43.0";
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

    zen-browser.url = "path:./pkgs/zen-browser-flake";
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
      blastoise = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/core-server
          stylix.nixosModules.stylix
          agenix.nixosModules.default
        ];
        specialArgs = {
          host = "blastoise";
          inherit self inputs username;
        };
      };
      lorinand = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/thinkpad-p1
          stylix.nixosModules.stylix
          agenix.nixosModules.default
          nixos-hardware.nixosModules.lenovo-thinkpad-p1
          nixos-hardware.nixosModules.common-hidpi
        ];
        specialArgs = {
          host = "lorinand";
          inherit self inputs username;
        };
      };
      edelgion = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/vms
          stylix.nixosModules.stylix
          agenix.nixosModules.default
        ];
        specialArgs = {
          host = "edelgion";
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
            host = "lorinand"; # or whichever is your default host
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
