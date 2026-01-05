{
  config,
  pkgs,
  ...
}: {
  services.swaync = {
    enable = true;
    settings = {
      # Layer configuration
      layer = "overlay";
      layer-shell = true;
      layer-shell-cover-screen = true;

      control-center-margin-top = 10;
      control-center-margin-right = 10;

      # Appearance
      control-center-width = 450;
      control-center-height = -1; # Full height (fit to screen)
      fit-to-screen = true;

      notification-window-width = 450;
      notification-window-height = -1;

      # Notification behavior
      timeout = 5;
      timeout-low = 3;
      timeout-critical = 0;

      # Features
      notification-grouping = true;
      relative-timestamps = true;
      notification-2fa-action = true;
      notification-inline-replies = false; # Niri may not support this

      # keyboard-shortcuts = true;
      keyboard-shortcuts = false;
      hide-on-clear = false;
      hide-on-action = true;

      # Animation
      transition-time = 200;

      # Image settings
      image-visibility = "when-available";
      notification-body-image-height = 100;
      notification-body-image-width = 200;

      # Widget order - customize as needed
      widgets = [
        "inhibitors"
        "title"
        "dnd"
        "volume"
        "notifications"
        "mpris"
        "backlight"
      ];

      # Widget configurations
      widget-config = {
        # Music Player Widget
        mpris = {
          show-album-art = "always";
          autohide = false;
          loop-carousel = true;
          blacklist = [
            #   "Firefox" # Ignore browser audio
          ];
        };

        volume = {
          label = "Volume";
          show-per-app = true;
          show-per-app-icon = true;
          show-per-app-label = false;
          expand-per-app = true;
          empty-list-label = "No active applications";
          expand-button-label = "Apps";
          collapse-button-label = "Hide";
          animation-type = "slide_down";
          animation-duration = 250;
        };

        # Backlight/Brightness
        backlight = {
          label = "Brightness";
          device = "intel_backlight"; # Change if needed (amdgpu_bl0, etc.)
          subsystem = "backlight";
          min = 10; # Prevents completely black screen
        };

        # Title Widget
        title = {
          text = "Notifications";
          clear-all-button = true;
          button-text = "Clear All";
        };

        # DND Widget
        dnd = {
          text = "Do Not Disturb";
        };

        # Inhibitors Widget
        inhibitors = {
          text = "Inhibitors";
          clear-all-button = true;
          button-text = "Clear All";
        };
        # notifications = {
        #   vexpand = false;
        # };
      };

      # Notification filtering - replace notifications instead of spamming
      # notification-visibility = {
      #   "volume-update" = {
      #     app-name = "^(pulseaudio|PulseAudio)$";
      #     state = "enabled";
      #   };
      #
      #   "brightness-update" = {
      #     app-name = "^(brightness|Brightness)$";
      #     state = "enabled";
      #   };
      #
      #   "mpris-update" = {
      #     app-name = "^(mpris|MPRIS)$";
      #     state = "enabled";
      #   };
      # };

      # Scripts to trigger notifications for volume, brightness, and MPRIS
      # scripts = {
      #   "volume-script" = {
      #     exec = "notify-send -a 'pulseaudio' -u low 'Volume Updated'";
      #     app-name = ".*";
      #     urgency = "Low";
      #   };
      #
      #   "brightness-script" = {
      #     exec = "notify-send -a 'brightness' -u low 'Brightness Updated'";
      #     app-name = ".*";
      #     urgency = "Low";
      #   };
      #
      #   "mpris-script" = {
      #     exec = "notify-send -a 'mpris' -u low 'Now Playing'";
      #     app-name = ".*";
      #     urgency = "Low";
      #   };
      # };
    };

    style = ''
      * {
        font-family: "JetBrains Mono", monospace;
      }
    '';
  };
}
