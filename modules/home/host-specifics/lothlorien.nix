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

  programs.waybar.settings.mainBar = with custom; {
    "hyprland/workspaces" = {
      active-only = false;
      disable-scroll = true;
      format = "{icon}";
      on-click = "activate";
      all-outputs = false;
      format-icons = {
        "1" = "1:zen";
        "2" = "2:nix";
        "3" = "3:work";
        "4" = "4:work";
        "5" = "5:utilz";
        "6" = "6:others";
        "7" = "7:utilz";
        "8" = "8:others";
        "9" = "IX";
        "10" = "X";
        sort-by-number = true;
      };
      persistent-workspaces = {
        "1" = [];
        "2" = [];
        "3" = [];
        "4" = [];
        "5" = [];
        "6" = [];
        "7" = [];
        "8" = [];
        # "9" = [];
      };
    };
  };
}
