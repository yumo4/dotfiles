import subprocess
from libqtile import qtile
from libqtile import bar
from libqtile import widget
from libqtile.config import Screen
from modules.theme import colors, font


def get_widgets_and_bar_height():
    try:
        # Check for battery presence as an indicator of a laptop
        result = subprocess.run(
            ["ls", "/sys/class/power_supply/BAT1"],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
        )
        is_laptop = result.returncode == 0
    except Exception:
        is_laptop = False

    ## bar_height
    laptop_bar_height = 24
    desktop_bar_height = 22

    ## widgets
    laptop_widgets = [
        widget.GroupBox(
            highlight_method="block",
            borderwidth=1,
            this_screen_border=colors[2],
            this_current_screen_border=colors[3],
            active=colors[1],
            inactive=colors[5],
            background=colors[0],
            disable_drag=True,
        ),
        widget.WindowName(
            format="{}",
        ),
        # systray
        widget.Systray(icon_size=20),
        widget.TextBox(text=" "),
        # wifi
        widget.TextBox(
            text=" ",
            fontsize=15,
            foreground=colors[1],
            mouse_callbacks={
                "Button1": lambda: qtile.cmd_spawn("/usr/bin/nm-connection-editor"),
                "Button3": lambda: qtile.cmd_spawn("/usr/bin/blueman-manager"),
            },
        ),
        widget.Wlan(
            fontsize=12,
            foreground=colors[1],
            font=font,
            format="{essid}",
            mouse_callbacks={
                "Button1": lambda: qtile.cmd_spawn("/usr/bin/nm-connection-editor"),
                "Button3": lambda: qtile.cmd_spawn("/usr/bin/blueman-manager"),
            },
        ),
        # brightness
        widget.TextBox(
            fontsize=16,
            text="󰛨",
            padding=5,
            foreground=colors[1],
            font=font,
        ),
        widget.Backlight(
            backlight_name="intel_backlight",
            foreground=colors[1],
            font=font,
            format="{percent:1.0%}",
            padding=4,
        ),
        ## volume
        widget.Volume(
            emoji=True,
            font=font,
            fontsize=16,
            emoji_list=["󰝟", "󰕿", "󰖀", "󰕾"],
            fmt="{}",
            foreground=colors[1],
            mouse_callbacks={
                "Button1": lambda: qtile.cmd_spawn("/usr/bin/pavucontrol")
            },
            padding=4,
        ),
        widget.Volume(
            font=font,
            fmt="{}",
            mute_format="",
            foreground=colors[1],
            mouse_callbacks={
                "Button1": lambda: qtile.cmd_spawn("/usr/bin/pavucontrol")
            },
            padding=4,
        ),
        ## keyboard layout
        # keyboard icon
        widget.TextBox(
            text="󰌌",
            fontsize=18,
            padding=5,
            foreground=colors[1],
        ),
        # keyboardlayout
        widget.KeyboardLayout(
            configured_keyboards=["us", "de qwerty"],
            display_map={"us": "us", "de qwerty": "de"},
            font=font,
            foreground=colors[1],
            update_interval=1,
            fmt="{}",
        ),
        ## battery
        widget.TextBox(
            text="󰂀",
            fontsize=15,
            padding=2,
            foreground=colors[1],
        ),
        widget.Battery(
            discharge_char="",
            charge_char="󱐋",
            format="{char}{percent:1.0%}",
            font=font,
            background=colors[0],
            foreground=colors[1],
            low_percentage=0.20,
            low_foreground=colors[2],
        ),
        ## time
        widget.Clock(
            format=" %d.%m.%Y %H:%M ",
            font=font,
            background=colors[0],
            foreground=colors[1],
        ),
    ]

    desktop_widgets = [
        widget.GroupBox(
            highlight_method="block",
            borderwidth=1,
            this_screen_border=colors[2],
            this_current_screen_border=colors[3],
            active=colors[1],
            inactive=colors[5],
            background=colors[0],
            disable_drag=True,
        ),
        widget.WindowName(
            foreground="#1d2021",
            format="{}",
        ),
        # systray
        widget.Systray(icon_size=20),
        widget.TextBox(text=" "),
        # wifi
        widget.TextBox(
            text=" ",
            fontsize=28,
            foreground=colors[1],
            mouse_callbacks={
                "Button1": lambda: qtile.cmd_spawn("/usr/bin/nm-connection-editor"),
                "Button3": lambda: qtile.cmd_spawn("/usr/bin/blueman-manager"),
            },
        ),
        ## keyboard layout
        # keyboard-icon
        widget.TextBox(
            text="󰌌",
            fontsize=28,
            padding=5,
            foreground=colors[1],
        ),
        # keyboardlayout
        widget.KeyboardLayout(
            configured_keyboards=["us", "de qwerty"],
            display_map={"us": "us", "de qwerty": "de"},
            font=font,
            foreground=colors[1],
            update_interval=1,
            fmt="{}",
        ),
        # date
        widget.Clock(
            format=" %d.%m.%Y %H:%M ",
            font=font,
            background=colors[0],
            foreground=colors[1],
            mouse_callbacks={"Button1": lambda: qtile.cmd_spawn("/usr/bin/calcurse")},
        ),
    ]
    ## return values
    if is_laptop:
        return laptop_widgets, laptop_bar_height
    else:
        return desktop_widgets, desktop_bar_height


## screens settings
widgets, bar_height = get_widgets_and_bar_height()
screens = [
    Screen(
        top=bar.Bar(
            widgets,
            bar_height,
            background=colors[0],
        ),
    ),
]
