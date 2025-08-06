{
  config,
  pkgs,
  ...
}: let
  activeColor = "#928374";
  inactiveColor = "#1d2021";
  pointer = config.home.pointerCursor;
  makeCommand = command: {
    command = [command];
  };
in {
  programs.niri = {
    enable = true;
    package = pkgs.niri;

    settings = {
      environment = {
        CLUTTER_BACKEND = "wayland";
        # DISPLAY = null;
        DISPLAY = ":0";
        GDK_BACKEND = "wayland,x11";
        MOZ_ENABLE_WAYLAND = "1";
        NIXOS_OZONE_WL = "1";
        QT_QPA_PLATFORM = "wayland;xcb";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        SDL_VIDEODRIVER = "wayland";
      };

      spawn-at-startup = [
        (makeCommand "swww-daemon")
        (makeCommand "~/Projects/dotfiles/dots/.config/hypr/wallpaper.sh")
        (makeCommand "swaybg")
        (makeCommand "~/Projects/dotfiles/scripts/wallpaper-sway.sh")
        (makeCommand "obsidian")
        (makeCommand "waybar")
        (makeCommand "tailscale-systray")
        (makeCommand "xwayland-satellite")
        {command = ["gammastep" "-O" "4000"];}
      ];
      prefer-no-csd = true; # no client side decorations
      hotkey-overlay.skip-at-startup = true;

      input = {
        keyboard = {
          track-layout = "global";
          xkb = {
            layout = "us";
            variant = "altgr-intl";
            # i can't do the device specific layout config like in hyprland
            # -> configure `kanata` properly (umlaute, ...)
          };
        };
        touchpad = {
          click-method = "clickfinger";
          dwt = true;
          dwtp = true;
          drag = true;
          natural-scroll = false;
          scroll-method = "two-finger";
          tap = true;
          # tap-button-map = "left-right-middle";
          middle-emulation = false;
          accel-profile = "adaptive";
        };
        focus-follows-mouse.enable = true;
        focus-follows-mouse.max-scroll-amount = "0%";
        warp-mouse-to-focus.enable = true;
        workspace-auto-back-and-forth = true;
      };

      screenshot-path = "~/Pictures/Screenshots/Screenshot-from-%Y-%m-%d-%H-%M-%S.png";

      outputs = {
        "DP-3" = {
          mode = {
            width = 1920;
            height = 1080;
            refresh = 143.98100;
          };
          scale = 1.0;
          position = {
            x = 0;
            y = 0;
          };
        };

        "eDP-1" = {
          mode = {
            width = 2256;
            height = 1504;
            refresh = 60.00;
          };
          scale = 1.25; # 1.175
          position = {
            x = 0;
            y = 0;
          };
        };
      };

      overview = {
        # backdrop-color = "transparent";
        backdrop-color = inactiveColor;
      };

      gestures = {
        hot-corners = {
          enable = true;
        };
      };

      cursor = {
        size = 24;
        theme = "Adwaita";
      };

      layout = {
        focus-ring.enable = false;
        background-color = "transparent";
        border = {
          enable = true;
          width = 2;
          active.color = activeColor;
          inactive.color = inactiveColor;
        };
        shadow = {
          enable = true;
        };
        preset-column-widths = [
          # {proportion = 0.25;}
          {proportion = 0.5;}
          # {proportion = 0.75;}
          {proportion = 1.0;}
        ];
        default-column-width = {proportion = 0.5;};
        # default-column-width = {};

        # gaps all around
        gaps = 2;
        # gaps in directions
        struts = {
          left = 0;
          right = 0;
          top = 0;
          bottom = 0;
        };

        tab-indicator = {
          hide-when-single-tab = true;
          place-within-column = true;
          position = "left";
          corner-radius = 20.0;
          gap = -12.0;
          gaps-between-tabs = 10.0;
          width = 4.0;
          length.total-proportion = 0.1;
        };
      };
      # animations = {
      #   enable = false;
      # };
    };
  };
}
