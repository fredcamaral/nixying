{
  description = "fred amaral's nixos configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    hardware.url = "github:NixOS/nixos-hardware";
    hyprland.url = "github:hyprwm/hyprland?submodules=1";
    hypr-contrib.url = "github:hyprwm/contrib";
    hyprpicker.url = "github:hyprwm/hyprpicker";
    nix-index-database.url = "github:Mic92/nix-index-database";
    alejandra.url = "github:kamadorueda/alejandra";
    agenix.url = "github:ryantm/agenix";
    stylix.url = "github:danth/stylix";
    nixvim.url = "github:elythh/nixvim";
    # zen-browser.url = "path:flakes/zen-browser";
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
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    mkSystem = import ./lib/mksystem.nix;
    mkHome = import ./lib/mkhome.nix;

    baseUser = {
      email = "fred@fredamaral.com.br";
      fullName = "Fred Amaral";
      name = username;
    };

    users =
      builtins.mapAttrs
      (name: gitKey: baseUser // {inherit gitKey;})
      {
        lothlorien = "41B4629EFD929A74";
        lorinand = "0xLORINAND_KEY";
        mordor = "0xMORDOR_KEY";
        beleriand = "0xBELERIAND_KEY";
      };

    commonArgs = {inherit system pkgs inputs outputs username;};

    mkConfig = {
      hostModule,
      extraModules ? [],
    }: let
      hostname = builtins.baseNameOf hostModule;
    in
      mkSystem (commonArgs
        // {
          inherit hostModule extraModules;
          users.${username} = users.${hostname};
        });

    hosts = {
      lothlorien = {extraModules = with hardware.nixosModules; [common-cpu-intel common-gpu-amd common-hidpi];};
      lorinand = {extraModules = with hardware.nixosModules; [lenovo-thinkpad-p1 common-hidpi];};
      mordor = {extraModules = with hardware.nixosModules; [lenovo-thinkpad-x1-12th-gen common-hidpi];};
      beleriand = {};
    };
  in {
    formatter.${system} = pkgs.alejandra;

    nixosConfigurations =
      builtins.mapAttrs
      (name: value:
        mkConfig {
          hostModule = ./hosts/${name};
          extraModules = value.extraModules or [];
        })
      hosts;

    homeConfigurations = {
      "${username}@lothlorien" = mkHome (commonArgs
        // {
          inherit username;
          users.${username} = users.lothlorien;
          hostname = "lothlorien";
        });
      "${username}@lorinand" = mkHome (commonArgs
        // {
          inherit username;
          users.${username} = users.lorinand;

          hostname = "lorinand";
        });
      "${username}@mordor" = mkHome (commonArgs
        // {
          inherit username;
          users.${username} = users.mordor;

          hostname = "mordor";
        });
      "${username}@beleriand" = mkHome (commonArgs
        // {
          inherit username;
          users.${username} = users.beleriand;
          hostname = "beleriand";
        });
    };
  };
}
