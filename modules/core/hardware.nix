{pkgs, ...}: {
  hardware = {
    enableRedistributableFirmware = true;
    enableAllFirmware = true;

    bluetooth.enable = true;

    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
