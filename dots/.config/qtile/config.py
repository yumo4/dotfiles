### imports ###
import os

from modules.screens import screens
from modules.keys import keys, mod
from modules.groups import groups
from modules.layouts import layouts, floating_layout
from modules.mouse import mouse
from modules.hooks import *

###


### general ###
dgroups_key_binder = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"
wmname = "qtile"
widget_defaults = dict(font="Cascadia Code", fontsize=13, padding=3)
