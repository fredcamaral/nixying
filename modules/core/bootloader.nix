{
  pkgs,
  config,
  ...
}: {
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    systemd-boot.configurationLimit = 10;
    systemd-boot.editor = true;
  };
  boot = {
    initrd.systemd.enable = true;
    initrd.verbose = false;
    kernelParams = ["quiet" "splash"];
    plymouth.enable = true;
  };
}
