{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    devenv
    termius
  ];
}
