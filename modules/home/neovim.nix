{
  pkgs,
  config,
  ...
}: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    # Configure Plugins
    plugins = with pkgs.vimPlugins; [
      # Core plugins
      vim-surround
      auto-pairs

      # Treesitter for better syntax highlighting
      nvim-treesitter
      # File explorer
      nvim-tree.lua
      # Fuzzy finder
      telescope-nvim
      # Statusline
      lualine-nvim
      # Git integration
      gitsigns-nvim
      # Keybinding helper
      which-key-nvim
      # LSP configuration
      nvim-lspconfig
      # Completion framework
      nvim-cmp
      # Additional completion sources
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      # Comment plugin
      comment-nvim
    ];

    # Options for Neovim
    settings = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      expandtab = true;
      cursorline = true;
      termguicolors = true;
      signcolumn = "yes"; # To avoid signcolumn issues with gitsigns
    };

    # Additional Lua configuration
    extraConfigLua = ''
      -- Enable Telescope keybindings
      vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { noremap = true, silent = true })

      -- Lualine setup
      require('lualine').setup {
        options = {
          theme = 'tokyonight',
        }
      }

      -- Treesitter configuration
      require('nvim-treesitter.configs').setup {
        ensure_installed = "maintained",  -- Only use maintained parsers
        highlight = {
          enable = true,              -- false will disable the whole extension
          additional_vim_regex_highlighting = false,
        },
      }

      -- Setup nvim-tree
      require('nvim-tree').setup {}

      -- LSP Config
      local lspconfig = require('lspconfig')

      -- Use an on_attach function to only map the following keys after the language server attaches to the current buffer
      local on_attach = function(client, bufnr)
        local opts = { noremap=true, silent=true }
        -- Mappings.
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<Cmd>lua vim.lsp.buf.format { async = true }<CR>', opts)
      end

      -- Enable LSP servers
      lspconfig.tsserver.setup { on_attach = on_attach }
      lspconfig.pyright.setup { on_attach = on_attach }
      lspconfig.rust_analyzer.setup { on_attach = on_attach }

      -- nvim-cmp setup
      local cmp = require'cmp'
      cmp.setup {
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        mapping = {
          ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
          ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
          ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
          ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
          ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path' },
        }),
      }
    '';

    # Colorscheme configuration
    extraOptions = ''
      vim.cmd[[colorscheme tokyonight]]
    '';
  };
}
