{
  pkgs,
  userConfig,
  ...
}: let
  gh-clone-org = pkgs.stdenv.mkDerivation {
    pname = "gh-clone-org";
    version = "main";
    src = pkgs.fetchFromGitHub {
      owner = "matt-bartel";
      repo = "gh-clone-org";
      rev = "master";
      sha256 = "sha256-ViCtTH8TKU7xgq2oGhWxk0R4WRDZQZSf+yAmNo4xQv8=";
    };
    installPhase = ''
      mkdir -p $out/bin
      cp gh-clone-org $out/bin/
      chmod +x $out/bin/gh-clone-org
    '';
  };
in {
  programs.git = {
    enable = true;

    userName = userConfig.fullName;
    userEmail = userConfig.email;
    signing = {
      key = userConfig.gitKey;
      signByDefault = true;
    };

    extraConfig = {
      init.defaultBranch = "main";
      credential.helper = "store";
      merge.conflictstyle = "diff3";
      diff.colorMoved = "default";
      pull.rebase = "true";
    };

    delta = {
      enable = true;
      # catppuccin.enable = true;
      options = {
        keep-plus-minus-markers = true;
        light = false;
        line-numbers = true;
        navigate = true;
        width = 280;
      };
    };
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
    extensions = with pkgs; [
      # Add GitHub CLI extensions here
      # Note: Limited options available by default
      gh-eco
      gh-copilot
      gh-clone-org
    ];
    settings = {
      # Add any custom GitHub CLI settings here
    };
  };

  programs.gh-dash = {
    enable = true;
    settings = {
      # Configure Pull Request sections and filters
      prSections = [
        {
          title = "PR Created";
          filters = "is:open author:@me";
        }
        {
          title = "PR to Reviews";
          filters = "is:open review-requested:@me";
        }
        {
          title = "PR Involved";
          filters = "is:open involves:@me -author:@me";
        }
      ];
      # Configure Issue sections and filters
      issuesSections = [
        {
          title = "Created";
          filters = "is:open author:@me";
        }
        {
          title = "Assigned";
          filters = "is:open assignee:@me";
        }
        {
          title = "Involved";
          filters = "is:open involves:@me -author:@me";
        }
      ];
    };
  };

  home.packages = [pkgs.gh]; # pkgs.git-lfs

  programs.zsh.shellAliases = {
    g = "lazygit";
    gf = "onefetch --number-of-file-churns 0 --no-color-palette";
    ga = "git add";
    gaa = "git add --all";
    gs = "git status";
    gb = "git branch";
    gm = "git merge";
    gd = "git diff";
    gpl = "git pull";
    gplo = "git pull origin";
    gps = "git push";
    gpso = "git push origin";
    gpst = "git push --follow-tags";
    gcl = "git clone";
    gc = "git commit";
    gcm = "git commit -m";
    gcma = "git add --all && git commit -m";
    gtag = "git tag -ma";
    gch = "git checkout";
    gchb = "git checkout -b";
    glog = "git log --oneline --decorate --graph";
    glol = "git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'";
    glola = "git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --all";
    glols = "git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --stat";
    gacp = "git add --all && git commit -m 'update' && git push origin";
  };
}
