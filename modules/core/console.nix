{
  lib,
  pkgs,
  config,
  ...
}: let
  oldKernel = lib.versionOlder config.boot.kernelPackages.kernel.version "6.8";
in {
  # Just set the console font, don't mess with the font settings
  console.font = lib.mkIf oldKernel (
    lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-v32n.psf.gz"
  );
  console.earlySetup = lib.mkIf oldKernel (lib.mkDefault true);
}
