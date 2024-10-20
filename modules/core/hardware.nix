{pkgs, ...}: {
  hardware = {
    enableRedistributableFirmware = true;
    enableAllFirmware = true;

    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;

    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
