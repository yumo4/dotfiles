{
  config,
  pkgs,
  ...
}: {
  programs.niri.settings.binds = with config.lib.niri.actions; let
    set-volume = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@";
    brillo = spawn "${pkgs.brillo}/bin/brillo" "-q";
    # brillo = spawn "${pkgs.brillo}/bin/brillo" "-q" "-u" "300000";
    # rofi = spawn "${pkgs.rofi-wayland}/bin/rofi" "-show" "drun";
    rofi = spawn "rofi" "-show" "drun";
    browser = spawn "zen-beta";
    # focusObsidian = spawn "niri" "msg" "action" "focus-windowd" "1";
    playerctl = spawn "${pkgs.playerctl}/bin/playerctl";
    fileManager = spawn "${pkgs.nautilus}/bin/nautilus" "--new-window";
  in {
    "XF86AudioMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
    "XF86AudioMicMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";

    "XF86AudioPlay".action = playerctl "play-pause";
    "XF86AudioStop".action = playerctl "pause";
    "XF86AudioPrev".action = playerctl "previous";
    "XF86AudioNext".action = playerctl "next";

    "XF86AudioRaiseVolume".action = set-volume "5%+";
    "XF86AudioLowerVolume".action = set-volume "5%-";

    "XF86MonBrightnessUp".action = brillo "-A" "2";
    "XF86MonBrightnessDown".action = brillo "-U" "2";

    "Print".action.screenshot-screen = {write-to-disk = true;};
    "Mod+Shift+Alt+S".action = screenshot-window;
    "Mod+Ctrl+S".action.screenshot = {show-pointer = false;};

    "Mod+Space".action = rofi;
    # "Mod+R".action = spawn "${pkgs.sherlock-launcher}/bin/sherlock";
    "Mod+R".action = spawn "sherlock";
    "Mod+F".action = fileManager;
    "Mod+B".action = browser;
    # "Mod+O".action = spawn "${pkgs.obsidian}/bin/obsidian";
    # "Mod+O".action = focusObsidian;
    "Mod+Ctrl+R".action = spawn "~/Projects/dotfiles/dots/.config/waybar/reload.sh";
    "Mod+N".action = spawn "~/Projects/dotfiles/dots/.config/rofi/rofi-quicknote.sh";
    "Mod+Return".action = spawn "${pkgs.ghostty}/bin/ghostty";
    "Mod+escape".action = spawn "hyprlock";

    # "Mod+U".action = spawn "env XDG_CURRENT_DESKTOP=gnome gnome-control-center";
    "Mod+U".action = spawn "~/Projects/dotfiles/scripts/gnome-settings.sh";

    "Mod+W".action = close-window;
    "Mod+S".action = switch-preset-column-width;
    "Mod+Tab".action = maximize-column;
    # "Mod+Tab".action = fullscreen-window;
    # "Mod+Shift+F".action = expand-column-to-available-width;
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

    "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;
    "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;

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
