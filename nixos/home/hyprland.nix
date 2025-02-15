{pkgs, meta ...}:
let
  monitorLine = monitor:
    builtins.concatStringsSep "," [
      monitor.name
      "${
        if monitor ? dimensions
        then monitor.dimensions
        else "${monitor.width}x${monitor.height}"
      }${
        if monitor.dimensions == "preferred"
        then ""
        else "@${builtins.toString monitor.framerate}"
      }"
      monitor.position
      (builtins.toString monitor.scale)
      "transform"
      (builtins.toString monitor.transform)
    ];
    isFramework = meta.hostname == "framwork";
in {

settings = {
    "$mod" = "SUPER";

    "$terminal = ghostty --gtk-single-instance=true"
    # $browser = brave
    "$browser = zen-browser"
    # $fileManager = pcmanfm
    "$fileManager = thunar"
    "$menu = rofi -show drun"

    general = {
	gaps_in = 2;
	gaps_out = 2;
	border_size = 2;
	col.inactive_border = "rgb(1d2021)";
	col.active_border = "rgb(928374)";
	resize_on_border = true;
	allow_tearing = false;
	layout = "master";
    };
    monitor = map monitorLine meta.monitors;
    exec-once =
    [
	"waybar &"
	"obsidian &"
	"gammastep -O 4000 &"
	"~/.config/hypr/wallpaper.sh"
	"ghostty --gtk-single-instance=true --quit-after-last-window-closed=false --initial-window=false"
    ];
    env =
    [
	"XCURSOR_SIZE,24"
	"HYPRCURSOR_SIZE"
	"XDG_CURRENT_DES"
	"XDG_SESSION_TYP"
	"XDG_SESSION_DES"
    ];
    master = {
	new_status = "slave";
	mfact = 0.5;
    };
    decoration = {
	rounding = 0;
	active_opacity = 1.0;
	inactive_opacity = 1.0;
	blur = {
	    enabled = false;
	};
	shadow = {
	    enabled = true;
		range = 4;
		render_power = 3;
		color = "rgba(1a1a1aee)";
	};
    };
    misc = {
	force_default_wallpaper = 1;
	disable_hyprland_logo = true;
    };
    animations = {
	enabled = false;
    };
    input = {
    kb_layout = if isFramework then "us, de" else "us";
    kb_variant = if isFramework then "altgr-intl, qwerty" else "altgr-intl";
    kb_options = if isFramework then "grp:alt_shift_toggle";

    follow_mouse = 1;
    sensitivity = 0;
    touchpad = {
        natural_scroll = false;
    };
    };
    bind = 
    [
	"$mainMod, W, killactive,"
	"$mainMod CONTROL, R, exec, ~/.config/waybar/reload.sh" # ?
	"$mainMod, return, exec, $terminal"
	"$mainMod, B, exec, $browser"
	"$mainMod, F, exec, $fileManager"
	"$mainMod, space, exec, $menu"
	"$mainMod, O, exec, obsidian"
	"$mainMod CONTROL, S, exec, hyprshot -m region --clipboard-only"
	"$mainMod, H, movefocus, l"
	"$mainMod, J, movefocus, u"
	"$mainMod, K, movefocus, d"
	"$mainMod, L, movefocus, r"
	"$mainMod SHIFT, H, movewindow, l"
	"$mainMod SHIFT, J, movewindow, u"
	"$mainMod SHIFT, K, movewindow, d"
	"$mainMod SHIFT, L, movewindow, r"
	"$mainMod, TAB, fullscreen, 1"
	"$mainMod, T, togglefloating"
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
    bindm =
    [
	"$mainMod, mouse:272, movewindow"
	"$mainMod, mouse:273, resizewindow"
    ];
    binde =
    [
	"$mainMod CONTROL, H, resizeactive, -25 0"
	"$mainMod CONTROL, J, resizeactive, 0 -25"
	"$mainMod CONTROL, K, resizeactive, 0 25"
	"$mainMod CONTROL, L, resizeactive, 25 0"
    ];
    bindel =
    [
	", XF86AudioRaiseVolume, exec, amixer set Master 3%+"
	", XF86AudioLowerVolume, exec, amixer set Master 3%-"
	", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
	", XF86AudioMicMute, exec, amixer set Master toggle"
	", XF86MonBrightnessUp, exec, brillo -q -A 2"
	", XF86MonBrightnessDown, exec, brillo -q -U 2"
    ];
    bindl =
    [
	", XF86AudioNext, exec, playerctl next"
	", XF86AudioPause, exec, playerctl play-pause"
	", XF86AudioPlay, exec, playerctl play-pause"
	", XF86AudioPrev, exec, playerctl previous"
    ];
    extraConfig = ''
	ecosystem:no_update_news = true

	windowrulev2 = workspace 10 silent, class:^(obsidian)$
	windowrulev2 = bordersize 0, fullscreenstate:* 1 

	windowrulev2 = float,class:^(nm-connection-editor)$
	windowrulev2 = float,class:^(blueman-manager)$
	windowrulev2 = float,class:^(org.pulseaudio.pavucontrol)$
	windowrulev2 = float,class:^(thunar)$

	windowrulev2 = suppressevent maximize, class:.*
	windowrulev2 = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0
      '';
};
}
