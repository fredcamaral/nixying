{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    inputs.nixvim.packages.${pkgs.system}.default
  ];
}
