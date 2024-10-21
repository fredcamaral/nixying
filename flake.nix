{
  description = "fred amaral's nixos configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    hardware.url = "github:NixOS/nixos-hardware";
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
    zen-browser.url = "path:flakes/zen-browser";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    hardware,
    ...
  } @ inputs: let
    inherit (self) outputs;
    username = "fredamaral";
    mkSystem = import ./lib/mksystem.nix;
    mkHome = import ./lib/mkhome.nix;
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    baseUser = {
      email = "fred@fredamaral.com.br";
      fullName = "Fred Amaral";
      name = username;
    };

    users = {
      lothlorien = baseUser // {gitKey = "0xA944934B89700029";};
      lorinand = baseUser // {gitKey = "0xLORINAND_KEY";};
      mordor = baseUser // {gitKey = "0xMORDOR_KEY";};
      beleriand = baseUser // {gitKey = "0xBELERIAND_KEY";};
    };

    commonArgs = {
      inherit system pkgs inputs outputs username;
    };

    mkConfig = {
      hostModule,
      extraModules ? [],
    }: let
      hostname = builtins.baseNameOf hostModule;
    in
      mkSystem (commonArgs
        // {
          inherit hostModule extraModules;
          users = {${username} = users.${hostname};};
        });
  in {
    formatter.${system} = pkgs.alejandra;

    nixosConfigurations = {
      lothlorien = mkConfig {
        hostModule = ./hosts/lothlorien;
        extraModules = with hardware.nixosModules; [
          common-cpu-intel
          common-gpu-amd
          common-hidpi
        ];
      };
      lorinand = mkConfig {
        hostModule = ./hosts/lorinand;
        extraModules = with hardware.nixosModules; [
          lenovo-thinkpad-p1
          common-hidpi
        ];
      };
      mordor = mkConfig {
        hostModule = ./hosts/mordor;
        extraModules = with hardware.nixosModules; [
          lenovo-thinkpad-x1-12th-gen
          common-hidpi
        ];
      };
      beleriand = mkConfig {
        hostModule = ./hosts/beleriand;
      };
    };

    homeConfigurations = {
      "${username}@lothlorien" = mkHome (commonArgs // {users.${username} = users.lothlorien;});
      "${username}@lorinand" = mkHome (commonArgs // {users.${username} = users.lorinand;});
      "${username}@mordor" = mkHome (commonArgs // {users.${username} = users.mordor;});
      "${username}@beleriand" = mkHome (commonArgs // {users.${username} = users.beleriand;});
    };
  };
}
