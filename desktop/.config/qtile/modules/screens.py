from libqtile import bar
from .widgets import *
from libqtile.config import Screen
from modules.keys import terminal
import os

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    highlight_method="block",
                    borderwidth=1,
                            this_screen_border="#cc241d",
                    this_current_screen_border="#d65d0e",
                    active="#ebdbb2",
                    inactive="#928374",
                    background="#1d2021",
                ),
                widget.WindowName(
                    foreground="#1d2021",
                    format="{}",
                ),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                # systray
                widget.Systray(icon_size=20),
                widget.TextBox(text=" "),
                # wifi
                widget.TextBox(
                    text=" ",
                    fontsize=28,
                    foreground="#ebdbb2",
                    mouse_callbacks={
                        "Button1": lambda: qtile.cmd_spawn(
                            "/usr/bin/nm-connection-editor"
                        )
                    },
                ),
                # volumemixer
                # widget.TextBox(
                #     text=" ",
                #     fontsize=15,
                #     foreground="#ebdbb2",
                #     mouse_callbacks={
                #         "Button1": lambda: qtile.cmd_spawn("/usr/bin/pavucontrol")
                #     },
                # ),
                # keyboard-icon
                widget.TextBox(
                    text="󰌌",
                    fontsize=28,
                    padding=5,
                    foreground="#ebdbb2",
                ),
                # keyboardlayout
                widget.KeyboardLayout(
                    configured_keyboards=["us", "de qwerty"],
                    display_map={"us": "us", "de qwerty": "de"},
                    font="JetBrains Mono",
                    foreground="#ebdbb2",
                    update_interval=1,
                    fmt="{}",
                ),
                # clock / time
                widget.Clock(
                    format=" %d.%m.%Y %H:%M ",
                    font="JetBrains Mono Nerd Font",
                    background="#1d2021",
                    foreground="#ebdbb2",
                    mouse_callbacks={
                        "Button1": lambda: qtile.cmd_spawn("/usr/bin/calcurse")
                    },
                    # mouse_callbacks = {'Button1': lazy.spawn(alacritty + " -e calcurse")},
                ),
            ],
            22,  # height in px
            background="#1d2021",  # background color
        ),
    ),
]
