{pkgs, ...}: {
  home.packages = [pkgs.hypridle];
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "niri msg action power-on-monitors";
        ignore_dbus_inhibit = false;
        ignore_systemd_inhibit = false;
      };

      listener = [
        # Dim brightness after 2.5 minutes
        # {
        #   timeout = 150;
        #   on-timeout = "brightnessctl -s set 10";
        #   on-resume = "brightnessctl -r";
        # }

        # Lock screen after 5 minutes
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }

        # Turn off display
        # NOTE: niri only
        {
          timeout = 320;
          on-timeout = "niri msg action power-off-monitors";
          on-resume = "niri msg action power-on-monitors";
        }

        # Suspend
        {
          timeout = 320;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
