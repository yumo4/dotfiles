{pkgs, ...}: {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        # output = [
        # ];
        modules-left = [
          "hyprland/workspaces"
          "niri/workspaces"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "tray"
          "network"
          "backlight"
          "pulseaudio"
          # "hyprland/language"
          # "niri/language"
          "battery"
        ];

        "hyprland/workspaces" = {
          disable-scroll = true;
        };
        "tray" = {
          spacing = 10;
        };
        "clock" = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          # format = " {:%d.%m.%y %H:%M} ";
          format = " {:%H:%M  %d.%m} ";
        };
        backlight = {
          format = "{icon} {percent}% ";
          format-icons = ["󰛨"];
        };
        "hyprland/language" = {
          format = "󰌌 {short}  ";
        };
        "niri/language" = {
          format = "󰌌 {short}  ";
        };
        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = " {icon} {capacity}% ";
          format-full = " {icon} {capacity}% ";
          format-charging = " {icon}󱐋{capacity}% ";
          format-icons = ["󰁺" "󰁼" "󰁾" "󰂀" "󰁹"];
        };
        "network" = {
          format-wifi = "   {essid} ";
          format-ethernet = " 󰌗  ";
          format-disconnected = " 󱘖 ";
          on-click = "nm-connection-editor";
          on-click-right = "blueman-manager";
        };
        "pulseaudio" = {
          format = "{icon} {volume}% ";
          format-muted = "  {volume}% ";
          format-bluetooth = " {icon} {volume}%{format_source} ";
          format-bluetooth-muted = "{icon} {format_source} ";
          format-icons = {
            headphone = "";
            phone = "";
            portable = "";
            default = ["" "" " "];
          };
          on-click = "pavucontrol";
        };
        # "controller": "controller1", # specify the alias of the controller if there are more than 1 on the system
        "bluetooth" = {
          format = " {status}";
          format-disabled = ""; # an empty format will hide the module
          format-connected = " {num_connections} connected";
          tooltip-format = "{controller_alias}{controller_address}";
          tooltip-format-connected = "{controller_alias}{controller_address}{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}{device_address}";
        };
      };
    };
    style = ''
      * {
         margin: 0px;
         padding: 0px;
      }
      .mainBar#waybar {
         background: #1d2021;
      }
      #workspaces button {
         color: #928374;
         padding: 0 2px;
      }
      #workspaces button.active {
         color: #ebdbb2;
         padding: 0 2px;
      }
      #clock {
         color: #ebdbb2;
      }
      #network {
         color: #ebdbb2;
      }
      #pulseaudio {
         color: #ebdbb2;
      }
      #battery {
         color: #ebdbb2;
      }
      #language {
         color: #ebdbb2;
      }
      #backlight {
         color: #ebdbb2;
      }
    '';
  };
}
