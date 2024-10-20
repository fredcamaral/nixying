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
    kernelModules = ["kvm-intel" "nvidia_modeset" "nvidia" "nvidia_uvm" "nvidia_drm" "acpi_call" "intel_pstate" "i915" "msr"];
    extraModulePackages = with config.boot.kernelPackages; [acpi_call];
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
    kernelParams = [
      "pcie_aspm=force"
      "i915.enable_fbc=1"
      "i915.enable_psr=2"
      "intel_pstate=disable"
      "elevator=none"
    ];
    extraModprobeConfig = "options nvidia NVreg_DynamicPowerManagement=0x02";
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/36ccd87b-d2ed-48c6-8d49-84a92026e34a";
      fsType = "btrfs";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/BA23-B706";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };
    "/home" = {
      device = "/dev/disk/by-uuid/9e538b1e-01f8-4d5e-a5a4-0141a9fd2f11";
      fsType = "btrfs";
    };
    "/mnt/ness" = {
      device = "//21.26.7.131/ness";
      fsType = "cifs";
      options = [
        "x-systemd.automount"
        "noauto"
        "x-systemd.idle-timeout=60"
        "x-systemd.device-timeout=5s"
        "x-systemd.mount-timeout=5s"
        "user"
        "users"
        "guest"
        "uid=1000"
        "gid=100"
        "iocharset=utf8"
        "rw"
        "vers=3.0"
      ];
    };
    "/mnt/limbo" = {
      device = "//21.26.7.131/limbo";
      fsType = "cifs";
      options = [
        "x-systemd.automount"
        "noauto"
        "x-systemd.idle-timeout=60"
        "x-systemd.device-timeout=5s"
        "x-systemd.mount-timeout=5s"
        "user"
        "users"
        "guest"
        "uid=1000"
        "gid=100"
        "iocharset=utf8"
        "rw"
        "vers=3.0"
      ];
    };
  };

  swapDevices = [{device = "/dev/disk/by-uuid/46283dd0-dbff-4927-97b9-16045e720c50";}];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
