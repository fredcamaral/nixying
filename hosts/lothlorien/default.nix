{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core
  ];

  hardware = {
    amdgpu.amdvlk = {
      enable = true;
      support32Bit.enable = true;
    };
    amdgpu.initrd.enable = true;
    amdgpu.opencl.enable = true;
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = lib.mkDefault "performance";
  };
}
