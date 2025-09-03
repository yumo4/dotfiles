{
  config,
  lib,
  ...
}: {
  programs.sherlock = {
    enable = true;
    # systemd.enable = true;

    settings = {
      # appearance = {
      #   width = 1000;
      #   height = 600;
      #   gsk_renderer = "cairo";
      #   icon_size = 32;
      #   opacity = 0.95;
      # };

      caching = {
        enable = true;
      };

      default_apps = {
        browser = "zen-beta";
        # calendar_client = "thunderbird";
        teams = "teams-for-linux --enable-features=UseOzonePlatform --ozone-platform=wayland --url {meeting_url}";
        terminal = "ghostty";
      };

      # TODO: revisit when animations work with it
      # runtime = {
      #   daemonize = true;
      # };

      search_bar_icon = {
        enable = true;
      };

      status_bar.enable = true;
    };

    launchers = [
      {
        name = "Weather";
        type = "weather";
        args = {
          location = "Wuerzburg";
          update_interval = 60;
        };
        priority = 1;
        # home = "OnlyHome";
        home = "Search";
        async = true;
        shortcut = false;
        spawn_focus = false;
      }
      {
        name = "App Launcher";
        alias = "app";
        type = "app_launcher";
        args = {};
        priority = 2;
        home = "Home";
      }
      {
        name = "Web Search";
        display_name = "Web Search";
        alias = "ws";
        type = "web_launcher";
        tag_start = "{keyword}";
        tag_end = "{keyword}";
        args = {
          search_engine = "https://unduck.link?q={keyword}";
          icon = "brave";
        };
        priority = 100;
      }
      {
        name = "Calculator";
        type = "calculation";
        args = {
          capabilities = [
            "calc.math"
            "calc.units"
          ];
        };
        priority = 1;
      }
      {
        name = "Clipboard";
        type = "clipboard-execution";
        alias = "cp";
        args = {
          capabilities = [
            "url"
            "colors.all"
            "calc.math"
            "calc.units"
          ];
        };
        priority = 1;
        home = "Home";
      }
      # {
      #   name = "Nix Commands";
      #   alias = "nix";
      #   type = "command";
      #   # spawn_focus = true;
      #   args = {
      #     commands = {
      #       "Search Packages" = {
      #         icon = "nix-snowflake";
      #         exec = "zen-beta https://search.nixos.org/packages?query={keyword}";
      #         search_string = "packages;search;nixpkgs";
      #         tag_start = "search:";
      #         tag_end = "";
      #       };
      #       "Search Options" = {
      #         icon = "nix-snowflake";
      #         exec = "zen-beta https://search.nixos.org/options?query={keyword}";
      #         search_string = "options;config;nixos";
      #         tag_start = "options:";
      #         tag_end = "";
      #       };
      #       "NixOS Wiki" = {
      #         icon = "nix-snowflake";
      #         exec = "zen-beta https://wiki.nixos.org/w/index.php?search={keyword}";
      #         search_string = "wiki;docs;documentation";
      #         tag_start = "wiki:";
      #         tag_end = "";
      #       };
      #       # "Nix Search TV" = {
      #       #   icon = "nix-snowflake";
      #       #   exec = "kitty -e nix-search-tv";
      #       #   search_string = "interactive;search;tv";
      #       # };
      #     };
      #   };
      #   priority = 5;
      # }

      # {
      #   name = "Emoji Picker";
      #   type = "emoji_picker";
      #   args = {
      #     default_skin_tone = "Simpsons";
      #   };
      #   priority = 4;
      #   home = "Search";
      # }
      # {
      #   name = "Kill Process";
      #   alias = "kill";
      #   type = "process";
      #   args = {};
      #   priority = 6;
      #   home = "Search";
      # }
    ];

    aliases = {
      vesktop = {
        name = "Discord";
        #   icon = "discord";
      };
    };

    ignore = ''
      hicolor-icon-theme.desktop
      user-dirs.desktop
      mimeinfo.cache.desktop
      org.freedesktop.IBus.Setup.desktop
      ca.desrt.dconf-editor.desktop
    '';
  };
}
