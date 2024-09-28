from libqtile import layout
from libqtile.config import Match
from modules.theme import colors

layouts = [
    layout.MonadTall(margin=4, border_focus=colors[5], border_normal=colors[0]),
    layout.Max(),
    ## other layouts
    # layout.Columns(border_focus_stack='#d75f5f'),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

floats_kept_above = True
floating_layout = layout.Floating(
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(title="zoom"),
        Match(title="Zoom Workplace - Licensed account"),
    ],
    border_focus=colors[5],
    border_normal=colors[0],
    border_width=2,
)
