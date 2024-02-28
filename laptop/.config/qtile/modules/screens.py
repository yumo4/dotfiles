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
                                highlight_method='block',
                                borderwidth=1,
                                this_screen_border="#cc241d",
                                this_current_screen_border="#d65d0e",
                                active="#ebdbb2",
                                inactive="#928374",
                                background="#1d2021"),
                   
            widget.WindowName(
                    #foreground='#1d2021',
                    format="{}",
                ),  
            widget.Chord(
                    chords_colors={
                        'launch': ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
             # systray   
             widget.Systray(icon_size = 20),
             widget.TextBox(
                 text=' '
                 ),
            # wifi
            widget.TextBox(
                   text=' ',
                   fontsize=15,
                   foreground='#ebdbb2',
                   mouse_callbacks={
                       'Button1':
                       lambda: qtile.cmd_spawn("/usr/bin/nm-connection-editor")
                       },
                   ),
            widget.Wlan(
                   fontsize=12,
                   foreground='#ebdbb2',
                   font='JetBrains Mono Nerd Font',
                    #mouse_callbacks={'Button1'}:lambda: qtile.cmd_spawn("/usr/bin/nm-connection-editor"),
                   format='{essid}',

                ),

                # brightness
                widget.TextBox(
                    fontsize=16,
                    text="󰛨",
                    padding=5,
                    foreground='#ebdbb2',
                    font='JetBrains Mono Nerd Font',
                ),
                widget.Backlight(
                    backlight_name='intel_backlight',
                    foreground='#ebdbb2',
                    font='JetBrains Mono Nerd Font',
                    format="{percent:1.0%}",
                    padding=4,
                ),
                # volume
                widget.TextBox(
                    text="󰕾",
                    fontsize=16,
                    foreground='#ebdbb2',
                ),
                widget.Volume(
                    #emoji=True,
                    font='JetBrains Mono Nerd Font',
                    emoji_list=['󰝟','','',''],
                    fmt="{}",
                    foreground='#ebdbb2',
                    mouse_callbacks = {'Button1':lambda: qtile.cmd_spawn("/usr/bin/pavucontrol")
                        },
                    padding=4,
                ),              
             # keyboard-icon
                widget.TextBox(
                    text='󰌌',
                    fontsize=18,
                    padding=5,    
                    foreground='#ebdbb2',
                   ),

             # keyboardlayout 
            widget.KeyboardLayout(
             configured_keyboards=['us', 'de qwerty'],
             display_map={'us': 'us', 'de qwerty': 'de'},
             font='JetBrains Mono Nerd Font',
             foreground='#ebdbb2',
             update_interval=1,
             fmt='{}'
            ),
            # brightness
            # battery
            widget.TextBox(
                    text="󰂀",
                    fontsize=15,
                    padding=2,
                    foreground="#ebdbb2",
                    ),
            widget.Battery(
                    discharge_char="",
                    charge_char="󱐋",
                    format="{char}{percent:1.0%}",
                    font='JetBrains Mono Nerd Font',
                    background="#1d2021",
                    foreground='#ebdbb2',
                    low_percentage=0.20,
                    low_foreground="#cc241d",
                ),
               # clock / time    
                widget.Clock(format=' %d.%m.%Y %H:%M ',
                             font='JetBrains Mono Nerd Font',
                             background="#1d2021",
                             foreground='#ebdbb2',
                             ),
            ],
            24,  # height in px
            background="#1d2021"  # background color
        ), ),
]
