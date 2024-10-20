{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    jetbrains.mps
    jetbrains.goland
    jetbrains.webstorm
    jetbrains.datagrip
    jetbrains.gateway
    jetbrains.rust-rover
    jetbrains.pycharm-professional
    jetbrains.writerside

    devenv
    direnv
  ];
}
