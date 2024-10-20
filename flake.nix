{
  description = "fred amaral's nixos configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";

    hyprland = {
      url = "github:hyprwm/hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hypr-contrib.url = "github:hyprwm/contrib";
    hyprpicker.url = "github:hyprwm/hyprpicker";

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    alejandra.url = "github:kamadorueda/alejandra";
    agenix.url = "github:ryantm/agenix";
    stylix.url = "github:danth/stylix";
    hardware.url = "github:NixOS/nixos-hardware";
    zen-browser.url = "path:flakes/zen-browser";
    catppuccin.url = "github:catppuccin/nix";
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    hardware,
    ...
  } @ inputs: let
    inherit (self) outputs;
    users = {
      fredamaral = {
        email = "fred@fredamaral.com";
        fullName = "Fred Amaral";
        # gitKey = "C5810093";
        name = "fredamaral";
      };
    };
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
          inputs.hardware.nixosModules.lenovo-thinkpad-p1
          inputs.hardware.nixosModules.common-hidpi
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
          host = "lorinand";
        };
      };
  };
}
