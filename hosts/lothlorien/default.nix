{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core
  ];

  # services.samba = {
  #   enable = true;
  #   settings = {
  #     global = {
  #       workgroup = "WORKGROUP";
  #       security = "user";
  #       "server string" = "Samba Server";
  #       "server role" = "standalone server";
  #       "log file" = "/var/log/samba/log.%m";
  #       "max log size" = 50;
  #       "dns proxy" = "no";
  #       "map to guest" = "bad user";
  #     };
  #   };
  #   shares = {
  #     ness = {
  #       path = "/media/ness";
  #       browseable = "yes";
  #       "read only" = "no";
  #       "guest ok" = "yes";
  #       "create mask" = "0644";
  #       "directory mask" = "0755";
  #     };
  #     limbo = {
  #       path = "/media/limbo";
  #       browseable = "yes";
  #       "read only" = "no";
  #       "guest ok" = "yes";
  #       "create mask" = "0644";
  #       "directory mask" = "0755";
  #     };
  #   };
  # };

  networking.firewall.allowedTCPPorts = [445 139];
  networking.firewall.allowedUDPPorts = [137 138];
  networking.hostId = "24212607";

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
