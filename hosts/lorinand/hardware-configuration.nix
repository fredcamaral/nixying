{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel" "nvidia_modeset" "nvidia" "nvidia_uvm" "nvidia_drm"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/36ccd87b-d2ed-48c6-8d49-84a92026e34a";
    fsType = "btrfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/BA23-B706";
    fsType = "vfat";
    options = ["fmask=0077" "dmask=0077"];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/9e538b1e-01f8-4d5e-a5a4-0141a9fd2f11";
    fsType = "btrfs";
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/46283dd0-dbff-4927-97b9-16045e720c50";}
  ];

  networking = {
    usePredictableInterfaceNames = true;
    useDHCP = lib.mkDefault true;
    # interfaces.wlp9s0f0.useDHCP = lib.mkDefault true;
  };

  systemd.network.links = {
    "laptopWifi" = {
      matchConfig.PermanentMACAddress = "10:5f:ad:77:82:0b";
      linkConfig.Name = "laptopWifi";
    };
    "homeWired" = {
      matchConfig.PermanentMACAddress = "38:7c:76:9b:87:25";
      linkConfig.Name = "homeWired";
    };
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
