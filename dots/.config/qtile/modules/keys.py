from libqtile.lazy import lazy
from libqtile.config import Key

mod = "mod4"
terminal = "alacritty"
# browser = "zen-browser"
browser = "brave"
filebrowser = "thunar"

keys = [
    ## windows ##
    # window navigation
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    # move windows
    Key(
        [mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # change window size
    Key([mod, "control"], "h", lazy.layout.grow(), desc="Grow window"),
    Key([mod, "control"], "l", lazy.layout.shrink(), desc="Shrink window"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # toggle floating
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating"),
    # fullscreen
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    # kill window
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    ##
    ## applications ##
    # rofi
    Key([mod], "space", lazy.spawn("rofi -show drun"), desc="spawn rofi"),
    # browser
    Key([mod], "b", lazy.spawn(browser), desc="spawn browser"),
    # filemanager
    Key([mod], "f", lazy.spawn(filebrowser), desc="spawn pcmanfm"),
    # terminal
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # obsidian
    Key([mod], "o", lazy.spawn("obsidian"), desc="spawn obsidian"),
    # intellij
    Key([mod], "i", lazy.spawn("JetBrains/idea"), desc="spawn intellij"),
    # webstorm
    Key([mod, "shift"], "i", lazy.spawn("JetBrains/Webstorm"), desc="spawn Webstorm"),
    # calcurse
    Key([mod], "c", lazy.spawn(terminal + " -e calcurse"), desc="spawn calcurse"),
    ##
    ## other ##
    # screenshot
    Key([mod, "control"], "s", lazy.spawn("flameshot gui"), desc="take screenshot"),
    # screensettings script
    Key(
        [mod],
        "p",
        lazy.spawn(
            "/home/max/Projects/dotfiles/dots/.config/qtile/scripts/screenSettings.sh"
        ),
        desc="change screensettings",
    ),
    # toggle between keyboard layouts
    Key(
        [mod, "control"],
        "space",
        lazy.widget["keyboardlayout"].next_keyboard(),
        desc="switches to next keyboard layout",
    ),
    # reload config
    Key([mod, "control"], "r", lazy.restart(), desc="Restart Qtile"),
    # volume controls
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer set Master 3%+")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer set Master 3%-")),
    Key([], "XF86AudioMute", lazy.spawn("amixer set Master toggle")),
    # media controls
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause")),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next")),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous")),
    Key([], "XF86AudioStop", lazy.spawn("playerctl previous")),
    # brightness controls
    # requires the user to be in the video group
    Key([], "XF86MonBrightnessUp", lazy.spawn("brillo -q -A 2")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brillo -q -U 2")),
]
