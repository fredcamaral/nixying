{
  description = "FrostPhoenix's nixos configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    hypr-contrib.url = "github:hyprwm/contrib";
    hyprpicker.url = "github:hyprwm/hyprpicker";

    alejandra.url = "github:kamadorueda/alejandra/3.0.0";

    nix-gaming.url = "github:fufexan/nix-gaming";

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

    spicetify-nix = {
      url = "github:gerg-l/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser.url = "github:MarceColl/zen-browser-flake";
  };

  outputs = {
    nixpkgs,
    stylix,
    agenix,
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
  };
}
