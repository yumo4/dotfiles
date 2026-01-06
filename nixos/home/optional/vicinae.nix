{...}: let
in {
  services.vicinae = {
    enable = true;
    systemd = {
      enable = true;
      autoStart = true;
      environment = {
        USE_LAYER_SHELL = 1;
      };
    };
  };

  # config:
  xdg.configFile."vicinae/settings.json".text = builtins.toJSON {
    font = {
      normal = {
        family = "JetBrainsMono NF";
        size = 10;
      };
    };
    theme = {
      dark = {
        name = "gruvbox-dark";
      };
    };
    keybinds = {
      "toggle-action-panel" = "control+K";
    };
    providers = {
      "@1weiho/store.raycast.svgl" = {
        entrypoints = {
          index = {
            alias = "svg";
          };
        };
      };
      "@josephschmitt/store.raycast.gif-search" = {
        entrypoints = {
          search = {
            alias = "gif";
          };
        };
      };
      "@knoopx/store.vicinae.nix" = {
        entrypoints = {
          packages = {
            alias = "nixp";
          };
        };
      };
      "@marcjulian/store.raycast.obsidian" = {
        preferences = {
          removeLatex = false;
          removeLinks = false;
          removeYAML = false;
        };
      };
      applications = {
        entrypoints = {
          "protonvpn-app" = {
            alias = "vpn";
          };
          "syncthing-ui" = {
            alias = "sync";
          };
          vesktop = {
            alias = "discord";
          };
        };
      };
    };
  };

  xdg.configFile."vicinae/vicinae.json".text = builtins.toJSON {
    closeOnFocusLoss = false;
    considerPreedit = false;
    faviconService = "twenty";
    font = {
      normal = "JetBrains Mono";
      size = 10;
    };
    keybinding = "default";
    keybinds = {
      "action.copy" = "control+shift+C";
      "action.copy-name" = "control+shift+.";
      "action.copy-path" = "control+shift+,";
      "action.dangerous-remove" = "control+shift+X";
      "action.duplicate" = "control+D";
      "action.edit" = "control+E";
      "action.edit-secondary" = "control+shift+E";
      "action.move-down" = "control+shift+ARROWDOWN";
      "action.move-up" = "control+shift+ARROWUP";
      "action.new" = "control+N";
      "action.open" = "control+O";
      "action.pin" = "control+shift+P";
      "action.refresh" = "control+R";
      "action.remove" = "control+X";
      "action.save" = "control+S";
      "open-search-filter" = "control+P";
      "open-settings" = "control+,";
      "toggle-action-panel" = "control+K";
    };
    popToRootOnClose = true;
    rootSearch = {
      searchFiles = false;
    };
    theme = {
      name = "gruvbox-dark";
    };
    window = {
      csd = false;
      opacity = 0.98;
      rounding = 10;
    };
  };
}
