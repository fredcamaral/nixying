{pkgs, ...}: {
  hardware = {
    enableRedistributableFirmware = true;
    enableAllFirmware = true;

    bluetooth.enable = true;

    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        # amdvlk
        # rocm-opencl-icd
        # rocm-opencl-runtime
        # vulkan-loader
        # vulkan-validation-layers
      ];
    };
  };
}
