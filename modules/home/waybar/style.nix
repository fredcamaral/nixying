{...}: let
  custom = {
    font = "MonoLisa Nerd Font";
    font_size = "14px";
    font_weight = "bold";
    text_color = "#FBF1C7";
    background_0 = "#1D2021";
    background_1 = "#282828";
    border_color = "#928374";
    red = "#CC241D";
    green = "#98971A";
    yellow = "#FABD2F";
    blue = "#458588";
    magenta = "#B16286";
    cyant = "#689D6A";
    orange = "#D65D0E";
    opacity = "1";
    indicator_height = "2px";
  };
in {
  programs.waybar.style = with custom; ''
    * {
      border: none;
      border-radius: 0px;
      padding: 0;
      margin: 0;
      font-family: ${font};
      font-weight: ${font_weight};
      opacity: ${opacity};
      font-size: ${font_size};
    }

    tooltip {
    }
    tooltip label {
      margin: 5px;
    }

    #workspaces {
      padding-left: 15px;
    }
    #workspaces button {
      padding-left:  5px;
      padding-right: 5px;
      margin-right: 10px;
    }
    #clock {
    }

    #tray {
      margin-left: 10px;
    }
    #tray menu {
      padding: 8px;
    }
    #tray menuitem {
      padding: 1px;
    }

    #pulseaudio, #network, #cpu, #memory, #disk, #battery, #custom-notification {
      padding-left: 5px;
      padding-right: 5px;
      margin-right: 10px;
    }

    #cpu {
    }
    #memory {
    }
    #disk {
    }

    #pulseaudio {
      margin-left: 15px;
    }
    #network {
    }
    #battery {
    }

    #custom-notification {
      margin-left: 15px;
      padding-right: 2px;
      margin-right: 5px;
    }

    #custom-launcher {
      font-size: 20px;
      font-weight: bold;
      margin-left: 15px;
      padding-right: 10px;
    }
  '';
}
