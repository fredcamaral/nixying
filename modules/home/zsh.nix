{
  hostname,
  config,
  pkgs,
  host,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "gnzh";
      plugins = [
        "git"
        "history"
        "wd"
      ];
    };
    initExtraFirst = ''
      DISABLE_AUTO_UPDATE=true
      DISABLE_MAGIC_FUNCTIONS=true
      export "MICRO_TRUECOLOR=1"
    '';
    initExtra = ''
      setopt share_history
      setopt hist_expire_dups_first
      setopt hist_ignore_dups
      setopt hist_verify

      # Use fd (https://github.com/sharkdp/fd) for listing path candidates.
      # - The first argument to the function ($1) is the base path to start traversal
      # - See the source code (completion.{bash,zsh}) for the details.
      _fzf_compgen_path() {
        fd --hidden --exclude .git . "$1"
      }

      # Use fd to generate the list for directory completion
      _fzf_compgen_dir() {
        fd --type=d --hidden --exclude .git . "$1"
      }

      # Advanced customization of fzf options via _fzf_comprun function
      # - The first argument to the function is the name of the command.
      # - You should make sure to pass the rest of the arguments to fzf.
      _fzf_comprun() {
        local command=$1
        shift

        case "$command" in
          cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
          ssh)          fzf --preview 'dig {}'                   "$@" ;;
          *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
        esac
      }
    '';
    shellAliases = {
      # Utils
      c = "clear";
      cd = "z";
      tt = "gtrash put";
      cat = "bat";
      nano = "micro";
      # code = "codium";
      py = "python";
      icat = "kitten icat";
      dsize = "du -hs";
      pdf = "tdf";
      open = "xdg-open";
      space = "ncdu";
      man = "BAT_THEME='default' batman";

      ls = "eza --icons=always -o --git -s type";
      l = "eza --icons=always -o --git -s type --group-directories-first -l";
      # ll = "eza --icons  -a --group-directories-first -1 --no-user --long";
      ll = "ls -l";
      la = "ls -la";
      tree = "eza --icons --tree --group-directories-first";

      # ZFS
      import-pools = "sudo zpool import -a";

      # Use 'nvim' instead of 'vim' or 'vi'
      vim = "nvim";
      vi = "nvim";

      # Nixos
      cdnix = "cd ~/repos/nixying";
      ns = "nom-shell --run zsh";
      nix-switch = "nh os switch";
      home-switch = "home-manager switch --flake ~/repos/nixying/#fredamaral";
      nix-update = "nh os switch --update";
      nix-clean = "nh clean all --keep 5";
      nix-search = "nh search";
      nix-test = "nh os test";
      nix-full-clean = ''
        nix-collect-garbage --delete-old
        sudo nix-collect-garbage -d
      '';

      # python
      piv = "python -m venv .venv";
      psv = "source .venv/bin/activate";
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
