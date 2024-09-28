from libqtile import hook
import subprocess
import os


@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser("~/.config/qtile/autostart.sh")
    subprocess.call([home])


## brings floating windows to front
@hook.subscribe.client_focus
def raise_floating_window_on_focus(client):
    if client.floating:
        client.cmd_bring_to_front()


# @hook.subscribe.client_managed
# def ensure_floating_always_on_top(client):
#     if client.floating:
#         client.cmd_bring_to_front()
