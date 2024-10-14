{
  lib,
  helpers,
  pkgs,
  ...
}:
helpers.vim-plugin.mkVimPlugin {
  name = "fugitive";
  originalName = "vim-fugitive";
  package = "vim-fugitive";

  maintainers = [ lib.maintainers.GaetanLepage ];

  # In typical tpope fashion, this plugin has no config options
  extraOptions = {
    gitPackage = lib.mkPackageOption pkgs "git" {
      nullable = true;
    };
  };

  extraConfig = cfg: {
    extraPackages = [ cfg.gitPackage ];
  };
}
