{pkgs, ...}: {
  enable = true;
  settings = {
    monitor = [
      "eDP-1, 2256x1504@60.00, 0x0, 1.175"
      "DP-3, 1920x1080@143.98100, 0x0, 1.00"
    ];

    exec = [
      ''gsettings set org.gnome.desktop.interface gtk-theme "Adwaita"   # for GTK3 apps''
      ''gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"   # for GTK4 apps''
    ];
    exec-once = [
      "waybar &"
      "obsidian &"
      "gammastep -O 4000 &"
      "~/Projects/dotfiles/dots/.config/hypr/wallpaper.sh"
    ];

    env = [
      "XCURSOR_THEME, Adwaita"
      "XCURSOR_SIZE, 24"

      # "XDG_CURRENT_DESKTOP,Hyprland"
      # "XDG_SESSION_TYPE,wayland"
      # "XDG_SESSION_DESKTOP,Hyprland"

      # "GTK_APPLICATION_PREFER_DARK_THEME,1"
      # "GTK_THEME_VARIANT,dark"
      # "GTK_THEME=Gruvbox-Material-Dark"
    ];
    general = {
      "gaps_in" = 2;
      "gaps_out" = 2;

      "border_size" = 2;

      "col.inactive_border" = "rgb(1d2021)";
      "col.active_border" = "rgb(928374)";

      "resize_on_border" = true;
      "allow_tearing" = false;
      "layout" = "master";
    };

    decoration = {
      "rounding" = "0";

      "active_opacity" = "1.0";
      "inactive_opacity" = "1.0";

      "blur" = {
        "enabled" = false;
        "size" = "3";
        "passes" = "1";
        "vibrancy" = "0.1696";
      };

      "shadow" = {
        "enabled" = true;
        "range" = "4";
        "render_power" = "3";
        "color" = "rgba(1a1a1aee)";
      };
    };

    animations = {
      "enabled" = false;
    };

    master = {
      "new_status" = "slave";
      "mfact" = "0.5";
    };

    misc = {
      "force_default_wallpaper" = "1";
      "disable_hyprland_logo" = true;
    };

    input = {
      "follow_mouse" = "1";
      "sensitivity" = "0";

      "kb_layout" = "us";
      "kb_variant" = "altgr-intl";

      "touchpad" = {
        natural_scroll = false;
      };
    };

    # voyager
    device = [
      {
        "name" = "zsa-technology-labs-voyager";
        "kb_layout" = "us";
        "kb_variant" = "altgr-intl";
      }

      {
        "name" = "kanata";
        "kb_layout" = "us, de";
        "kb_variant" = "altgr-intl, qwerty";
        "kb_options" = "grp:alt_shift_toggle";
      }
      {
        "name" = "epic-mouse-v1";
        "sensitivity" = "-0.5";
      }
    ];

    gestures = {
      "workspace_swipe" = false;
    };

    "$mainMod" = "SUPER";
    "$terminal" = "${pkgs.ghostty}/bin/ghostty";
    "$browser" = "zen-beta";
    "$fileManager" = "${pkgs.nautilus}/bin/nautilus --new-window";
    "$menu" = "rofi -show drun";
    "$quicknote" = "~/Projects/dotfiles/dots/.config/rofi/rofi-quicknote.sh";
    bind = [
      "$mainMod, W, killactive,"
      "$mainMod CONTROL, R, exec, ~/Projects/dotfiles/dots/.config/waybar/reload.sh"

      "$mainMod, return, exec, $terminal"
      "$mainMod, B, exec, $browser"
      "$mainMod, space, exec, $menu"
      "$mainMod, F, exec, $fileManager"
      "$mainMod, O, exec, obsidian"
      "$mainMod CONTROL, S, exec, hyprshot -m region --clipboard-only"
      "$mainMod, n, exec, $quicknote"
      "$mainMod ALT SHIFT CONTROL, l, exec, hyprlock"

      "$mainMod, H, movefocus, l"
      "$mainMod, J, movefocus, d"
      "$mainMod, K, movefocus, u"
      "$mainMod, L, movefocus, r"

      "$mainMod SHIFT, H, movewindow, l"
      "$mainMod SHIFT, J, movewindow, u"
      "$mainMod SHIFT, K, movewindow, d"
      "$mainMod SHIFT, L, movewindow, r"

      "$mainMod, TAB, fullscreen, 1"
      "$mainMod, T, togglefloating,"

      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"
      "$mainMod, 0, workspace, 10"

      "$mainMod SHIFT, 1, movetoworkspace, 1"
      "$mainMod SHIFT, 2, movetoworkspace, 2"
      "$mainMod SHIFT, 3, movetoworkspace, 3"
      "$mainMod SHIFT, 4, movetoworkspace, 4"
      "$mainMod SHIFT, 5, movetoworkspace, 5"
      "$mainMod SHIFT, 6, movetoworkspace, 6"
      "$mainMod SHIFT, 7, movetoworkspace, 7"
      "$mainMod SHIFT, 8, movetoworkspace, 8"
      "$mainMod SHIFT, 9, movetoworkspace, 9"
      "$mainMod SHIFT, 0, movetoworkspace, 10"
    ];
    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];
    binde = [
      "$mainMod CONTROL, H, resizeactive, -25 0"
      "$mainMod CONTROL, J, resizeactive, 0 25"
      "$mainMod CONTROL, K, resizeactive, 0 -25"
      "$mainMod CONTROL, L, resizeactive, 25 0"
    ];
    bindl = [
      ",XF86AudioRaiseVolume, exec, amixer set Master 3%+"
      ",XF86AudioLowerVolume, exec, amixer set Master 3%-"
      ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioMicMute, exec, amixer set Master toggle"
      ",XF86MonBrightnessUp, exec, brillo -q -A 2"
      ",XF86MonBrightnessDown, exec, brillo -q -U 2"
    ];
    bindel = [
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPause, exec, playerctl play-pause"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
    ];
    windowrulev2 = [
      "workspace 10 silent, class:^(obsidian)$"
      "bordersize 0, fullscreenstate:* 1"
      "suppressevent maximize, class:.*"
      "float,class:^(nm-connection-editor)$"
      "float,class:^(.blueman-manager-wrapped)$"
      "float,class:^(org.pulseaudio.pavucontrol)$"
      "float,class:^(org.gnome.Nautilus)$"
      "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
    ];
  };
  extraConfig = ''
    ecosystem:no_update_news = true
  '';
}
