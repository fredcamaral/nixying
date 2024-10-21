{
  inputs,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    extraConfig = ''
      monitor=DP-1,5120x1440@120,0x0,1
      monitor=DP-2,2560x1440@60,0x-1440,1
      monitor=DP-3,2560x1440@60,2560x-1440,1

      workspace=1,monitor:DP-1
      workspace=2,monitor:DP-1
      workspace=3,monitor:DP-1
      workspace=4,monitor:DP-1

      workspace=5,monitor:DP-2
      workspace=6,monitor:DP-2

      workspace=7,monitor:DP-3
      workspace=8,monitor:DP-3

      xwayland {
        force_zero_scaling = false
      }
    '';
  };
}
