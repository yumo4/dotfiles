{
  config,
  pkgs,
  ...
}: {
  programs.niri.settings.binds = with config.lib.niri.actions; let
    set-volume = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@";
    brillo = spawn "${pkgs.brillo}/bin/brillo" "-q";
    rofi = spawn "rofi" "-show" "drun";
    browser = spawn "zen-beta";
    playerctl = spawn "${pkgs.playerctl}/bin/playerctl";
    fileManager = spawn "${pkgs.nautilus}/bin/nautilus" "--new-window";
  in {
    # "XF86AudioMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
    # "XF86AudioMicMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";

    # "XF86AudioMute".action = spawn "sh" "-c" "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && notify-send 'Mute toggled'";
    # "XF86AudioMicMute".action = spawn "sh" "-c" "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle && notify-send 'Mic mute toggled'";
    #
    # "XF86AudioPlay".action = playerctl "play-pause";
    # "XF86AudioStop".action = playerctl "pause";
    # "XF86AudioPrev".action = playerctl "previous";
    # "XF86AudioNext".action = playerctl "next";
    #
    # "XF86AudioRaiseVolume".action = set-volume "5%+";
    # "XF86AudioLowerVolume".action = set-volume "5%-";
    #
    # "XF86MonBrightnessUp".action = brillo "-A" "2";
    # "XF86MonBrightnessDown".action = brillo "-U" "2";

    # Volume mute toggle
    "XF86AudioMute".action = spawn "swayosd-client" "--output-volume" "mute-toggle";
    # Mic mute toggle
    "XF86AudioMicMute".action = spawn "swayosd-client" "--input-volume" "mute-toggle";
    # Playback controls (show playback OSD)
    "XF86AudioPlay".action = spawn "swayosd-client" "--playerctl" "play-pause";
    "XF86AudioStop".action = spawn "swayosd-client" "--playerctl" "pause";
    "XF86AudioPrev".action = spawn "swayosd-client" "--playerctl" "previous";
    "XF86AudioNext".action = spawn "swayosd-client" "--playerctl" "next";
    # Volume up/down (using relative steps; you can change the values)
    "XF86AudioRaiseVolume".action = spawn "swayosd-client" "--output-volume" "+5";
    "XF86AudioLowerVolume".action = spawn "swayosd-client" "--output-volume" "-5";
    # Brightness up/down (use + / - for relative steps, or 'raise'/'lower')
    "XF86MonBrightnessUp".action = spawn "swayosd-client" "--brightness" "+2";
    "XF86MonBrightnessDown".action = spawn "swayosd-client" "--brightness" "-2";

    "Print".action.screenshot-screen = {write-to-disk = true;};
    # "Mod+Shift+Alt+S".action = screenshot-window;
    "Mod+Ctrl+S".action.screenshot = {show-pointer = false;};

    # "Mod+Space".action = rofi;
    # "Mod+Space".action = spawn "sherlock";
    "Mod+Space".action = spawn "vicinae" "toggle";
    "Mod+F".action = fileManager;
    "Mod+B".action = browser;
    "Mod+Ctrl+R".action = spawn "~/Projects/dotfiles/dots/.config/waybar/reload.sh";
    "Mod+N".action = spawn "~/Projects/dotfiles/dots/.config/rofi/rofi-quicknote.sh";
    "Mod+Return".action = spawn "${pkgs.ghostty}/bin/ghostty";
    "Mod+escape".action = spawn "hyprlock";

    # "Mod+U".action = spawn "env" "XDG_CURRENT_DESKTOP=gnome" "gnome-control-center";
    "Mod+U".action = spawn "~/Projects/dotfiles/scripts/gnome-settings.sh";
    "Mod+P".action = spawn "swaync-client" "-t" "-sw";

    "Mod+W".action = close-window;
    "Mod+S".action = switch-preset-column-width;
    "Mod+Tab".action = maximize-column;
    "Mod+T".action = toggle-window-floating;
    # "Mod+Q".action = toggle-column-tabbed-display;

    # "Mod+Comma".action = consume-window-into-column;
    # "Mod+Period".action = expel-window-from-column;

    "Mod+Comma".action = consume-or-expel-window-left;
    "Mod+Period".action = consume-or-expel-window-right;
    "Mod+C".action = center-visible-columns;
    # "Mod+R".action = switch-preset-column-width;
    "Mod+Z".action = switch-focus-between-floating-and-tiling;

    "Mod+M".action = toggle-overview;

    "Mod+Ctrl+H".action = set-column-width "-10%";
    "Mod+Ctrl+L".action = set-column-width "+10%";
    "Mod+Ctrl+K".action = set-window-height "-10%";
    "Mod+Ctrl+J".action = set-window-height "+10%";

    "Mod+H".action = focus-column-left;
    "Mod+L".action = focus-column-right;
    "Mod+J".action = focus-window-or-workspace-down;
    "Mod+K".action = focus-window-or-workspace-up;

    "Mod+Shift+H".action = move-column-left;
    "Mod+Shift+L".action = move-column-right;
    "Mod+Shift+K".action = move-column-to-workspace-up;
    "Mod+Shift+J".action = move-column-to-workspace-down;

    "Mod+Alt+H".action = focus-monitor-left;
    "Mod+Alt+J".action = focus-monitor-down;
    "Mod+Alt+K".action = focus-monitor-up;
    "Mod+Alt+L".action = focus-monitor-right;

    "Mod+Alt+Shift+H".action = move-column-to-monitor-left;
    "Mod+Alt+Shift+J".action = move-column-to-monitor-down;
    "Mod+Alt+Shift+K".action = move-column-to-monitor-up;
    "Mod+Alt+Shift+L".action = move-column-to-monitor-right;

    "Mod+1".action = focus-workspace 1;
    "Mod+2".action = focus-workspace 2;
    "Mod+3".action = focus-workspace 3;
    "Mod+4".action = focus-workspace 4;
    "Mod+5".action = focus-workspace 5;
    "Mod+6".action = focus-workspace 6;
    "Mod+7".action = focus-workspace 7;
    "Mod+8".action = focus-workspace 8;
    "Mod+9".action = focus-workspace 9;

    "Mod+Shift+1".action.move-column-to-workspace = 1;
    "Mod+Shift+2".action.move-column-to-workspace = 2;
    "Mod+Shift+3".action.move-column-to-workspace = 3;
    "Mod+Shift+4".action.move-column-to-workspace = 4;
    "Mod+Shift+5".action.move-column-to-workspace = 5;
    "Mod+Shift+6".action.move-column-to-workspace = 6;
    "Mod+Shift+7".action.move-column-to-workspace = 7;
    "Mod+Shift+8".action.move-column-to-workspace = 8;
    "Mod+Shift+9".action.move-column-to-workspace = 9;
  };
}
