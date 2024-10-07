{
  config,
  lib,
  pkgs,
  ...
}: {
  xdg.configFile."kanshi/config".text = ''
    # Undocked profile (laptop screen only)
    profile {
        output "eDP-1" enable mode 3840x2400@60Hz position 0,0 scale 2.0
    }

    # Docked profile with lid closed (external monitor only)
    profile {
        output "eDP-1" disable
        output "DP-7" enable mode 5120x1440@240Hz position 0,0
    }

    # Docked profile with lid open (dual monitor setup)
    profile {
        output "eDP-1" enable mode 3840x2400@60Hz position 0,0 scale 2.0
        output "DP-7" enable mode 5120x1440@240Hz position -5120,0
    }
  '';
}
