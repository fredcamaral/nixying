{
  lib,
  config,
  ...
}:
let
  inherit (lib.nixvim) defaultNullOpts;

  copilot-lua-cfg = config.plugins.copilot-lua;
  cfg = config.plugins.copilot-cmp;
in
{
  options.plugins.copilot-cmp = lib.nixvim.neovim-plugin.extraOptionsOptions // {
    event =
      defaultNullOpts.mkListOf lib.types.str
        [
          "InsertEnter"
          "LspAttach"
        ]
        ''
          Configures when the source is registered.
          Unless you have a unique problem for your particular configuration you probably don't want
          to touch this.
        '';

    fixPairs = defaultNullOpts.mkBool true ''
      Suppose you have the following code: `print('h')`.
      Copilot might try to account for the `'` and `)` and complete it with this: `print('hello`.

      This is not good behavior for consistency reasons and will just end up deleting the two ending
      characters.
      This option fixes that.
      Don't turn this off unless you are having problems with pairs and believe this might be
      causing them.
    '';
  };

  config = lib.mkIf cfg.enable {
    warnings =
      lib.optional
        ((!lib.isBool copilot-lua-cfg.suggestion.enabled) || copilot-lua-cfg.suggestion.enabled)
        ''
          It is recommended to disable copilot's `suggestion` module, as it can interfere with
          completions properly appearing in copilot-cmp.
        ''
      ++ lib.optional ((!lib.isBool copilot-lua-cfg.panel.enabled) || copilot-lua-cfg.panel.enabled) ''
        It is recommended to disable copilot's `panel` module, as it can interfere with completions
        properly appearing in copilot-cmp.
      '';

    plugins.copilot-lua.enable = true;

    extraConfigLua =
      let
        setupOptions =
          with cfg;
          {
            inherit event;
            fix_pairs = fixPairs;
          }
          // cfg.extraOptions;
      in
      ''
        require('copilot_cmp').setup(${lib.nixvim.toLuaObject setupOptions})
      '';
  };
}
