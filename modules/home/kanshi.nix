{
  config,
  lib,
  pkgs,
  ...
}: {
  services.kanshi = {
    enable = true;
    profiles = {
      undocked = {
        outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            mode = "3840x2400@60Hz";
            position = "0,0";
            scale = 2.0;
          }
        ];
      };
      docked-lid-closed = {
        outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "DP-7";
            status = "enable";
            mode = "5120x1440@240Hz";
            position = "0,0";
          }
        ];
      };
      docked-lid-open = {
        outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            mode = "3840x2400@60Hz";
            position = "0,0";
            scale = 2.0;
          }
          {
            criteria = "DP-7";
            status = "enable";
            mode = "5120x1440@240Hz";
            position = "-5120,0";
          }
        ];
      };
    };
  };
}
