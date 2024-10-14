{
  lib,
  helpers,
  pkgs,
  ...
}:
with lib;
helpers.vim-plugin.mkVimPlugin {
  name = "godot";
  originalName = "vim-godot";
  package = "vim-godot";
  globalPrefix = "godot_";

  maintainers = [ maintainers.GaetanLepage ];

  extraOptions = {
    godotPackage = lib.mkPackageOption pkgs "godot" {
      nullable = true;
      default = "godot_4";
    };
  };

  settingsOptions = {
    executable = helpers.defaultNullOpts.mkStr "godot" ''
      Path to the `godot` executable.
    '';
  };

  settingsExample = {
    executable = "godot";
  };

  extraConfig = cfg: { extraPackages = [ cfg.godotPackage ]; };
}
