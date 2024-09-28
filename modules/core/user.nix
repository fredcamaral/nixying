{
  pkgs,
  inputs,
  username,
  host,
  ...
}: {
  users.users.${username} = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = ["networkmanager" "wheel" "power"];
    shell = pkgs.zsh;
  };
  nix.settings.allowed-users = ["${username}"];
}
