# {pkgs, ...}: let
{pkgs, ...}:
# hostname = ?
#    if hostname == "chimaera"
#    then "~/Projects/dotfiles/wallpaper/julian-calle-falcon.jpg"
#    else if hostname == "framework"
#    then "~/Projects/dotfiles/wallpaper/friendly-robot-ssd.jpg"
#    else "~/Projects/dotfiles/wallpaper/RMcQ-Deathstar-Construction.png";
# in {
{
  enable = true;
  settings = {
    general = {
      hide_cursor = true;
    };
    # let-in block for path (different on ech machine according to wallpaper)
    background = {
      monitor = "";
      # path = "~/Projects/dotfiles/wallpaper/julian-calle-falcon.jpg";
      path = "~/Projects/dotfiles/wallpaper/RMcQ-Tie-Pilot-MF.png";
      # path = bgpath;
      blur_passes = 2;
      blur_size = 5;
    };
    label = [
      # TIME
      {
        monitor = "";
        text = ''cmd[update:1000] echo -e "$(date +"%H:%M")"'';
        # color = "rgb(928374)";
        color = "rgb(f9f5d7)";
        font_size = 150;
        font_family = "JetBrains Mono Nerd Font Mono ExtraBold";
        position = "0, -420";
        # position = "0, 0%";
        halign = "center";
        valign = "top";
      }
      # DATE
      {
        monitor = "";
        text = ''cmd[update:1000] echo -e "$(date +"%d. %b %A")"'';
        # color = "rgb(928374)";
        color = "rgb(f9f5d7)";
        font_size = 14;
        font_family = "JetBrains Mono Nerd Font Mono ExtraBold";
        position = "0, -130";
        # position = "0, 0%";
        halign = "center";
        valign = "center";
      }
    ];

    input-field = [
      {
        monitor = "";
        size = "200, 30";
        # position = "0, -90";
        position = "0, -40%";
        dots_center = true;
        fade_on_empty = false;
        # inner_color = "rgb(928374)";
        inner_color = "rgb(f9f5d7)";
        font_color = "rgb(1d2021)";
        outline_thickness = 0;
        shadow_passes = 0;
        # rounding = 2;
        placeholder_text = "";
      }
    ];
  };
}
