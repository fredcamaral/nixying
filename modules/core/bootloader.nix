# {
#   pkgs,
#   config,
#   ...
# }: {
#   boot.loader = {
#     systemd-boot.enable = true;
#     efi.canTouchEfiVariables = true;
#     systemd-boot.configurationLimit = 10;
#     systemd-boot.editor = true;
#   };
#   boot.initrd.systemd.enable = true;
# }
{
  pkgs,
  config,
  ...
}: {
  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
      gfxmodeEfi = "1024x768";
      gfxmodeBios = "1024x768";
    };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };
}
