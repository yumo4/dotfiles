{
  config,
  pkgs,
  ...
}: let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "max";
  home.homeDirectory = "/home/max";
  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
  };
  home.shell.enableFishIntegration = true;
  home.shellAliases = {
    vi = "nvim";
    vim = "nvim";
    fetch = "fastfetch";
    ls = "lsd";
    ll = "lsd -l";
    lst = "tree -C";
    tas = "tmux attach-session -t";
    home-one = "ssh max@192.168.178.65";
  };

  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    gruvbox-gtk-theme
  ];

  xdg.enable = true;

  xdg.configFile.nvim.source = mkOutOfStoreSymlink "/home/max/Projects/dotfiles/dots/.config/nvim";

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".zshrc".source = ../dots/.zshrc;
    ".ideavimrc".source = ../dots/.ideavimrc;
    ".config/alacritty".source = ../dots/.config/alacritty;
    ".config/fastfetch".source = ../dots/.config/fastfetch;
    # ".config/flameshot".source = ../dots/.config/flameshot;
    # ".config/qtile".source = ../dots/.config/qtile;
    # ".config/hypr".source = ../dots/.config/hypr;
    # ".config/waybar".source = ../dots/.config/waybar;
    ".config/rofi".source = ../dots/.config/rofi;
    # ".config/dunst".source = ../dots/.config/dunst;

    ".themes/Gruvbox-Material-Dark".source = ../dots/.themes/Gruvbox-Material-Dark;
    ".icons/Gruvbox-Material-Dark".source = ../dots/.icons/Gruvbox-Material-Dark;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    XCURSOR_SIZE = "24";
    XCURSOR_THEME = "Adwaita";

    # changes this for gtk themes:
    # GTK_THEME = "Gruvbox-Material-Dark";
    GTK_THEME = "Adwaita-dark";
    # GTK_THEME = "gruvbox-gtk-theme";
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    options = ["--cmd cd"];
  };

  programs.tmux = import ./home/tmux.nix {inherit pkgs;};

  programs.ghostty = import ./home/ghostty.nix {inherit pkgs;};

  wayland.windowManager = {
    hyprland = import ./home/hyprland.nix {inherit pkgs;};
  };

  programs.waybar = import ./home/waybar.nix {inherit pkgs;};

  programs.git = {
    enable = true;
    userName = "yumo4";
    userEmail = "maximilian.troe@gmail.com";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };

  programs.fish = import ./home/fish.nix {inherit pkgs;};

  services.syncthing = {
    enable = true;
  };

  services.swaync = {
    enable = true;
  };

  programs.btop = {
    enable = true;
    settings.color_theme = "gruvbox_material_dark";
  };

  qt = {
    enable = true;
  };

  gtk = {
    enable = true;

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    # gtk4.extraConfig = {
    #   gtk-application-prefer-dark-theme = true;
    # };
    theme = {
      # name = "Adwaita-dark";
      # package = pkgs.gnome-themes-extra;
      # package = pkgs.flat-remix-gtk;
      # name = "Flat-Remix-GTK-Grey-Dark";
      # name = "Gruvbox-Material-Dark";
    };
    iconTheme.name = "Gruvbox-Material-Dark";

    font.name = "JetBrainsMono Nerd Font";
  };

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
