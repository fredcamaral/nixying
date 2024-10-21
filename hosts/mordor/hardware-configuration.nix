{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  boot = {
    initrd = {
      availableKernelModules = ["xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc"];
      kernelModules = [];
    };
    kernelModules = ["kvm-intel" "acpi_call" "intel_pstate" "i915" "msr"];
    extraModulePackages = with config.boot.kernelPackages; [acpi_call];
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
    kernelParams = [
      "pcie_aspm=force"
      "i915.enable_fbc=1"
      "i915.enable_psr=2"
      "intel_pstate=disable"
      "elevator=none"
    ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nix-root";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-label/nix-boot";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };
    "/home" = {
      device = "/dev/disk/by-label/nix-home";
      fsType = "ext4";
    };
  };

  swapDevices = [{device = "/dev/disk/by-label/nix-swap";}];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
