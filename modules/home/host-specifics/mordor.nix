{
  inputs,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    extraConfig = ''
      monitor=eDP-1,2880x1800@120,0x0,1

      xwayland {
        force_zero_scaling = false
      }
    '';
  };
}
