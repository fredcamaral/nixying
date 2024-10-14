{ lib }:
rec {
  settingsOptions = import ./settings-options.nix { inherit lib; };

  settingsExample = {
    snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
    mapping.__raw = ''
      cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
      })
    '';
    sources.__raw = ''
      cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
        -- { name = 'luasnip' },
        -- { name = 'ultisnips' },
        -- { name = 'snippy' },
      }, {
        { name = 'buffer' },
      })
    '';
  };

  attrsOfOptions =
    with lib.types;
    attrsOf (submodule {
      freeformType = attrsOf anything;
      options = settingsOptions;
    });

  filetype = lib.mkOption {
    type = attrsOfOptions;
    default = { };
    description = "Options provided to the `require('cmp').setup.filetype` function.";
    example = {
      python = {
        sources = [ { name = "nvim_lsp"; } ];
      };
    };
  };

  cmdline = lib.mkOption {
    type = attrsOfOptions;
    default = { };
    description = "Options provided to the `require('cmp').setup.cmdline` function.";
    example = {
      "/" = {
        mapping.__raw = "cmp.mapping.preset.cmdline()";
        sources = [ { name = "buffer"; } ];
      };
      ":" = {
        mapping.__raw = "cmp.mapping.preset.cmdline()";
        sources = [
          { name = "path"; }
          {
            name = "cmdline";
            option = {
              ignore_cmds = [
                "Man"
                "!"
              ];
            };
          }
        ];
      };
    };
  };
}
