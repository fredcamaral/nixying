{
  pkgs,
  inputs,
  username,
  host,
  ...
}: {
  nix.settings.allowed-users = ["${username}"];
  nix.settings.trusted-users = ["root" "${username}"];
  nix.extraOptions = ''
    extra-substituters = https://devenv.cachix.org
    extra-trusted-public-keys = devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=
  '';
}
