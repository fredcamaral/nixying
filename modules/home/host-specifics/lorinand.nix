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

  programs.waybar.settings.mainBar = {
    "hyprland/workspaces" = {
      active-only = false;
      disable-scroll = true;
      format = "{icon}";
      on-click = "activate";
      all-outputs = false;
      format-icons = {
        "1" = "1:zen";
        "2" = "2:nix";
        "3" = "3:term";
        "4" = "4:term";
        "5" = "V";
        "6" = "VI";
        "7" = "VII";
        "8" = "VIII";
        "9" = "IX";
        "10" = "X";
        sort-by-number = true;
      };
      persistent-workspaces = {
        "1" = [];
        "2" = [];
        "3" = [];
        "4" = [];
      };
    };
  };
}
