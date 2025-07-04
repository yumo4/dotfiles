{...}: let
  windowRules = let
    activeColor = "#928374";
    inactiveColor = "#1d2021";
  in [
    {
      geometry-corner-radius = let
        radius = 0.0;
      in {
        bottom-left = radius;
        bottom-right = radius;
        top-left = radius;
        top-right = radius;
      };
      clip-to-geometry = true;
      draw-border-with-background = false;
    }
    {
      matches = [
        {is-floating = true;}
      ];
      shadow.enable = true;
    }
    {
      matches = [
        {
          is-window-cast-target = true;
        }
      ];
      focus-ring = {
        active.color = activeColor;
        inactive.color = inactiveColor;
      };
      border = {
        inactive.color = inactiveColor;
      };
      shadow = {
        color = inactiveColor;
      };
      tab-indicator = {
        active.color = activeColor;
        inactive.color = inactiveColor;
      };
    }
    # {
    #   matches = [
    #     {app-id = "zen";}
    #     {app-id = "firefox";}
    #     {app-id = "chromium-browser";}
    #     # {app-id = "edge";}
    #   ];
    #   open-maximized = true;
    # }
    {
      matches = [
        {
          app-id = "firefox";
          title = "Picture-in-Picture";
        }
      ];
      open-floating = true;
      default-floating-position = {
        x = 32;
        y = 32;
        relative-to = "bottom-right";
      };
      default-column-width = {fixed = 480;};
      default-window-height = {fixed = 270;};
    }
    {
      matches = [
        {
          app-id = "zen";
          title = "Picture-in-Picture";
        }
      ];
      open-floating = true;
      default-floating-position = {
        x = 32;
        y = 32;
        relative-to = "bottom-right";
      };
      default-column-width = {fixed = 480;};
      default-window-height = {fixed = 270;};
    }
    {
      matches = [{title = "Picture in picture";}];
      open-floating = true;
      default-floating-position = {
        x = 32;
        y = 32;
        relative-to = "bottom-right";
      };
    }
    {
      matches = [{title = "Discord Popout";}];
      open-floating = true;
      default-floating-position = {
        x = 32;
        y = 32;
        relative-to = "bottom-right";
      };
    }
    {
      matches = [{app-id = "org.gnome.Settings";}];
      open-floating = true;
    }
    {
      matches = [{app-id = "org.gnome.Nautilus";}];
      open-floating = true;
    }
    {
      matches = [{app-id = "vesktop";}];
      open-floating = true;
    }
    {
      matches = [{app-id = "pavucontrol";}];
      open-floating = true;
    }
    {
      matches = [{app-id = "pavucontrol-qt";}];
      open-floating = true;
    }
    {
      matches = [{app-id = "com.saivert.pwvucontrol";}];
      open-floating = true;
    }
    {
      matches = [{app-id = "io.github.fsobolev.Cavalier";}];
      open-floating = true;
    }
    {
      matches = [{app-id = "dialog";}];
      open-floating = true;
    }
    {
      matches = [{app-id = "popup";}];
      open-floating = true;
    }
    {
      matches = [{app-id = "task_dialog";}];
      open-floating = true;
    }
    {
      matches = [{app-id = "gcr-prompter";}];
      open-floating = true;
    }
    {
      matches = [{app-id = "file-roller";}];
      open-floating = true;
    }
    {
      matches = [{app-id = "org.gnome.FileRoller";}];
      open-floating = true;
    }
    {
      matches = [{app-id = "nm-connection-editor";}];
      open-floating = true;
    }
    {
      matches = [{app-id = "blueman-manager";}];
      open-floating = true;
    }
    {
      matches = [{app-id = "xdg-desktop-portal-gtk";}];
      open-floating = true;
    }
    {
      matches = [{app-id = "org.kde.polkit-kde-authentication-agent-1";}];
      open-floating = true;
    }
    {
      matches = [{app-id = "pinentry";}];
      open-floating = true;
    }
    {
      matches = [{title = "Progress";}];
      open-floating = true;
    }
    {
      matches = [{title = "File Operations";}];
      open-floating = true;
    }
    {
      matches = [{title = "Copying";}];
      open-floating = true;
    }
    {
      matches = [{title = "Moving";}];
      open-floating = true;
    }
    {
      matches = [{title = "Properties";}];
      open-floating = true;
    }
    {
      matches = [{title = "Downloads";}];
      open-floating = true;
    }
    {
      matches = [{title = "file progress";}];
      open-floating = true;
    }
    {
      matches = [{title = "Confirm";}];
      open-floating = true;
    }
    {
      matches = [{title = "Authentication Required";}];
      open-floating = true;
    }
    {
      matches = [{title = "Notice";}];
      open-floating = true;
    }
    {
      matches = [{title = "Warning";}];
      open-floating = true;
    }
    {
      matches = [{title = "Error";}];
      open-floating = true;
    }
  ];
in {
  programs.niri.settings = {
    window-rules = windowRules;
    layer-rules = [
      {
        matches = [{namespace = "^swww-daemon$";}];
        # place-within-backdrop = true;
      }
    ];
  };
}
