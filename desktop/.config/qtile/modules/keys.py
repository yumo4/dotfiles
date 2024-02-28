from libqtile.lazy import lazy
from libqtile.config import Key

mod = "mod4"
terminal = "alacritty"
browser = "brave"

keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.spawn("rofi -show drun"), desc="spawn rofi"),
    Key([mod], "b", lazy.spawn("brave"), desc="spawn brave"),
    Key([mod], "f", lazy.spawn("pcmanfm"), desc="spawn pcmanfm"),
    Key([mod], "v", lazy.spawn(terminal + " -e nvim"), desc="spawn nvim"),
    Key([mod], "o", lazy.spawn("obsidian"), desc="spawn obsidian"),
    Key([mod], "i", lazy.spawn("/home/max/JetBrains/idea"), desc="spawn intellij"),
    Key([mod, "shift"], "i", lazy.spawn("/home/max/JetBrains/webstorm"), desc="spawn Webstorm"),
    Key([mod, "control"], "i", lazy.spawn("/home/max/JetBrains/rustrover"), desc="spawn Rustrover"),
    Key([mod, "control", "shift"], "i", lazy.spawn("/home/max/JetBrains/DataGrip"), desc="spawn Rustrover"),
    Key([mod], "c", lazy.spawn(terminal + " -e calcurse"), desc="spawn intellij"),
    #Key([mod, "shift"], "s", lazy.spawn("flameshot gui"), desc="take screenshot"),
    Key([mod, "shift"], "s", lazy.spawn("/home/max/scripts/screenshot.sh"), desc="take screenshot"),
    Key([mod, "control"], "space", lazy.widget["keyboardlayout"].next_keyboard(), desc="switches to next keyboard layout"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    
    Key([mod, "shift"],
        "h",
        lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key([mod, "shift"],
        "j",
        lazy.layout.shuffle_down(),
        desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"],
        "h",
        lazy.layout.grow(),
        desc="Grow window"),
    Key([mod, "control"],
        "l",
        lazy.layout.shrink(),
        desc="Shrink window"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "control"], "Tab", lazy.window.toggle_floating(), desc="Toggle floating"),


    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift", "control"], "h", lazy.layout.swap_column_left()),
    Key([mod, "shift", "control"], "l", lazy.layout.swap_column_right()),
    Key([mod, "shift"], "space", lazy.layout.flip()),
    Key([mod, "control"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod, "shift"],
        "r",
        lazy.spawncmd(),
        desc="Spawn a command using a prompt widget"),
    Key([], "XF86AudioRaiseVolume",lazy.spawn("amixer set Master 3%+")),
    Key([], "XF86AudioLowerVolume",lazy.spawn("amixer set Master 3%-")),
    Key([], "XF86AudioMute",lazy.spawn("amixer set Master toggle")),
]
