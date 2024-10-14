{ lib, ... }:
let
  inherit (lib.nixvim) defaultNullOpts mkNullOrOption toLuaObject;
in
lib.nixvim.neovim-plugin.mkNeovimPlugin {
  name = "web-devicons";
  originalName = "nvim-web-devicons";
  luaName = "nvim-web-devicons";
  package = "nvim-web-devicons";

  maintainers = [ lib.maintainers.refaelsh ];

  settingsExample = {
    color_icons = true;
    strict = true;
  };

  extraOptions = {
    customIcons = defaultNullOpts.mkAttrsOf (lib.types.submodule {
      freeformType = lib.types.anything;

      options = {
        icon = defaultNullOpts.mkStr null "Icon to use.";
        color = defaultNullOpts.mkStr null "Color of the icon.";
        cterm_color = defaultNullOpts.mkStr null "Cterm color of the icon.";
        name = defaultNullOpts.mkStr null "Name to replace with icon.";
      };
    }) { } ''Custom overrides for icons.'';

    defaultIcon = mkNullOrOption (lib.types.submodule {
      options = {
        icon = defaultNullOpts.mkStr null "Icon to use.";
        color = defaultNullOpts.mkStr null "Color of the icon.";
        cterm_color = defaultNullOpts.mkStr null "Cterm color of the icon.";
      };
    }) ''Set the default icon when none is found.'';
  };

  extraConfig = cfg: {
    plugins.web-devicons.luaConfig.post =
      lib.optionalString (cfg.customIcons != null) ''
        require('nvim-web-devicons').set_icon(${toLuaObject cfg.customIcons})
      ''
      + lib.optionalString (cfg.defaultIcon != null) ''
        require('nvim-web-devicons').set_default_icon(
          ${toLuaObject cfg.defaultIcon.icon}, ${toLuaObject cfg.defaultIcon.color}, ${toLuaObject cfg.defaultIcon.cterm_color})
      '';
  };
}
