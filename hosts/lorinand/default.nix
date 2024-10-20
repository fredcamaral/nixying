{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core
  ];

  networking = {
    usePredictableInterfaceNames = true;
    useDHCP = lib.mkDefault true;
  };

  environment = {
    systemPackages = with pkgs; [acpi brightnessctl light glxinfo];
    variables = {
      GBM_BACKEND = "nvidia-drm";
      LIBVA_DRIVER_NAME = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };
  };

  services = {
    xserver.videoDrivers = ["intel" "nvidia"];
    hardware.bolt.enable = true;
    libinput.enable = true;
    fstrim.enable = true;
    fwupd.enable = true;
    thermald.enable = true;
    power-profiles-daemon = {
      enable = false;
    };
    fprintd.enable = lib.mkDefault false;
    tlp = {
      enable = true;
      settings = lib.mkDefault {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "low-power";

        # USB_EXCLUDE_BTUSB = 1;

        # RADEON_DPM_PERF_LEVEL_ON_BAT = "low";

        # DISK_IOSCHED = ["none"];

        # Battery charge thresholds for office usage
        START_CHARGE_THRESH_BAT0 = 40;
        STOP_CHARGE_THRESH_BAT0 = 50;

        # Battery charge thresholds for on-road usage
        # START_CHARGE_THRESH_BAT0 = 85;
        # STOP_CHARGE_THRESH_BAT0 = 90;

        # RUNTIME_PM_ON_AC = "auto";
        # RUNTIME_PM_ON_BAT = "auto";
      };
    };
    logind = {
      lidSwitch = "suspend";
      lidSwitchDocked = "ignore";
      lidSwitchExternalPower = "ignore";
    };
    upower = {
      enable = true;
      percentageLow = 20;
      percentageCritical = 5;
      percentageAction = 3;
      criticalPowerAction = "PowerOff";
    };
  };

  hardware = {
    trackpoint.enable = true;
    nvidia = {
      modesetting.enable = true;
      powerManagement = {
        enable = true;
        finegrained = true;
      };
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        reverseSync.enable = true;
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
    sensor.iio.enable = true;
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };

  # powerManagement = {
  #   cpuFreqGovernor = "conservative";
  #   powertop.enable = true;
  # };
}
